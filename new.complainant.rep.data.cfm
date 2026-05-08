<cfscript>
// ****************** Complainant Rep's Information Queries and Variable Settings ******************

// Helper function: Parse city/state/zip from a combined string (e.g., "Washington, DC 20001")
function parseRepCityStateZip(citystzip) {
	var result = { city: "", state: "", zip: "" };
	if (len(trim(arguments.citystzip)) && listLen(arguments.citystzip) > 1) {
		result.city = listFirst(arguments.citystzip);
		result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
		var zipindex = reFind("[0-9]{5}", arguments.citystzip);
		if (zipindex >= 1) {
			result.zip = mid(arguments.citystzip, zipindex, 5);
		}
	}
	return result;
}

// Track whether previously submitted data exists
hasPriorSubmission = (qry_last_submitted_data.recordCount > 0);
</cfscript>

<!--- Query Complainant Rep's name --->
<cfquery name="qry_complainant_rep" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name
	FROM matter a
	INNER JOIN matterentity c ON a.matter_key = c.matter_key
	INNER JOIN entity b ON b.entity_key = c.entity_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 21
	ORDER BY c.start_date DESC
</cfquery>

<cfscript>
if (qry_complainant_rep.recordCount > 0) {

	comp_rep_fname = qry_complainant_rep.first_name;
	comp_rep_lname = qry_complainant_rep.last_name;
</cfscript>

	<!--- Query Complainant Rep's company --->
	<cfquery name="qry_complainant_rep_company" datasource="lawmanager">
		SELECT name
		FROM entity
		WHERE entity_key = <cfqueryparam value="#qry_complainant_rep.entity_key#" cfsqltype="cf_sql_integer">
		  AND entity_type_key = 21
		  AND person_company_flag = 'C'
	</cfquery>

	<cfscript>
	if (qry_complainant_rep_company.recordCount > 0) {
		comp_rep_comp = qry_complainant_rep_company.name;
	} else if (!hasPriorSubmission) {
		comp_rep_comp = "";
	}
	</cfscript>

	<!--- Query Complainant Rep's address --->
	<cfquery name="qry_comp_rep_addr" datasource="lawmanager">
		SELECT a.entity_key,
			   trim(b.street) AS street,
			   trim(b.city) AS city,
			   b.state,
			   trim(b.zip_code) AS zip_code
		FROM entity a
		INNER JOIN address b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_complainant_rep.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfscript>
	if (qry_comp_rep_addr.recordCount > 0) {

		// --- Street ---
		if (len(qry_comp_rep_addr.street)) {
			comp_rep_addr = qry_comp_rep_addr.street;
		} else if (!hasPriorSubmission) {
			comp_rep_addr = "";
		}

		// --- City / State / Zip ---
		// If LM has the data, use it; otherwise parse from prior submission
		needsParse = false;

		if (len(qry_comp_rep_addr.city)) {
			comp_rep_city = qry_comp_rep_addr.city;
		} else {
			needsParse = true;
		}

		if (len(qry_comp_rep_addr.state)) {
			comp_rep_state = qry_comp_rep_addr.state;
		} else {
			needsParse = true;
		}

		if (len(qry_comp_rep_addr.zip_code)) {
			comp_rep_zip = qry_comp_rep_addr.zip_code;
		} else {
			needsParse = true;
		}

		// Parse from prior submission if any field was missing
		if (needsParse && hasPriorSubmission && structKeyExists(variables, "comp_rep_citystzip")) {
			parsed = parseRepCityStateZip(comp_rep_citystzip);
			if (!structKeyExists(variables, "comp_rep_city"))  comp_rep_city  = parsed.city;
			if (!structKeyExists(variables, "comp_rep_state")) comp_rep_state = parsed.state;
			if (!structKeyExists(variables, "comp_rep_zip"))   comp_rep_zip   = parsed.zip;
		}

	} else {
		// No address data in LawManager — fall back to prior submission
		if (hasPriorSubmission && structKeyExists(variables, "comp_rep_citystzip")) {
			parsed = parseRepCityStateZip(comp_rep_citystzip);
			comp_rep_city  = parsed.city;
			comp_rep_state = parsed.state;
			comp_rep_zip   = parsed.zip;
		} else {
			comp_rep_addr  = "";
			comp_rep_city  = "";
			comp_rep_state = "";
			comp_rep_zip   = "";
		}
	}
	</cfscript>

	<!--- Query Complainant Rep's phone --->
	<cfquery name="qry_comp_rep_phone" datasource="lawmanager">
		SELECT a.entity_key, trim(b.phone_number) AS comp_rep_phone
		FROM entity a
		INNER JOIN phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_complainant_rep.entity_key#" cfsqltype="cf_sql_integer">
		  AND b.phone_type_key IN (2, 3, 4, 6)
	</cfquery>

	<cfscript>
	comp_rep_phone = (qry_comp_rep_phone.recordCount > 0) ? qry_comp_rep_phone.comp_rep_phone : "";
	</cfscript>

	<!--- Query Complainant Rep's fax --->
	<cfquery name="qry_comp_rep_fax" datasource="lawmanager">
		SELECT a.entity_key, trim(b.phone_number) AS comp_rep_fax
		FROM entity a
		INNER JOIN phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_complainant_rep.entity_key#" cfsqltype="cf_sql_integer">
		  AND b.phone_type_key = 5
	</cfquery>

	<cfscript>
	if (qry_comp_rep_fax.recordCount > 0) {
		comp_rep_fax = qry_comp_rep_fax.comp_rep_fax;
	} else if (!hasPriorSubmission) {
		comp_rep_fax = "";
	}
	</cfscript>

<cfscript>
} else {
	// --- Complainant Rep not found in LawManager ---
	if (hasPriorSubmission && structKeyExists(variables, "comp_rep_citystzip")) {
		parsed = parseRepCityStateZip(comp_rep_citystzip);
		comp_rep_city  = parsed.city;
		comp_rep_state = parsed.state;
		comp_rep_zip   = parsed.zip;
		comp_rep_phone = "";
	} else {
		comp_rep_fname = "";
		comp_rep_lname = "";
		comp_rep_comp  = "";
		comp_rep_addr  = "";
		comp_rep_city  = "";
		comp_rep_state = "";
		comp_rep_zip   = "";
		comp_rep_phone = "";
		comp_rep_fax   = "";
	}
}
</cfscript>

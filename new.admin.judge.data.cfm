<cfscript>
// ******************** Administrative Judge's Information Queries ********************

// Helper function: Parse city/state/zip from a combined string (e.g., "Washington, DC 20001")
function parseAjCityStateZip(citystzip) {
	var result = { city: "", state: "", zip: "" };
	if (len(trim(arguments.citystzip))) {
		result.city = listFirst(arguments.citystzip);
		if (listLen(arguments.citystzip) >= 2) {
			result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
		}
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

<!--- Query AJ's name --->
<cfquery name="qry_aj" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name
	FROM matter a
	INNER JOIN matterentity c ON a.matter_key = c.matter_key
	INNER JOIN entity b ON b.entity_key = c.entity_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key IN (15, 48, 49, 50, 51, 52)
	ORDER BY c.start_date DESC
</cfquery>

<!--- Run dependent queries only if AJ found --->
<cfif qry_aj.recordCount GT 0>
	<cfquery name="qry_aj_addr" datasource="lawmanager">
		SELECT a.entity_key,
			   trim(initcap(b.street)) AS street,
			   trim(initcap(b.city)) AS city,
			   b.state,
			   trim(b.zip_code) AS zip_code
		FROM entity a
		INNER JOIN address b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_aj.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfquery name="qry_aj_phone" datasource="lawmanager">
		SELECT a.entity_key, trim(b.phone_number) AS aj_phone
		FROM entity a
		INNER JOIN phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_aj.entity_key#" cfsqltype="cf_sql_integer">
		  AND b.phone_type_key IN (2, 3, 4, 6)
	</cfquery>

	<cfquery name="qry_aj_fax" datasource="lawmanager">
		SELECT a.entity_key, trim(b.phone_number) AS aj_fax
		FROM entity a
		INNER JOIN phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_aj.entity_key#" cfsqltype="cf_sql_integer">
		  AND b.phone_type_key = 5
	</cfquery>
</cfif>

<cfscript>
if (qry_aj.recordCount > 0) {

	aj_fname = qry_aj.first_name;
	aj_lname = qry_aj.last_name;

	// --- Address ---
	if (qry_aj_addr.recordCount > 0) {
		aj_addr  = qry_aj_addr.street;
		aj_city  = qry_aj_addr.city;
		aj_state = qry_aj_addr.state;
		aj_zip   = qry_aj_addr.zip_code;
	} else {
		if (hasPriorSubmission && structKeyExists(variables, "ajs_citystzip")) {
			parsed   = parseAjCityStateZip(ajs_citystzip);
			aj_city  = parsed.city;
			aj_state = parsed.state;
			aj_zip   = parsed.zip;
		} else {
			aj_addr  = "";
			aj_city  = "";
			aj_state = "";
			aj_zip   = "";
		}
	}

	// --- Phone ---
	aj_phone = (qry_aj_phone.recordCount > 0) ? qry_aj_phone.aj_phone : "";

	// --- Fax ---
	if (qry_aj_fax.recordCount > 0) {
		aj_fax = qry_aj_fax.aj_fax;
	} else if (!hasPriorSubmission) {
		aj_fax = "";
	}

} else {
	// --- AJ not found in LawManager ---
	if (hasPriorSubmission && structKeyExists(variables, "ajs_citystzip")) {
		parsed   = parseAjCityStateZip(ajs_citystzip);
		aj_city  = parsed.city;
		aj_state = parsed.state;
		aj_zip   = parsed.zip;
		aj_phone = "";
	} else {
		aj_fname = "";
		aj_lname = "";
		aj_addr  = "";
		aj_city  = "";
		aj_state = "";
		aj_zip   = "";
		aj_fax   = "";
		aj_phone = "";
	}
}
</cfscript>

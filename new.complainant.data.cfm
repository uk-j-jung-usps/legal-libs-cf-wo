<cfscript>
// ******************** Complainant's Information Queries and Variable Settings ********************

// Helper function: Parse city/state/zip from a combined string (e.g., "Washington, DC 20001")
function parseCityStateZip(citystzip) {
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

<!--- Query Complainant's name, EID, facility and district --->
<cfquery name="qry_complainant" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name,
		   b.usps_eid AS comp_eid,
		   trim(d.finance_name) AS comp_facility,
		   trim(e.lvl2_desc) || ', ' || trim(e.lvl3_desc) AS comp_district
	FROM lawmanager.matter a
	INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
	INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
	INNER JOIN lawmanager.fncm d ON a.usps_fac_id = d.lm_facility_key
	INNER JOIN lawmanager.matterclientorgsusps e ON a.usps_client_orgs_key = e.usps_client_orgs_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 39
</cfquery>

<!--- Query Complainant's address (only if complainant found) --->
<cfif qry_complainant.recordCount GT 0>
	<cfquery name="qry_comp_addr" datasource="lawmanager">
		SELECT a.entity_key,
			   trim(b.street) AS street,
			   trim(b.city) AS city,
			   b.state,
			   trim(b.zip_code) AS zip_code
		FROM lawmanager.entity a
		INNER JOIN lawmanager.address b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_complainant.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Query Complainant's phone --->
	<cfquery name="qry_comp_phone" datasource="lawmanager">
		SELECT a.entity_key, trim(b.phone_number) AS comp_phone
		FROM entity a
		INNER JOIN phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_complainant.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Query Complainant's SSN --->
	<cfquery name="qry_ssn" datasource="lawmanager">
		SELECT ssn AS comp_ssn
		FROM hr.emp_xref
		WHERE entity_key = <cfqueryparam value="#qry_complainant.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>
</cfif>

<cfscript>
if (qry_complainant.recordCount > 0) {

	// --- Complainant EID ---
	if (len(qry_complainant.comp_eid)) {
		comp_eid = qry_complainant.comp_eid;
	} else if (!hasPriorSubmission) {
		comp_eid = "";
	}

	// --- Complainant name, facility, district (always from LM when available) ---
	comp_fname    = qry_complainant.first_name;
	comp_lname    = qry_complainant.last_name;
	comp_facility = qry_complainant.comp_facility;
	comp_district = qry_complainant.comp_district;

	// --- Address ---
	if (qry_comp_addr.recordCount > 0) {
		// Street
		if (len(qry_comp_addr.street)) {
			comp_addr = qry_comp_addr.street;
		} else if (!hasPriorSubmission) {
			comp_addr = "";
		}

		// City
		if (len(qry_comp_addr.city)) {
			comp_city = qry_comp_addr.city;
		} else if (hasPriorSubmission && structKeyExists(variables, "comp_citystzip")) {
			parsed = parseCityStateZip(comp_citystzip);
			comp_city  = parsed.city;
			comp_state = parsed.state;
			comp_zip   = parsed.zip;
		} else {
			comp_city = "";
		}

		// State (only set if not already parsed above)
		if (!structKeyExists(variables, "comp_state") || len(qry_comp_addr.state)) {
			comp_state = len(qry_comp_addr.state) ? qry_comp_addr.state : "";
		}

		// Zip
		if (!structKeyExists(variables, "comp_zip") || len(qry_comp_addr.zip_code)) {
			comp_zip = len(qry_comp_addr.zip_code) ? qry_comp_addr.zip_code : "";
		}

	} else {
		// No address data in LawManager — fall back to prior submission
		if (hasPriorSubmission && structKeyExists(variables, "comp_citystzip")) {
			parsed = parseCityStateZip(comp_citystzip);
			comp_city  = parsed.city;
			comp_state = parsed.state;
			comp_zip   = parsed.zip;
		} else {
			comp_addr  = "";
			comp_city  = "";
			comp_state = "";
			comp_zip   = "";
		}
	}

	// --- Phone ---
	comp_phone = (qry_comp_phone.recordCount > 0) ? qry_comp_phone.comp_phone : "";

	// --- SSN ---
	if (qry_ssn.recordCount > 0 && len(qry_ssn.comp_ssn)) {
		comp_ssn = qry_ssn.comp_ssn;
	} else if (!hasPriorSubmission) {
		comp_ssn = "";
	}

} else {
	// --- Complainant not found in LawManager ---
	if (hasPriorSubmission && structKeyExists(variables, "comp_citystzip")) {
		parsed = parseCityStateZip(comp_citystzip);
		comp_city  = parsed.city;
		comp_state = parsed.state;
		comp_zip   = parsed.zip;
		comp_phone = "";
	} else {
		comp_eid      = "";
		comp_fname    = "";
		comp_lname    = "";
		comp_facility = "";
		comp_district = "";
		comp_addr     = "";
		comp_city     = "";
		comp_state    = "";
		comp_zip      = "";
		comp_phone    = "";
	}
	comp_ssn = "";
}
</cfscript>

<!--- Query case's agency number --->
<cfquery name="qry_agency_no" datasource="lawmanager">
	SELECT forum_number
	FROM forum
	WHERE matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND venue_type_key = 1101
	  AND forum_type_key = 1
</cfquery>

<cfscript>
if (qry_agency_no.recordCount > 0) {
	agency_no = qry_agency_no.forum_number;
} else if (!hasPriorSubmission) {
	agency_no = "";
}
</cfscript>

<!--- Query case's EEOC number (latest if more than one) --->
<cfquery name="qry_eeoc_no" datasource="lawmanager">
	SELECT forum_number
	FROM forum
	WHERE matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND venue_type_key LIKE '8%'
	ORDER BY forum_number DESC
</cfquery>

<cfscript>
if (qry_eeoc_no.recordCount > 0) {
	eeoc_no = qry_eeoc_no.forum_number;
} else if (!hasPriorSubmission) {
	eeoc_no = "";
}
</cfscript>

<cfscript>
// ==================== Appellant's Information Queries ====================

// Helper: Parse "City, ST Zip" into individual variables
function parseCityStZip(citystzip) {
	var result = { city: "", state: "", zip: "" };
	if (len(trim(arguments.citystzip))) {
		// City is the first comma-delimited item
		result.city = listFirst(arguments.citystzip);
		// State is first 2 chars of second item
		if (listLen(arguments.citystzip) >= 2) {
			result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
		}
		// Zip is the first 5-digit sequence found
		var zipIndex = reFind("[0-9]{5}", arguments.citystzip);
		if (zipIndex >= 1) {
			result.zip = mid(arguments.citystzip, zipIndex, 5);
		}
	}
	return result;
}
</cfscript>

<!--- Query Appellant's name, EID, facility and district from LawManager --->
<cfquery name="qry_appellant" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name,
		   b.usps_eid AS appellant_eid,
		   trim(d.finance_name) AS appellant_facility,
		   trim(e.lvl2_desc) || ', ' || trim(e.lvl3_desc) AS appellant_district
	FROM lawmanager.matter a
	INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
	INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
	INNER JOIN lawmanager.fncm d ON a.usps_fac_id = d.lm_facility_key
	INNER JOIN lawmanager.matterclientorgsusps e ON a.usps_client_orgs_key = e.usps_client_orgs_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 38
</cfquery>

<cfscript>
if (qry_appellant.recordCount > 0) {

	// --- Name, EID, Facility, District ---
	appellant_eid      = len(qry_appellant.appellant_eid) ? qry_appellant.appellant_eid : "";
	appellant_fname    = len(qry_appellant.first_name) ? qry_appellant.first_name : "";
	appellant_lname    = len(qry_appellant.last_name) ? qry_appellant.last_name : "";
	appellant_facility = len(qry_appellant.appellant_facility) ? qry_appellant.appellant_facility : "";
	appellant_district = len(qry_appellant.appellant_district) ? qry_appellant.appellant_district : "";

	// --- Address & Email ---
	qry_appellant_addr = queryExecute("
		SELECT a.entity_key,
			   trim(b.street) AS street,
			   trim(b.city) AS city,
			   b.state,
			   trim(b.zip_code) AS zip_code,
			   c.eaddress AS email
		FROM lawmanager.entity a
		LEFT JOIN lawmanager.address b ON a.entity_key = b.entity_key
		LEFT JOIN lawmanager.eaddress c ON a.entity_key = c.entity_key
		WHERE a.entity_key = :entityKey
	", { entityKey: { value: qry_appellant.entity_key, cfsqltype: "cf_sql_integer" } }, { datasource: "lawmanager" });

	if (qry_appellant_addr.recordCount > 0) {
		appellant_addr = len(qry_appellant_addr.street) ? qry_appellant_addr.street : "";

		if (len(qry_appellant_addr.city)) {
			appellant_city = qry_appellant_addr.city;
		} else if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = parseCityStZip(appellant_citystzip);
			appellant_city = parsed.city;
		} else {
			appellant_city = "";
		}

		if (len(qry_appellant_addr.state)) {
			appellant_state = qry_appellant_addr.state;
		} else if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = parseCityStZip(appellant_citystzip);
			appellant_state = parsed.state;
		} else {
			appellant_state = "";
		}

		if (len(qry_appellant_addr.zip_code)) {
			appellant_zip = qry_appellant_addr.zip_code;
		} else if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = parseCityStZip(appellant_citystzip);
			appellant_zip = parsed.zip;
		} else {
			appellant_zip = "";
		}

		appellant_email = len(qry_appellant_addr.email) ? qry_appellant_addr.email : "";

	} else {
		// No address data from LM — parse from previously submitted citystzip if available
		if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = parseCityStZip(appellant_citystzip);
			appellant_city  = parsed.city;
			appellant_state = parsed.state;
			appellant_zip   = parsed.zip;
		} else {
			appellant_addr  = "";
			appellant_city  = "";
			appellant_state = "";
			appellant_zip   = "";
			appellant_email = "";
		}
	}

	// --- Phone ---
	qry_appellant_phone = queryExecute("
		SELECT trim(b.phone_number) AS appellant_phone
		FROM lawmanager.entity a
		INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = :entityKey
	", { entityKey: { value: qry_appellant.entity_key, cfsqltype: "cf_sql_integer" } }, { datasource: "lawmanager" });

	appellant_phone = (qry_appellant_phone.recordCount > 0) ? qry_appellant_phone.appellant_phone : "";

} else {
	// No appellant found in LawManager — parse from submitted data or initialize empty
	if (structKeyExists(variables, "appellant_citystzip") && len(trim(variables.appellant_citystzip))) {
		parsed = parseCityStZip(appellant_citystzip);
		if (!structKeyExists(variables, "appellant_city"))  { appellant_city  = parsed.city; }
		if (!structKeyExists(variables, "appellant_state")) { appellant_state = parsed.state; }
		if (!structKeyExists(variables, "appellant_zip"))   { appellant_zip   = parsed.zip; }
	}
	// Ensure all appellant variables exist
	defaultVars = "appellant_eid,appellant_ssn,appellant_fname,appellant_lname,appellant_facility,appellant_district,appellant_addr,appellant_city,appellant_state,appellant_zip,appellant_phone,appellant_email";
	for (dv in listToArray(defaultVars)) {
		if (!structKeyExists(variables, dv)) {
			variables[dv] = "";
		}
	}
}
</cfscript>

<!--- Query Appellant's SSN --->
<cfif qry_appellant.recordCount GT 0>
	<cftry>
		<cfquery name="qry_ssn" datasource="lawmanager">
			SELECT ssn AS appellant_ssn
			FROM hr.emp_xref
			WHERE entity_key = <cfqueryparam value="#qry_appellant.entity_key#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfscript>
			if (qry_ssn.recordCount > 0 && len(qry_ssn.appellant_ssn)) {
				appellant_ssn = qry_ssn.appellant_ssn;
			} else if (!structKeyExists(variables, "appellant_ssn")) {
				appellant_ssn = "";
			}
		</cfscript>
	<cfcatch type="database">
		<cfscript>
			if (!structKeyExists(variables, "appellant_ssn")) {
				appellant_ssn = "";
			}
		</cfscript>
	</cfcatch>
	</cftry>
<cfelse>
	<cfscript>
		if (!structKeyExists(variables, "appellant_ssn")) {
			appellant_ssn = "";
		}
	</cfscript>
</cfif>

<!--- Query Docket Number --->
<cfquery name="qry_docket_no" datasource="lawmanager">
	SELECT forum_number
	FROM lawmanager.forum
	WHERE matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND venue_type_key = 700
	  AND forum_type_key = 4
</cfquery>
<cfscript>
	if (qry_docket_no.recordCount > 0) {
		docket_no = qry_docket_no.forum_number;
	} else if (!structKeyExists(variables, "docket_no")) {
		docket_no = "";
	}
</cfscript>

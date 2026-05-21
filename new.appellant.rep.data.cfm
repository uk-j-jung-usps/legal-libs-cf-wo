<cfscript>
// ==================== Appellant Rep's Information Queries ====================

// Helper: Parse "City, ST Zip" into individual variables
function parseRepCityStZip(citystzip) {
	var result = { city: "", state: "", zip: "" };
	if (len(trim(arguments.citystzip))) {
		result.city = listFirst(arguments.citystzip);
		if (listLen(arguments.citystzip) >= 2) {
			result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
		}
		var zipIndex = reFind("[0-9]{5}", arguments.citystzip);
		if (zipIndex >= 1) {
			result.zip = mid(arguments.citystzip, zipIndex, 5);
		}
	}
	return result;
}
</cfscript>

<!--- Query Appellant Rep's name --->
<cfquery name="qry_appellant_rep" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name
	FROM lawmanager.matter a
	INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
	INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 12
</cfquery>

<cfscript>
if (qry_appellant_rep.recordCount > 0) {

	appellant_rep_fname = qry_appellant_rep.first_name;
	appellant_rep_lname = qry_appellant_rep.last_name;

	// --- Company ---
	qry_appellant_rep_company = queryExecute("
		SELECT name
		FROM lawmanager.entity
		WHERE entity_key = :entityKey
		  AND entity_type_key = 12
		  AND person_company_flag = 'C'
	", { entityKey: { value: qry_appellant_rep.entity_key, cfsqltype: "cf_sql_integer" } }, { datasource: "lawmanager" });

	// --- Address ---
	qry_appellant_rep_addr = queryExecute("
		SELECT trim(b.street) AS street,
			   trim(b.city) AS city,
			   b.state,
			   trim(b.zip_code) AS zip_code
		FROM lawmanager.entity a
		LEFT JOIN lawmanager.address b ON a.entity_key = b.entity_key
		WHERE a.entity_key = :entityKey
	", { entityKey: { value: qry_appellant_rep.entity_key, cfsqltype: "cf_sql_integer" } }, { datasource: "lawmanager" });

	// --- Phone (types: 2=business, 3=home, 4=mobile, 6=other) ---
	qry_appellant_rep_phone = queryExecute("
		SELECT trim(b.phone_number) AS appellant_rep_phone
		FROM lawmanager.entity a
		INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = :entityKey
		  AND b.phone_type_key IN (2, 3, 4, 6)
	", { entityKey: { value: qry_appellant_rep.entity_key, cfsqltype: "cf_sql_integer" } }, { datasource: "lawmanager" });

	// --- Fax (type 5) ---
	qry_appellant_rep_fax = queryExecute("
		SELECT trim(b.phone_number) AS appellant_rep_fax
		FROM lawmanager.entity a
		INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = :entityKey
		  AND b.phone_type_key = 5
	", { entityKey: { value: qry_appellant_rep.entity_key, cfsqltype: "cf_sql_integer" } }, { datasource: "lawmanager" });

	// Company
	appellant_rep_company = (qry_appellant_rep_company.recordCount > 0) ? qry_appellant_rep_company.name : "";

	// Address
	if (qry_appellant_rep_addr.recordCount > 0) {
		appellant_rep_addr = len(qry_appellant_rep_addr.street) ? qry_appellant_rep_addr.street : "";

		if (len(qry_appellant_rep_addr.city)) {
			appellant_rep_city = qry_appellant_rep_addr.city;
		} else if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = parseRepCityStZip(appellant_rep_citystzip);
			appellant_rep_city = parsed.city;
		} else {
			appellant_rep_city = "";
		}

		if (len(qry_appellant_rep_addr.state)) {
			appellant_rep_state = qry_appellant_rep_addr.state;
		} else if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = parseRepCityStZip(appellant_rep_citystzip);
			appellant_rep_state = parsed.state;
		} else {
			appellant_rep_state = "";
		}

		if (len(qry_appellant_rep_addr.zip_code)) {
			appellant_rep_zip = qry_appellant_rep_addr.zip_code;
		} else if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = parseRepCityStZip(appellant_rep_citystzip);
			appellant_rep_zip = parsed.zip;
		} else {
			appellant_rep_zip = "";
		}
	} else {
		// No address in LM — parse from previously submitted citystzip if available
		if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = parseRepCityStZip(appellant_rep_citystzip);
			appellant_rep_city  = parsed.city;
			appellant_rep_state = parsed.state;
			appellant_rep_zip   = parsed.zip;
		} else {
			appellant_rep_addr  = "";
			appellant_rep_city  = "";
			appellant_rep_state = "";
			appellant_rep_zip   = "";
		}
	}

	// Phone
	appellant_rep_phone = (qry_appellant_rep_phone.recordCount > 0) ? qry_appellant_rep_phone.appellant_rep_phone : "";

	// Fax
	appellant_rep_fax = (qry_appellant_rep_fax.recordCount > 0) ? qry_appellant_rep_fax.appellant_rep_fax : "";

} else {
	// No appellant rep found in LawManager — parse from submitted data or initialize empty
	if (structKeyExists(variables, "appellant_rep_citystzip") && len(trim(variables.appellant_rep_citystzip))) {
		parsed = parseRepCityStZip(appellant_rep_citystzip);
		if (!structKeyExists(variables, "appellant_rep_city"))  { appellant_rep_city  = parsed.city; }
		if (!structKeyExists(variables, "appellant_rep_state")) { appellant_rep_state = parsed.state; }
		if (!structKeyExists(variables, "appellant_rep_zip"))   { appellant_rep_zip   = parsed.zip; }
	}
	// Ensure all appellant rep variables exist
	defaultVars = "appellant_rep_fname,appellant_rep_lname,appellant_rep_company,appellant_rep_addr,appellant_rep_city,appellant_rep_state,appellant_rep_zip,appellant_rep_phone,appellant_rep_fax";
	for (dv in listToArray(defaultVars)) {
		if (!structKeyExists(variables, dv)) {
			variables[dv] = "";
		}
	}
}
</cfscript>

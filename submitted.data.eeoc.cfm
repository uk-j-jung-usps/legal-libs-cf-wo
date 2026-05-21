<!--- Query data fields from the last submission by the user for this matterkey --->
<cfquery name="qry_last_submitted_data" datasource="lawmanager">
	SELECT tempvar_key, tempvar_key_name, tempvar_value
	FROM lawmanager.cmft_matterkey_pairs
	WHERE matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	ORDER BY tempvar_key
</cfquery>

<cfscript>
	// Map tempvar_key values to their corresponding variable names
	tempvarMap = {
		"1":  "agency_no",
		"2":  "ajs_citystzip",
		"3":  "aj_addr",
		"4":  "aj_fax",
		"5":  "aj_fname",
		"6":  "aj_lname",
		"7":  "aj_title",
		"8":  "attorney_name",
		"9":  "attorney_title",
		"11": "comp_addr",
		"13": "comp_citystzip",
		"14": "comp_eid",
		"15": "comp_facility",
		"16": "comp_fname",
		"17": "comp_lname",
		"18": "comp_rep_addr",
		"20": "comp_rep_comp",
		"21": "comp_rep_fname",
		"22": "comp_rep_lname",
		"23": "comp_ssn",
		"24": "comp_district",
		"25": "dist_mgr",
		"26": "eeoc_no",
		"27": "eeoc_office",
		"29": "comp_pronoun1",
		"30": "comp_pronoun2",
		"31": "hr_mgr_dist",
		"32": "hr_mgr",
		"34": "alo_addr1",
		"35": "alo_addr2",
		"37": "alo_fax",
		"38": "alo_office",
		"40": "alo_phone",
		"42": "lr_mgr",
		"44": "comp_prefix",
		"45": "ohna_dist",
		"51": "paralgl_name",
		"54": "comp_rep_fax",
		"55": "comp_rep_citystzip",
		"56": "comp_rep_prefix",
		"61": "admin_assist",
		"116": "date"
	};

	// Loop through query results and set variables dynamically
	for (row in qry_last_submitted_data) {
		keyVal = toString(row.tempvar_key);
		if (structKeyExists(tempvarMap, keyVal) && len(row.tempvar_key)) {
			variables[tempvarMap[keyVal]] = len(trim(row.tempvar_value)) ? trim(row.tempvar_value) : "";
		}
	}

	// Ensure all mapped variables exist (even if not returned by the query)
	for (key in tempvarMap) {
		if (!structKeyExists(variables, tempvarMap[key])) {
			variables[tempvarMap[key]] = "";
		}
	}
</cfscript>

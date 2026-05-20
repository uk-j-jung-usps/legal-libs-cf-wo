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
		"2":  "ajs_citystzip",
		"3":  "aj_addr",
		"4":  "aj_fax",
		"5":  "aj_fname",
		"6":  "aj_lname",
		"7":  "aj_title",
		"8":  "attorney_name",
		"9":  "attorney_title",
		"25": "dist_mgr",
		"29": "appellant_pronoun1",
		"30": "appellant_pronoun2",
		"31": "hr_mgr_dist",
		"32": "hr_mgr",
		"34": "alo_addr1",
		"35": "alo_addr2",
		"37": "alo_fax",
		"38": "alo_office",
		"40": "alo_phone",
		"42": "lr_mgr",
		"43": "appellant_email",
		"45": "ohna_dist",
		"51": "paralgl_name",
		"55": "appellant_rep_citystzip",
		"61": "admin_assist",
		"64": "appellant_fname",
		"65": "appellant_lname",
		"66": "appellant_facility",
		"67": "appellant_addr",
		"68": "appellant_citystzip",
		"69": "appellant_phone",
		"70": "appellant_ssn",
		"71": "appellant_eid",
		"72": "appellant_prefix",
		"73": "appellant_rep_fname",
		"74": "appellant_rep_lname",
		"75": "appellant_rep_company",
		"76": "appellant_rep_addr",
		"77": "appellant_rep_prefix",
		"78": "appellant_rep_phone",
		"79": "appellant_rep_fax",
		"80": "mspb_office",
		"81": "docket_no"
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

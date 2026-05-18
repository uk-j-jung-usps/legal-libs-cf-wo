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
		"8":   "attorney_name",
		"9":   "attorney_title",
		"24":  "plaintiff_district",
		"25":  "dist_mgr",
		"31":  "hr_mgr_dist",
		"32":  "hr_mgr",
		"34":  "alo_addr1",
		"35":  "alo_addr2",
		"37":  "alo_fax",
		"38":  "alo_office",
		"40":  "alo_phone",
		"42":  "lr_mgr",
		"45":  "ohna_dist",
		"51":  "paralgl_name",
		"55":  "plaintiff_rep_citystzip",
		"61":  "admin_assist",
		"73":  "plaintiff_rep_fname",
		"74":  "plaintiff_rep_lname",
		"75":  "plaintiff_rep_company",
		"76":  "plaintiff_rep_addr",
		"78":  "plaintiff_rep_phone",
		"79":  "plaintiff_rep_fax",
		"86":  "plaintiff_fname",
		"87":  "plaintiff_lname",
		"88":  "plaintiff_ssn",
		"89":  "plaintiff_eid",
		"90":  "plaintiff_addr",
		"91":  "plaintiff_citystzip",
		"92":  "plaintiff_facility",
		"93":  "defendant_name",
		"94":  "ausa_fname",
		"95":  "ausa_lname",
		"96":  "ausa_title",
		"97":  "ausa_district",
		"98":  "ausa_addr1",
		"99":  "ausa_addr2",
		"100": "ausa_citystzip",
		"101": "ausa_fax",
		"102": "ausa_prefix",
		"103": "plaintiff_email",
		"104": "ausa_bar_no",
		"106": "ausa_email",
		"107": "ausa_chief_fname",
		"108": "ausa_chief_lname",
		"109": "ausa_us_attorney",
		"110": "ausa_phone",
		"111": "plaintiff_rep_email",
		"112": "case_no"
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

<cfscript>
	// Correct mixed casing for specific attorney name
	if (attorney_name EQ "Sherilyn Deninno") {
		attorney_name = "Sherilyn DeNinno";
	}
</cfscript>

<!--- Retrieve all relevant template variables for DCT (matter_type_key = 5) --->
<cfquery name="qry_cmft_tempvars" datasource="lawmanager">
	SELECT tempvar_key, tempvar_name
	FROM lawmanager.cmft_tempvars
	WHERE (matter_type_key = <cfqueryparam value="5" cfsqltype="cf_sql_integer">
	       OR matter_type_key = <cfqueryparam value="0" cfsqltype="cf_sql_integer">)
	  AND control IS NULL
</cfquery>

<!--- Retrieve attorney email from EADDRESS table for the selected attorney name --->
<cfquery name="qry_attny_email" datasource="lawmanager">
	SELECT c.eaddress
	FROM entity a
	INNER JOIN cmft_entity_wo b ON a.entity_key = b.entity_key
	INNER JOIN eaddress c ON a.entity_key = c.entity_key
	WHERE b.attorney_name = <cfqueryparam value="#attorney_name#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfscript>
	// -------------------------------------------------------------------------
	// Proper-case transformations for uppercase names before inserts
	// -------------------------------------------------------------------------

	// Helper: Title-case a string, handling "&" specially
	function toProperCase(required string input) {
		var result = reReplace(lCase(arguments.input), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL");

		// Handle character after "&"
		var ampPos = find("&", result, 1);
		if (ampPos NEQ 0 AND ampPos LT len(result)) {
			result = left(result, ampPos) & uCase(mid(result, ampPos + 1, 1)) & mid(result, ampPos + 2, len(result) - ampPos - 1);
		}

		return result;
	}

	plaintiff_facility = toProperCase(plaintiff_facility);
	plaintiff_district = toProperCase(plaintiff_district);

	// -------------------------------------------------------------------------
	// Concatenate city/state/zip groups
	// -------------------------------------------------------------------------
	function formatCityStateZip(required string city, required string state, required string zip) {
		if (len(trim(arguments.city)) AND len(trim(arguments.state)) AND len(trim(arguments.zip))) {
			return trim(arguments.city) & ", " & trim(arguments.state) & " " & trim(arguments.zip);
		}
		return trim(arguments.city) & trim(arguments.state) & trim(arguments.zip);
	}

	plaintiff_citystzip     = formatCityStateZip(plaintiff_city, plaintiff_state, plaintiff_zip);
	plaintiff_rep_citystzip = formatCityStateZip(plaintiff_rep_city, plaintiff_rep_state, plaintiff_rep_zip);

	// -------------------------------------------------------------------------
	// Map ALO office to zip code
	// -------------------------------------------------------------------------
	officeZipMap = {
		"Denver":        "80299-5555",
		"Long Beach":    "90802-2496",
		"Salt Lake":     "84070-2716",
		"San Francisco": "94188-3790",
		"San Diego":     "92197-4400",
		"Seattle":       "98124-3686"
	};
	alo_zip = structKeyExists(officeZipMap, trim(alo_office)) ? officeZipMap[trim(alo_office)] : "";

	// -------------------------------------------------------------------------
	// Build tempvar_key -> value mapping
	// -------------------------------------------------------------------------
	tempvarValueMap = {
		"8":   attorney_name,
		"9":   attorney_title,
		"24":  plaintiff_district,
		"25":  dist_mgr,
		"31":  hr_mgr_dist,
		"32":  hr_mgr,
		"34":  alo_addr1,
		"35":  alo_addr2,
		"36":  "West Law Office",
		"37":  alo_fax,
		"38":  alo_office,
		"39":  "CA",
		"40":  alo_phone,
		"41":  alo_zip,
		"42":  lr_mgr,
		"45":  ohna_dist,
		"51":  paralgl_name,
		"52":  "David P. Steiner",
		"53":  "DAVID P. STEINER",
		"55":  plaintiff_rep_citystzip,
		"60":  matternumber,
		"73":  plaintiff_rep_fname,
		"74":  plaintiff_rep_lname,
		"75":  plaintiff_rep_company,
		"76":  plaintiff_rep_addr,
		"78":  plaintiff_rep_phone,
		"79":  plaintiff_rep_fax,
		"86":  plaintiff_fname,
		"87":  plaintiff_lname,
		"88":  plaintiff_ssn,
		"89":  plaintiff_eid,
		"90":  plaintiff_addr,
		"91":  plaintiff_citystzip,
		"92":  plaintiff_facility,
		"93":  defendant_name,
		"94":  ausa_fname,
		"95":  ausa_lname,
		"96":  ausa_title,
		"97":  ausa_district,
		"98":  ausa_addr1,
		"99":  ausa_addr2,
		"100": ausa_citystzip,
		"101": ausa_fax,
		"102": ausa_prefix,
		"103": plaintiff_email,
		"104": ausa_bar_no,
		"106": ausa_email,
		"107": ausa_chief_fname,
		"108": ausa_chief_lname,
		"109": ausa_us_attorney,
		"110": ausa_phone,
		"111": plaintiff_rep_email,
		"112": case_no,
		"158": qry_attny_email.eaddress
	};
</cfscript>

<!--- Insert all template variable pairs into CMFT_MATTERKEY_PAIRS --->
<cfloop query="qry_cmft_tempvars">

	<cfset currentKey = trim(qry_cmft_tempvars.tempvar_key)>
	<cfset currentValue = structKeyExists(tempvarValueMap, currentKey) ? tempvarValueMap[currentKey] : "none">

	<cfquery name="insert_cmft_matterkey_pairs" datasource="lawmanager">
		INSERT INTO lawmanager.cmft_matterkey_pairs
			(matter_key, tempvar_key_name, tempvar_value, tempvar_key, date_added, added_by)
		VALUES (
			<cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">,
			<cfqueryparam value="#qry_cmft_tempvars.tempvar_name#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#currentValue#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#qry_cmft_tempvars.tempvar_key#" cfsqltype="cf_sql_integer">,
			<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
			<cfqueryparam value="#owner_key#" cfsqltype="cf_sql_integer" null="#NOT len(trim(owner_key))#">
		)
	</cfquery>

</cfloop>

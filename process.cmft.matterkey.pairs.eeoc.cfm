<cfscript>
	// -------------------------------------------------------------------------
	// Template #78 logic: Determine sentence wording based on Comp Rep presence
	// -------------------------------------------------------------------------
	if (len(trim(comp_rep_fname)) AND len(trim(comp_rep_lname))
		AND trim(comp_rep_fname) NEQ "Pro Se" AND trim(comp_rep_lname) NEQ "Pro Se") {
		sentence_extra = "If Complainant has never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	} else {
		sentence_extra = "If you have never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	}

	// Correct mixed casing for specific attorney name
	if (attorney_name EQ "Sherilyn Deninno") {
		attorney_name = "Sherilyn DeNinno";
	}
</cfscript>

<!--- Retrieve all relevant template variables for EEOC (matter_type_key = 9) --->
<cfquery name="qry_cmft_tempvars" datasource="lawmanager">
	SELECT tempvar_key, tempvar_name
	FROM lawmanager.cmft_tempvars
	WHERE (matter_type_key = <cfqueryparam value="9" cfsqltype="cf_sql_integer">
	       OR matter_type_key = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
	       OR matter_type_key IS NULL)
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

	// Helper: Title-case a string, handling "&" and "'" specially
	function toProperCase(required string input) {
		var result = reReplace(lCase(arguments.input), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL");

		// Handle character after "&"
		var ampPos = find("&", result, 1);
		if (ampPos NEQ 0 AND ampPos LT len(result)) {
			result = left(result, ampPos) & uCase(mid(result, ampPos + 1, 1)) & mid(result, ampPos + 2, len(result) - ampPos - 1);
		}

		return result;
	}

	comp_city     = toProperCase(comp_city);
	comp_facility = toProperCase(comp_facility);
	comp_district = toProperCase(comp_district);

	// -------------------------------------------------------------------------
	// Concatenate city/state/zip groups
	// -------------------------------------------------------------------------
	function formatCityStateZip(required string city, required string state, required string zip) {
		if (len(trim(arguments.city)) AND len(trim(arguments.state)) AND len(trim(arguments.zip))) {
			return trim(arguments.city) & ", " & trim(arguments.state) & " " & trim(arguments.zip);
		}
		return trim(arguments.city) & trim(arguments.state) & trim(arguments.zip);
	}

	aj_citystatezip       = formatCityStateZip(aj_city, aj_state, aj_zip);
	comp_citystatezip     = formatCityStateZip(comp_city, comp_state, comp_zip);
	comp_rep_citystatezip = formatCityStateZip(comp_rep_city, comp_rep_state, comp_rep_zip);

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
	if (structKeyExists(officeZipMap, trim(alo_office))) {
		alo_zip = officeZipMap[trim(alo_office)];
	}

	// Fix known address formatting issue
	if (isDefined("alo_addr1") AND alo_addr1 EQ "1300 Evans Ave., Rm 217,P.O. Box 883790") {
		alo_addr1 = "1300 Evans Ave., Rm 217, P.O. Box 883790";
	}

	// -------------------------------------------------------------------------
	// Build tempvar_key -> value mapping
	// -------------------------------------------------------------------------
	tempvarValueMap = {
		"1":   agency_no,
		"2":   aj_citystatezip,
		"3":   aj_addr,
		"4":   aj_fax,
		"5":   aj_fname,
		"6":   aj_lname,
		"7":   aj_title,
		"8":   attorney_name,
		"9":   attorney_title,
		"11":  comp_addr,
		"13":  comp_citystatezip,
		"14":  comp_eid,
		"15":  comp_facility,
		"16":  comp_fname,
		"17":  comp_lname,
		"18":  comp_rep_addr,
		"20":  comp_rep_comp,
		"21":  comp_rep_fname,
		"22":  comp_rep_lname,
		"23":  comp_ssn,
		"24":  comp_district,
		"25":  dist_mgr,
		"26":  eeoc_no,
		"27":  eeoc_office,
		"29":  comp_pronoun1,
		"30":  comp_pronoun2,
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
		"44":  comp_prefix,
		"45":  ohna_dist,
		"51":  paralgl_name,
		"52":  "David P. Steiner",
		"53":  "DAVID P. STEINER",
		"54":  comp_rep_fax,
		"55":  comp_rep_citystatezip,
		"56":  comp_rep_prefix,
		"57":  uCase(comp_fname),
		"58":  uCase(comp_lname),
		"59":  uCase(eeoc_office),
		"60":  matternumber,
		"61":  admin_assist,
		"62":  uCase(aj_citystatezip),
		"63":  uCase(aj_addr),
		"116": dateFormat(now(), "mmmm dd, yyyy"),
		"158": qry_attny_email.eaddress,
		"161": sentence_extra,
		"162": comp_city,
		"163": comp_zip
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

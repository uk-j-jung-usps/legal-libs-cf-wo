<cfscript>
	// -------------------------------------------------------------------------
	// Conditional sentence for template #78 (appellant rep check)
	// -------------------------------------------------------------------------
	if (len(trim(appellant_rep_fname)) && len(trim(appellant_rep_lname))
		&& trim(appellant_rep_fname) NEQ "Pro Se" && trim(appellant_rep_lname) NEQ "Pro Se") {
		sentence_extra = "If Appellant has never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	} else {
		sentence_extra = "If you have never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	}

	// Correct mixed casing for specific attorney name
	if (attorney_name EQ "Sherilyn Deninno") {
		attorney_name = "Sherilyn DeNinno";
	}
</cfscript>

<!--- Retrieve all relevant template variables for MSPB (matter_type_key = 8) --->
<cfquery name="qry_cmft_tempvars" datasource="lawmanager">
	SELECT tempvar_key, tempvar_name
	FROM lawmanager.cmft_tempvars
	WHERE (matter_type_key = <cfqueryparam value="8" cfsqltype="cf_sql_integer">
	       OR matter_type_key = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
	       OR matter_type_key IS NULL)
	  AND control IS NULL
</cfquery>

<!--- Retrieve attorney email from EADDRESS table for the selected attorney name --->
<cfquery name="qry_attny_email" datasource="lawmanager">
	SELECT c.eaddress
	FROM lawmanager.entity a
	INNER JOIN lawmanager.cmft_entity_wo b ON a.entity_key = b.entity_key
	INNER JOIN lawmanager.eaddress c ON a.entity_key = c.entity_key
	WHERE b.attorney_name = <cfqueryparam value="#attorney_name#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfscript>
	// -------------------------------------------------------------------------
	// Proper-case transformations for uppercase names before inserts
	// -------------------------------------------------------------------------
	function toProperCase(required string input) {
		var result = reReplace(lCase(arguments.input), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL");
		// Handle character after "&"
		var ampPos = find("&", result, 1);
		if (ampPos NEQ 0 AND ampPos LT len(result)) {
			result = left(result, ampPos) & uCase(mid(result, ampPos + 1, 1)) & mid(result, ampPos + 2, len(result) - ampPos - 1);
		}
		return result;
	}

	appellant_city     = toProperCase(appellant_city);
	appellant_facility = toProperCase(appellant_facility);
	appellant_district = toProperCase(appellant_district);

	// -------------------------------------------------------------------------
	// Concatenate city/state/zip groups
	// -------------------------------------------------------------------------
	function formatCityStateZip(required string city, required string state, required string zip) {
		if (len(trim(arguments.city)) AND len(trim(arguments.state)) AND len(trim(arguments.zip))) {
			return trim(arguments.city) & ", " & trim(arguments.state) & " " & trim(arguments.zip);
		}
		return trim(arguments.city) & trim(arguments.state) & trim(arguments.zip);
	}

	aj_citystatezip            = formatCityStateZip(aj_city, aj_state, aj_zip);
	appellant_citystatezip     = formatCityStateZip(appellant_city, appellant_state, appellant_zip);
	appellant_rep_citystatezip = formatCityStateZip(appellant_rep_city, appellant_rep_state, appellant_rep_zip);

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
	// Build tempvar_key -> value mapping for MSPB
	// -------------------------------------------------------------------------
	tempvarValueMap = {
		"2":   aj_citystatezip,
		"3":   aj_addr,
		"4":   aj_fax,
		"5":   aj_fname,
		"6":   aj_lname,
		"7":   aj_title,
		"8":   attorney_name,
		"9":   attorney_title,
		"24":  appellant_district,
		"25":  dist_mgr,
		"29":  appellant_pronoun1,
		"30":  appellant_pronoun2,
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
		"43":  appellant_email,
		"45":  ohna_dist,
		"51":  paralgl_name,
		"52":  "David P. Steiner",
		"53":  "DAVID P. STEINER",
		"55":  appellant_rep_citystatezip,
		"60":  matternumber,
		"61":  admin_assist,
		"62":  uCase(aj_citystatezip),
		"63":  uCase(aj_addr),
		"64":  appellant_fname,
		"65":  appellant_lname,
		"66":  appellant_facility,
		"67":  appellant_addr,
		"68":  appellant_citystatezip,
		"69":  appellant_phone,
		"70":  appellant_ssn,
		"71":  appellant_eid,
		"72":  appellant_prefix,
		"73":  appellant_rep_fname,
		"74":  appellant_rep_lname,
		"75":  appellant_rep_company,
		"76":  appellant_rep_addr,
		"77":  appellant_rep_prefix,
		"78":  appellant_rep_phone,
		"79":  appellant_rep_fax,
		"80":  mspb_office,
		"81":  docket_no,
		"83":  uCase(appellant_fname),
		"84":  uCase(appellant_lname),
		"85":  uCase(mspb_office),
		"158": qry_attny_email.eaddress,
		"161": sentence_extra,
		"164": appellant_city,
		"165": appellant_zip
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

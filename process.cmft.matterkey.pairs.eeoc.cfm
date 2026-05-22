<cfscript>
	// Instantiate EEOC matterkey pairs component
	eeocPairsComponent = new components.process_cmft_matterkey_pairs_eeoc_component();

	// -------------------------------------------------------------------------
	// Template #78 logic: Determine sentence wording based on Comp Rep presence
	// -------------------------------------------------------------------------
	if (len(trim(comp_rep_fname)) && len(trim(comp_rep_lname))
		&& trim(comp_rep_fname) != "Pro Se" && trim(comp_rep_lname) != "Pro Se") {
		sentence_extra = "If Complainant has never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	} else {
		sentence_extra = "If you have never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	}

	// Correct mixed casing for specific attorney name
	if (attorney_name == "Sherilyn Deninno") {
		attorney_name = "Sherilyn DeNinno";
	}

	// Retrieve all relevant template variables for EEOC (matter_type_key = 9)
	qry_cmft_tempvars = eeocPairsComponent.getTempVars();

	// Retrieve attorney email
	qry_attny_email = eeocPairsComponent.getAttorneyEmail(attorney_name);
	attny_email = (qry_attny_email.recordCount > 0) ? qry_attny_email.eaddress : "";

	// -------------------------------------------------------------------------
	// Proper-case transformations for uppercase names before inserts
	// -------------------------------------------------------------------------
	comp_city     = eeocPairsComponent.toProperCase(comp_city);
	comp_facility = eeocPairsComponent.toProperCase(comp_facility);
	comp_district = eeocPairsComponent.toProperCase(comp_district);

	// -------------------------------------------------------------------------
	// Concatenate city/state/zip groups
	// -------------------------------------------------------------------------
	aj_citystatezip       = eeocPairsComponent.formatCityStateZip(aj_city, aj_state, aj_zip);
	comp_citystatezip     = eeocPairsComponent.formatCityStateZip(comp_city, comp_state, comp_zip);
	comp_rep_citystatezip = eeocPairsComponent.formatCityStateZip(comp_rep_city, comp_rep_state, comp_rep_zip);

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
	if (isDefined("alo_addr1") && alo_addr1 == "1300 Evans Ave., Rm 217,P.O. Box 883790") {
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
		"158": attny_email,
		"161": sentence_extra,
		"162": comp_city,
		"163": comp_zip
	};

	// -------------------------------------------------------------------------
	// Insert all template variable pairs into CMFT_MATTERKEY_PAIRS
	// -------------------------------------------------------------------------
	for (row in qry_cmft_tempvars) {
		currentKey = trim(row.tempvar_key);
		currentValue = structKeyExists(tempvarValueMap, currentKey) ? tempvarValueMap[currentKey] : "none";

		eeocPairsComponent.insertMatterkeyPair(
			matterKey      = matterkey,
			tempvarKeyName = row.tempvar_name,
			tempvarValue   = currentValue,
			tempvarKey     = row.tempvar_key,
			ownerKey       = owner_key
		);
	}
</cfscript>

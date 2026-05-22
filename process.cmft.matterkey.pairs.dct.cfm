<cfscript>
	// Instantiate DCT matterkey pairs component
	dctPairsComponent = new components.process_cmft_matterkey_pairs_dct_component();

	// Correct mixed casing for specific attorney name
	if (attorney_name == "Sherilyn Deninno") {
		attorney_name = "Sherilyn DeNinno";
	}

	// Retrieve all relevant template variables for DCT (matter_type_key = 5)
	qry_cmft_tempvars = dctPairsComponent.getTempVars();

	// Retrieve attorney email
	qry_attny_email = dctPairsComponent.getAttorneyEmail(attorney_name);
	attny_email = (qry_attny_email.recordCount > 0) ? qry_attny_email.eaddress : "";

	// -------------------------------------------------------------------------
	// Proper-case transformations for uppercase names before inserts
	// -------------------------------------------------------------------------
	plaintiff_facility = dctPairsComponent.toProperCase(plaintiff_facility);
	plaintiff_district = dctPairsComponent.toProperCase(plaintiff_district);

	// -------------------------------------------------------------------------
	// Concatenate city/state/zip groups
	// -------------------------------------------------------------------------
	plaintiff_citystzip     = dctPairsComponent.formatCityStateZip(plaintiff_city, plaintiff_state, plaintiff_zip);
	plaintiff_rep_citystzip = dctPairsComponent.formatCityStateZip(plaintiff_rep_city, plaintiff_rep_state, plaintiff_rep_zip);

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
		"158": attny_email
	};

	// -------------------------------------------------------------------------
	// Insert all template variable pairs into CMFT_MATTERKEY_PAIRS
	// -------------------------------------------------------------------------
	for (row in qry_cmft_tempvars) {
		currentKey = trim(row.tempvar_key);
		currentValue = structKeyExists(tempvarValueMap, currentKey) ? tempvarValueMap[currentKey] : "none";

		dctPairsComponent.insertMatterkeyPair(
			matterKey      = matterkey,
			tempvarKeyName = row.tempvar_name,
			tempvarValue   = currentValue,
			tempvarKey     = row.tempvar_key,
			ownerKey       = owner_key
		);
	}
</cfscript>

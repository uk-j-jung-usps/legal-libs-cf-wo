<cfscript>
	// Instantiate MSPB matterkey pairs component
	mspbPairsComponent = new components.process_cmft_matterkey_pairs_mspb_component();

	// -------------------------------------------------------------------------
	// Conditional sentence for template #78 (appellant rep check)
	// -------------------------------------------------------------------------
	if (len(trim(appellant_rep_fname)) && len(trim(appellant_rep_lname))
		&& trim(appellant_rep_fname) != "Pro Se" && trim(appellant_rep_lname) != "Pro Se") {
		sentence_extra = "If Appellant has never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	} else {
		sentence_extra = "If you have never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.";
	}

	// Correct mixed casing for specific attorney name
	if (attorney_name == "Sherilyn Deninno") {
		attorney_name = "Sherilyn DeNinno";
	}

	// -------------------------------------------------------------------------
	// Retrieve template variables and attorney email
	// -------------------------------------------------------------------------
	qry_cmft_tempvars = mspbPairsComponent.getTempVars();
	qry_attny_email   = mspbPairsComponent.getAttorneyEmail(attorney_name);

	// -------------------------------------------------------------------------
	// Proper-case transformations for uppercase names before inserts
	// -------------------------------------------------------------------------
	appellant_city     = mspbPairsComponent.toProperCase(appellant_city);
	appellant_facility = mspbPairsComponent.toProperCase(appellant_facility);
	appellant_district = mspbPairsComponent.toProperCase(appellant_district);

	// -------------------------------------------------------------------------
	// Concatenate city/state/zip groups
	// -------------------------------------------------------------------------
	aj_citystatezip            = mspbPairsComponent.formatCityStateZip(aj_city, aj_state, aj_zip);
	appellant_citystatezip     = mspbPairsComponent.formatCityStateZip(appellant_city, appellant_state, appellant_zip);
	appellant_rep_citystatezip = mspbPairsComponent.formatCityStateZip(appellant_rep_city, appellant_rep_state, appellant_rep_zip);

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
		"158": (qry_attny_email.recordCount > 0) ? qry_attny_email.eaddress : "",
		"161": sentence_extra,
		"164": appellant_city,
		"165": appellant_zip
	};

	// -------------------------------------------------------------------------
	// Insert all template variable pairs into CMFT_MATTERKEY_PAIRS
	// -------------------------------------------------------------------------
	for (row in qry_cmft_tempvars) {
		currentKey   = trim(row.tempvar_key);
		currentValue = structKeyExists(tempvarValueMap, currentKey) ? tempvarValueMap[currentKey] : "none";

		mspbPairsComponent.insertMatterkeyPair(
			matterKey    = matterkey,
			tempvarKeyName = row.tempvar_name,
			tempvarValue = currentValue,
			tempvarKey   = row.tempvar_key,
			ownerKey     = owner_key
		);
	}
</cfscript>

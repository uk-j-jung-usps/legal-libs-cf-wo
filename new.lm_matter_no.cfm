<cfscript>
	// Variable Initialization
	aceid = mid(AUTH_USER, 5, 6);
	if (len(trim(aceid)) EQ 0) {
		aceid = "dd32j0";
	}

	matterNumber = uCase(form.matter_no);

    //create and get component from wo_eeoc_component
    woComponent = new components.wo_eeoc_component();
    qry_matter_no = woComponent.qryMatterNo(matterNumber);

	// If no matching matter found, redirect with error
	if (qry_matter_no.recordCount EQ 0) {
		location("new.case.files.home.cfm?matternoerror=Y", false);
	}

	mKey       = qry_matter_no.matter_key;
	mTypeKey   = qry_matter_no.matter_type_key;
	mPrefix    = qry_matter_no.matter_prefix;

	// Pre-build query strings for use in routing
	qsWithPrefix    = woComponent.buildQS(mKey, matterNumber, mTypeKey, mPrefix, true);
	qsWithoutPrefix = woComponent.buildQS(mKey, matterNumber, mTypeKey, mPrefix, false);

	// Route based on matter_type_key and matter_prefix
	switch (mTypeKey) {

		case 9: // EEOC
			switch (mPrefix) {
				case "WI":
					location("wi/.newmaster.file.detail.display.eeoc_WI.cfm?" & qsWithPrefix, false);
					break;
				case "SL":
					location("sl/.newmaster.file.detail.display.eeoc_SL.cfm?" & qsWithPrefix, false);
					break;
				default: // SF, WO, etc.
					location("new.master.file.detail.display.eeoc.cfm?" & qsWithPrefix, false);
					break;
			}
			break;

		case 8: // MSPB
			switch (mPrefix) {
				case "WI":
					location("wi/legallibs_message_mspb.cfm", false);
					break;
				case "SL":
					location("sl/master.file.detail.display.mspb_SL.cfm?" & qsWithPrefix, false);
					break;
				default: // SF, WO
					location("new.master.file.detail.display.mspb.cfm?" & qsWithoutPrefix, false);
					break;
			}
			break;

		case 5: // District Court
			switch (mPrefix) {
				case "WI":
					location("wi/legallibs_message_district_court.cfm", false);
					break;
				case "SL":
					location("sl/master.file.detail.display.dct_SL.cfm?" & qsWithoutPrefix, false);
					break;
				default: // SF, WO
					location("new.master.file.detail.display.dct.cfm?" & qsWithoutPrefix, false);
					break;
			}
			break;

		case 1: // Advice
			// handled below via query
			break;

		default:
			location("new.master.file.detail.display.other.cfm", false);
			break;
	}


// Advice (matter_type_key = 1): check for subpoena category

if (mTypeKey EQ 1) {
	
        woComponentAdviceSubpoena = new components.wo_eeoc_component();
        qry_advice_subpoena = woComponentAdviceSubpoena.qryAdviceSubpoena(matterNumber);

        matterKey = encodeForURL(qry_advice_subpoena.matter_key);
        matterTypeKey = encodeForURL(qry_advice_subpoena.matter_type_key);
        matterName = encodeForURL(qry_advice_subpoena.matter_name);
        baseParams = "matterkey=#matterKey#&matternumber=#matterNumber#&mattertypekey=#matterTypeKey#&mattername=#matterName#";
    
		if (qry_advice_subpoena.recordCount) {
			location("master.file.detail.display.advice_fssc.cfm?" & baseParams, false);
		} else {
			location("master.file.detail.display.other.cfm", false);
		}
	
}
</cfscript>

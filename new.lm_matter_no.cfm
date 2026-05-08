<cfscript>
	// Variable Initialization
	aceid = mid(AUTH_USER, 5, 6);
	if (len(trim(aceid)) EQ 0) {
		aceid = "dd32j0";
	}

	matterNumber = uCase(form.matter_no);
</cfscript>

<!--- Look up the matter by matter number --->
<cfquery name="qry_matter_no" datasource="lawmanager">
	SELECT substr(matter_number, 1, 2) AS matter_prefix,
	       matter_key,
	       matter_type_key
	FROM matter
	WHERE matter_number = <cfqueryparam value="#matterNumber#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfscript>
	// If no matching matter found, redirect with error
	if (qry_matter_no.recordCount EQ 0) {
		location("case.files.home.cfm?matternoerror=Y", false);
	}

	mKey       = qry_matter_no.matter_key;
	mTypeKey   = qry_matter_no.matter_type_key;
	mPrefix    = qry_matter_no.matter_prefix;

	// Helper: build standard query string params
	function buildQS(includePrefix = true) {
		var qs = "matterkey=" & encodeForURL(mKey)
		       & "&matternumber=" & encodeForURL(matterNumber)
		       & "&mattertypekey=" & encodeForURL(mTypeKey);
		if (arguments.includePrefix) {
			qs &= "&matter_prefix=" & encodeForURL(mPrefix);
		}
		return qs;
	}

	// Route based on matter_type_key and matter_prefix
	switch (mTypeKey) {

		case 9: // EEOC
			switch (mPrefix) {
				case "WI":
					location("wi/master.file.detail.display.eeoc_WI.cfm?" & buildQS(), false);
					break;
				case "SL":
					location("sl/master.file.detail.display.eeoc_SL.cfm?" & buildQS(), false);
					break;
				default: // SF, WO, etc.
					location("master.file.detail.display.eeoc.cfm?" & buildQS(), false);
					break;
			}
			break;

		case 8: // MSPB
			switch (mPrefix) {
				case "WI":
					location("wi/legallibs_message_mspb.cfm", false);
					break;
				case "SL":
					location("sl/master.file.detail.display.mspb_SL.cfm?" & buildQS(), false);
					break;
				default: // SF, WO
					location("master.file.detail.display.mspb.cfm?" & buildQS(false), false);
					break;
			}
			break;

		case 5: // District Court
			switch (mPrefix) {
				case "WI":
					location("wi/legallibs_message_district_court.cfm", false);
					break;
				case "SL":
					location("sl/master.file.detail.display.dct_SL.cfm?" & buildQS(false), false);
					break;
				default: // SF, WO
					location("master.file.detail.display.dct.cfm?" & buildQS(false), false);
					break;
			}
			break;

		case 1: // Advice
			// handled below via query
			break;

		default:
			location("master.file.detail.display.other.cfm", false);
			break;
	}
</cfscript>

<!--- Advice (matter_type_key = 1): check for subpoena category --->
<cfif mTypeKey EQ 1>
	<cfquery name="qry_advice_subpoena" datasource="lawmanager">
		SELECT a.matter_key, a.matter_type_key, a.matter_name
		FROM matter a
		INNER JOIN mattercategoryusps b ON a.matter_key = b.matter_key
		WHERE a.matter_number = <cfqueryparam value="#matterNumber#" cfsqltype="cf_sql_varchar">
		  AND b.category_type_key = <cfqueryparam value="8" cfsqltype="cf_sql_integer">
		  AND b.subcategory_type_key = <cfqueryparam value="199" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfscript>
		if (qry_advice_subpoena.recordCount) {
			location("master.file.detail.display.advice_fssc.cfm?" & buildQS()
				& "&mattername=" & encodeForURL(qry_advice_subpoena.matter_name), false);
		} else {
			location("master.file.detail.display.other.cfm", false);
		}
	</cfscript>
</cfif>

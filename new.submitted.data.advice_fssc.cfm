<cfscript>
/*
	Retrieve previously submitted Advice-FSSC template data for a given matter_key.
	Populates form variables from cmft_matterkey_pairs and radio button answers
	from CMFT_DYNAMIC_ANS so the form can be pre-filled on re-entry.
*/

// Query non-question data fields from the last submission
qry_last_submitted_data = queryExecute(
	"SELECT tempvar_key, tempvar_key_name, tempvar_value
	 FROM lawmanager.cmft_matterkey_pairs
	 WHERE matter_key = :matterKey
	 ORDER BY tempvar_key",
	{ matterKey = { value = url.matterkey, cfsqltype = "cf_sql_integer" } },
	{ datasource = "lawmanager" }
);

// Query previously submitted radio-button answers
qry_last_submitted_data_answers = queryExecute(
	"SELECT dynamic_quest_key, answer
	 FROM lawmanager.CMFT_DYNAMIC_ANS
	 WHERE matter_key = :matterKey
	 ORDER BY dynamic_quest_key",
	{ matterKey = { value = url.matterkey, cfsqltype = "cf_sql_integer" } },
	{ datasource = "lawmanager" }
);

// Mapping of tempvar_key to variable name for non-question fields
tempvarFieldMap = {
	"34"  = "alo_addr1",
	"35"  = "alo_addr2",
	"37"  = "alo_fax",
	"38"  = "alo_office",
	"40"  = "alo_phone",
	"41"  = "alo_zip",
	"51"  = "paralgl_name",
	"112" = "case_no",
	"113" = "sentence1a",
	"114" = "sentence1b",
	"115" = "subfor",
	"116" = "date",
	"117" = "recvd_date",
	"118" = "provide",
	"119" = "sentence2a",
	"120" = "sentence2b",
	"121" = "via",
	"122" = "recipient_addr",
	"123" = "recipient_name",
	"124" = "recipient_citystzip",
	"125" = "case_name",
	"126" = "work_order_no",
	"127" = "customer_name",
	"128" = "po_loc_lkn_box",
	"129" = "tracking_no",
	"130" = "non_para",
	"131" = "fax_no"
};

// Initialize all mapped variables to empty
for (varName in tempvarFieldMap) {
	variables[tempvarFieldMap[varName]] = "";
}

// Populate variables from query results
for (row in qry_last_submitted_data) {
	var keyStr = toString(row.tempvar_key);
	if (structKeyExists(tempvarFieldMap, keyStr)) {
		variables[tempvarFieldMap[keyStr]] = trim(row.tempvar_value);
	}
}

// Initialize answer variables
answer1 = "";
answer3 = "";
answer4 = "";
answer5 = "";
answer6 = "";
answer7 = "";
answer8 = "";
answer11 = "";

// Populate answers from query results
for (row in qry_last_submitted_data_answers) {
	var questKey = toString(row.dynamic_quest_key);
	if (listFind("1,3,4,5,6,7,8,11", questKey)) {
		variables["answer#questKey#"] = trim(row.answer);
	}
}

// Parse recipient_citystzip into city, state, zip components
recipient_city = "";
recipient_state = "";
recipient_zip = "";
via1 = "";

if (qry_last_submitted_data.recordCount GT 0) {
	if (isDefined("recipient_citystzip") && len(trim(recipient_citystzip))) {
		recipient_city = listFirst(recipient_citystzip);
		if (listLen(recipient_citystzip) GTE 2) {
			recipient_state = left(trim(listGetAt(recipient_citystzip, 2)), 2);
		}
		var zipIndex = reFind("[0-9]{5}", recipient_citystzip);
		if (zipIndex GTE 1) {
			recipient_zip = mid(recipient_citystzip, zipIndex, 5);
		}
	}
}
</cfscript>

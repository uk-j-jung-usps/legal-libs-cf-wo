<cfscript>
// Insert user-selected answers to template questions per user/matterkey
cfinclude(template="new.advice_fssc_cmft_dynamic_ans_insert.cfm");

// Insert a single record in cmft_selected_templates for advice FSSC template per user/matterkey
cfinclude(template="new.advice_fssc_cmft_selected_templates_insert.cfm");

// Retrieve all relevant template variables for Advice-FSSC
qry_cmft_tempvars = queryExecute(
	"SELECT tempvar_key, tempvar_name
	 FROM lawmanager.cmft_tempvars
	 WHERE matter_type_key = :matterTypeKey
		OR tempvar_key IN (:k112, :k34, :k35, :k36, :k37, :k38, :k39, :k40, :k41, :k51, :k60)",
	{
		matterTypeKey = { value = 1, cfsqltype = "cf_sql_integer" },
		k112 = { value = 112, cfsqltype = "cf_sql_integer" },
		k34  = { value = 34, cfsqltype = "cf_sql_integer" },
		k35  = { value = 35, cfsqltype = "cf_sql_integer" },
		k36  = { value = 36, cfsqltype = "cf_sql_integer" },
		k37  = { value = 37, cfsqltype = "cf_sql_integer" },
		k38  = { value = 38, cfsqltype = "cf_sql_integer" },
		k39  = { value = 39, cfsqltype = "cf_sql_integer" },
		k40  = { value = 40, cfsqltype = "cf_sql_integer" },
		k41  = { value = 41, cfsqltype = "cf_sql_integer" },
		k51  = { value = 51, cfsqltype = "cf_sql_integer" },
		k60  = { value = 60, cfsqltype = "cf_sql_integer" }
	},
	{ datasource = "lawmanager" }
);

// Initialize SUBFOR variable based on answer to question 9 (subpoena type)
subfor = "";
if (isDefined("answer1")) {
	switch (trim(answer1)) {
		case "1": subfor = "Deposition Testimony"; break;
		case "2": subfor = "Records Production"; break;
		case "3": subfor = "Deposition Testimony and Production of Documents"; break;
	}
}

// Initialize PROVIDE variable based on answer to question 10
provide = "";
if (isDefined("answer10")) {
	switch (trim(answer10)) {
		case "4": provide = "Provide testimony"; break;
		case "5": provide = "Provide testimony and records"; break;
		case "9": provide = "Provide records"; break;
	}
}

// Initialize sentence variables based on answer to question 11
sentence1a = "";
sentence1b = "";
sentence2a = "";
sentence2b = "";
if (isDefined("answer11") && answer11 EQ "1") {
	sentence1a = "and the United States Attorney for the Central District of California";
	sentence1b = "with a written statement pursuant to 39 C.F.R. §265.12(c)(2) that";
	sentence2a = "and to the United States Attorney c/o Leon W. Weidman, Chief, Civil Division";
	sentence2b = "300 North Los Angeles Street, Room 7516, Los Angeles, CA 90012";
}

// Helper: Convert text to proper case (Title Case)
function toProperCase(str) {
	if (!len(trim(arguments.str))) return "";
	return reReplace(lCase(arguments.str), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL");
}

// Convert relevant fields to proper case
param name="case_name" default="";
param name="recipient_name" default="";
param name="recipient_addr" default="";
param name="recipient_city" default="";
param name="customer_name" default="";
param name="po_loc_lkn_box" default="";
param name="work_order_no" default="";
param name="alo_addr1" default="";
param name="alo_office" default="";
param name="alo_addr2" default="";
param name="alo_fax" default="";
param name="alo_phone" default="";
param name="alo_zip" default="";
param name="fax_no" default="";
param name="tracking_no" default="";
param name="via" default="";
param name="recvd_date" default="";
param name="matternumber" default="";
param name="case_no" default="";

case_name = toProperCase(case_name);
recipient_name = toProperCase(recipient_name);
recipient_addr = toProperCase(recipient_addr);
recipient_city = toProperCase(recipient_city);
customer_name = toProperCase(customer_name);
po_loc_lkn_box = toProperCase(po_loc_lkn_box);

// Concatenate city, state, zip for display
recipient_citystatezip = "";
if (len(trim(recipient_city)) && len(trim(recipient_state)) && len(trim(recipient_zip))) {
	recipient_citystatezip = recipient_city & ", " & uCase(recipient_state) & " " & recipient_zip;
} else {
	recipient_citystatezip = recipient_city & recipient_state & recipient_zip;
}

// Set zip code based on selected office
officeZipMap = {
	"Long Beach": "90802-2496",
	"San Francisco": "94188-3790",
	"San Diego": "92197-4400"
};
if (structKeyExists(officeZipMap, trim(alo_office))) {
	alo_zip = officeZipMap[trim(alo_office)];
}

// Fix spacing issue in address
if (alo_addr1 EQ "1300 Evans Ave., Rm 217,P.O. Box 883790") {
	alo_addr1 = "1300 Evans Ave., Rm 217, P.O. Box 883790";
}

// Clear fax/tracking based on dispatch method selection
switch (via) {
	case "Via USPS Priority Mail w/Tracking":
		fax_no = "";
		break;
	case "Via Fax":
		tracking_no = "";
		break;
	case "Via First Class Mail":
		fax_no = "";
		tracking_no = "";
		break;
}

// Build a mapping of tempvar_key to their values for insertion
today = now();
tempvarValueMap = {
	"34"  = alo_addr1,
	"35"  = alo_addr2,
	"36"  = "West Law Office",
	"37"  = alo_fax,
	"38"  = alo_office,
	"39"  = "CA",
	"40"  = alo_phone,
	"41"  = alo_zip,
	"60"  = matternumber,
	"112" = case_no,
	"113" = sentence1a,
	"114" = sentence1b,
	"115" = subfor,
	"116" = dateFormat(today, "mmmm d, yyyy"),
	"117" = dateFormat(recvd_date, "mmmm d, yyyy"),
	"118" = provide,
	"119" = sentence2a,
	"120" = sentence2b,
	"121" = via,
	"122" = recipient_addr,
	"123" = recipient_name,
	"124" = recipient_citystatezip,
	"125" = case_name,
	"126" = work_order_no,
	"127" = customer_name,
	"128" = po_loc_lkn_box,
	"129" = tracking_no,
	"131" = fax_no
};

// Insert all relevant variables into CMFT_MATTERKEY_PAIRS table
for (row in qry_cmft_tempvars) {
	var keyStr = toString(row.tempvar_key);
	var tempValue = structKeyExists(tempvarValueMap, keyStr) ? tempvarValueMap[keyStr] : "none";

	queryExecute(
		"INSERT INTO lawmanager.CMFT_MATTERKEY_PAIRS
			(matter_key, tempvar_key_name, tempvar_value, tempvar_key, date_added, added_by)
		 VALUES
			(:matterKey, :tempvarKeyName, :tempvarValue, :tempvarKey, SYSDATE, :ownerKey)",
		{
			matterKey    = { value = matterkey, cfsqltype = "cf_sql_integer" },
			tempvarKeyName = { value = row.tempvar_name, cfsqltype = "cf_sql_varchar" },
			tempvarValue = { value = tempValue, cfsqltype = "cf_sql_varchar" },
			tempvarKey   = { value = row.tempvar_key, cfsqltype = "cf_sql_integer" },
			ownerKey     = { value = owner_key, cfsqltype = "cf_sql_integer" }
		},
		{ datasource = "lawmanager" }
	);
}
</cfscript>

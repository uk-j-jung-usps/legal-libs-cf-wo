<cfscript>
// ******************** Administrative Judge's Information Queries ********************

// Helper function: Parse city/state/zip from a combined string (e.g., "Washington, DC 20001")
function parseAjCityStateZip(citystzip) {
	var result = { city: "", state: "", zip: "" };
	if (len(trim(arguments.citystzip))) {
		result.city = listFirst(arguments.citystzip);
		if (listLen(arguments.citystzip) >= 2) {
			result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
		}
		var zipindex = reFind("[0-9]{5}", arguments.citystzip);
		if (zipindex >= 1) {
			result.zip = mid(arguments.citystzip, zipindex, 5);
		}
	}
	return result;
}

// Track whether previously submitted data exists
hasPriorSubmission = (qry_last_submitted_data.recordCount > 0);

// Instantiate admin judge component for data access
adminJudgeComponent = new components.admin_judge_component();

// Query AJ's name
qry_aj = adminJudgeComponent.getAdminJudge(url.matterkey);

// Run dependent queries only if AJ found
if (qry_aj.recordCount GT 0) {
	qry_aj_addr  = adminJudgeComponent.getEntityAddress(qry_aj.entity_key);
	qry_aj_phone = adminJudgeComponent.getEntityPhone(qry_aj.entity_key, "2,3,4,6");
	qry_aj_fax   = adminJudgeComponent.getEntityFax(qry_aj.entity_key);
}

if (qry_aj.recordCount > 0) {

	aj_fname = qry_aj.first_name;
	aj_lname = qry_aj.last_name;

	if (qry_aj_addr.recordCount > 0) {
		aj_addr  = qry_aj_addr.street;
		aj_city  = qry_aj_addr.city;
		aj_state = qry_aj_addr.state;
		aj_zip   = qry_aj_addr.zip_code;
	} else {
		if (hasPriorSubmission && structKeyExists(variables, "ajs_citystzip")) {
			parsed   = parseAjCityStateZip(ajs_citystzip);
			aj_city  = parsed.city;
			aj_state = parsed.state;
			aj_zip   = parsed.zip;
		} else {
			aj_addr  = "";
			aj_city  = "";
			aj_state = "";
			aj_zip   = "";
		}
	}

	// --- Phone ---
	aj_phone = (qry_aj_phone.recordCount > 0) ? qry_aj_phone.phone_number : "";

	// --- Fax ---
	if (qry_aj_fax.recordCount > 0) {
		aj_fax = qry_aj_fax.fax_number;
	} else if (!hasPriorSubmission) {
		aj_fax = "";
	}

} else {
	// --- AJ not found in LawManager ---
	if (hasPriorSubmission && structKeyExists(variables, "ajs_citystzip")) {
		parsed   = parseAjCityStateZip(ajs_citystzip);
		aj_city  = parsed.city;
		aj_state = parsed.state;
		aj_zip   = parsed.zip;
		aj_phone = "";
	} else {
		aj_fname = "";
		aj_lname = "";
		aj_addr  = "";
		aj_city  = "";
		aj_state = "";
		aj_zip   = "";
		aj_fax   = "";
		aj_phone = "";
	}
}
</cfscript>

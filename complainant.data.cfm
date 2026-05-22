<cfscript>
// ******************** Complainant's Information Queries and Variable Settings ********************

// Instantiate complainant data component
compComponent = new components.complainant_data_component();

// Track whether previously submitted data exists
hasPriorSubmission = (qry_last_submitted_data.recordCount > 0);

// Query Complainant's name, EID, facility and district
qry_complainant = compComponent.getComplainant(url.matterkey);

if (qry_complainant.recordCount > 0) {

	// Run dependent queries
	qry_comp_addr  = compComponent.getComplainantAddress(qry_complainant.entity_key);
	qry_comp_phone = compComponent.getComplainantPhone(qry_complainant.entity_key);
	qry_ssn        = compComponent.getComplainantSSN(qry_complainant.entity_key);

	// --- Complainant EID ---
	if (len(qry_complainant.comp_eid)) {
		comp_eid = qry_complainant.comp_eid;
	} else if (!hasPriorSubmission) {
		comp_eid = "";
	}

	// --- Complainant name, facility, district (always from LM when available) ---
	comp_fname    = qry_complainant.first_name;
	comp_lname    = qry_complainant.last_name;
	comp_facility = qry_complainant.comp_facility;
	comp_district = qry_complainant.comp_district;

	// --- Address ---
	if (qry_comp_addr.recordCount > 0) {
		// Street
		if (len(qry_comp_addr.street)) {
			comp_addr = qry_comp_addr.street;
		} else if (!hasPriorSubmission) {
			comp_addr = "";
		}

		// City
		if (len(qry_comp_addr.city)) {
			comp_city = qry_comp_addr.city;
		} else if (hasPriorSubmission && structKeyExists(variables, "comp_citystzip")) {
			parsed = compComponent.parseCityStateZip(comp_citystzip);
			comp_city  = parsed.city;
			comp_state = parsed.state;
			comp_zip   = parsed.zip;
		} else {
			comp_city = "";
		}

		// State (only set if not already parsed above)
		if (!structKeyExists(variables, "comp_state") || len(qry_comp_addr.state)) {
			comp_state = len(qry_comp_addr.state) ? qry_comp_addr.state : "";
		}

		// Zip
		if (!structKeyExists(variables, "comp_zip") || len(qry_comp_addr.zip_code)) {
			comp_zip = len(qry_comp_addr.zip_code) ? qry_comp_addr.zip_code : "";
		}

	} else {
		// No address data in LawManager — fall back to prior submission
		if (hasPriorSubmission && structKeyExists(variables, "comp_citystzip")) {
			parsed = compComponent.parseCityStateZip(comp_citystzip);
			comp_city  = parsed.city;
			comp_state = parsed.state;
			comp_zip   = parsed.zip;
		} else {
			comp_addr  = "";
			comp_city  = "";
			comp_state = "";
			comp_zip   = "";
		}
	}

	// --- Phone ---
	comp_phone = (qry_comp_phone.recordCount > 0) ? qry_comp_phone.phone_number : "";

	// --- SSN ---
	if (qry_ssn.recordCount > 0 && len(qry_ssn.comp_ssn)) {
		comp_ssn = qry_ssn.comp_ssn;
	} else if (!hasPriorSubmission) {
		comp_ssn = "";
	}

} else {
	// --- Complainant not found in LawManager ---
	if (hasPriorSubmission && structKeyExists(variables, "comp_citystzip")) {
		parsed = compComponent.parseCityStateZip(comp_citystzip);
		comp_city  = parsed.city;
		comp_state = parsed.state;
		comp_zip   = parsed.zip;
		comp_phone = "";
	} else {
		comp_eid      = "";
		comp_fname    = "";
		comp_lname    = "";
		comp_facility = "";
		comp_district = "";
		comp_addr     = "";
		comp_city     = "";
		comp_state    = "";
		comp_zip      = "";
		comp_phone    = "";
	}
	comp_ssn = "";
}

// --- Agency Number ---
qry_agency_no = compComponent.getAgencyNumber(url.matterkey);
if (qry_agency_no.recordCount > 0) {
	agency_no = qry_agency_no.forum_number;
} else if (!hasPriorSubmission) {
	agency_no = "";
}

// --- EEOC Number ---
qry_eeoc_no = compComponent.getEeocNumber(url.matterkey);
if (qry_eeoc_no.recordCount > 0) {
	eeoc_no = qry_eeoc_no.forum_number;
} else if (!hasPriorSubmission) {
	eeoc_no = "";
}
</cfscript>

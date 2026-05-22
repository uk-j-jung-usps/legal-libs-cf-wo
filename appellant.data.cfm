<cfscript>
// ==================== Appellant's Information Queries ====================

// Instantiate appellant component for data access
appellantComponent = new components.appellant_component();

// Query Appellant's name, EID, facility, district from LawManager
qry_appellant = appellantComponent.getAppellant(url.matterkey);

if (qry_appellant.recordCount > 0) {

	// --- Name, EID, Facility, District ---
	appellant_eid      = len(qry_appellant.appellant_eid) ? qry_appellant.appellant_eid : "";
	appellant_fname    = len(qry_appellant.first_name) ? qry_appellant.first_name : "";
	appellant_lname    = len(qry_appellant.last_name) ? qry_appellant.last_name : "";
	appellant_facility = len(qry_appellant.appellant_facility) ? qry_appellant.appellant_facility : "";
	appellant_district = len(qry_appellant.appellant_district) ? qry_appellant.appellant_district : "";

	// --- Address & Email ---
	qry_appellant_addr = appellantComponent.getAppellantAddress(qry_appellant.entity_key);

	if (qry_appellant_addr.recordCount > 0) {
		appellant_addr = len(qry_appellant_addr.street) ? qry_appellant_addr.street : "";

		if (len(qry_appellant_addr.city)) {
			appellant_city = qry_appellant_addr.city;
		} else if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = appellantComponent.parseCityStZip(appellant_citystzip);
			appellant_city = parsed.city;
		} else {
			appellant_city = "";
		}

		if (len(qry_appellant_addr.state)) {
			appellant_state = qry_appellant_addr.state;
		} else if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = appellantComponent.parseCityStZip(appellant_citystzip);
			appellant_state = parsed.state;
		} else {
			appellant_state = "";
		}

		if (len(qry_appellant_addr.zip_code)) {
			appellant_zip = qry_appellant_addr.zip_code;
		} else if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = appellantComponent.parseCityStZip(appellant_citystzip);
			appellant_zip = parsed.zip;
		} else {
			appellant_zip = "";
		}

		appellant_email = len(qry_appellant_addr.email) ? qry_appellant_addr.email : "";

	} else {
		// No address data from LM — parse from previously submitted citystzip if available
		if (structKeyExists(variables, "appellant_citystzip") && len(appellant_citystzip)) {
			parsed = appellantComponent.parseCityStZip(appellant_citystzip);
			appellant_city  = parsed.city;
			appellant_state = parsed.state;
			appellant_zip   = parsed.zip;
		} else {
			appellant_addr  = "";
			appellant_city  = "";
			appellant_state = "";
			appellant_zip   = "";
			appellant_email = "";
		}
	}

	// --- Phone ---
	qry_appellant_phone = appellantComponent.getAppellantPhone(qry_appellant.entity_key);

	appellant_phone = (qry_appellant_phone.recordCount > 0) ? qry_appellant_phone.phone_number : "";

	// --- SSN ---
	try {
		qry_ssn = appellantComponent.getAppellantSSN(qry_appellant.entity_key);
		if (qry_ssn.recordCount > 0 && len(qry_ssn.appellant_ssn)) {
			appellant_ssn = qry_ssn.appellant_ssn;
		} else if (!structKeyExists(variables, "appellant_ssn")) {
			appellant_ssn = "";
		}
	} catch (database e) {
		if (!structKeyExists(variables, "appellant_ssn")) {
			appellant_ssn = "";
		}
	}

} else {
	// No appellant found in LawManager — parse from submitted data or initialize empty
	if (structKeyExists(variables, "appellant_citystzip") && len(trim(variables.appellant_citystzip))) {
		parsed = appellantComponent.parseCityStZip(appellant_citystzip);
		if (!structKeyExists(variables, "appellant_city"))  { appellant_city  = parsed.city; }
		if (!structKeyExists(variables, "appellant_state")) { appellant_state = parsed.state; }
		if (!structKeyExists(variables, "appellant_zip"))   { appellant_zip   = parsed.zip; }
	}
	// Ensure all appellant variables exist
	defaultVars = "appellant_eid,appellant_ssn,appellant_fname,appellant_lname,appellant_facility,appellant_district,appellant_addr,appellant_city,appellant_state,appellant_zip,appellant_phone,appellant_email";
	for (dv in listToArray(defaultVars)) {
		if (!structKeyExists(variables, dv)) {
			variables[dv] = "";
		}
	}
}

// --- Docket Number ---
qry_docket_no = appellantComponent.getDocketNumber(url.matterkey);

if (qry_docket_no.recordCount > 0) {
	docket_no = qry_docket_no.forum_number;
} else if (!structKeyExists(variables, "docket_no")) {
	docket_no = "";
}
</cfscript>

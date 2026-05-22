<cfscript>
// ****************** Plaintiff's Information Queries and Variable Settings ******************

plaintiffComponent = new components.plaintiff_data_component();

hasSubmittedData = (qry_last_submitted_data.recordCount > 0);

// Query Plaintiff's name, eid, facility and district
qry_plaintiff = plaintiffComponent.getPlaintiff(url.matterkey);

if (qry_plaintiff.recordCount > 0) {

	// EID
	plaintiff_eid = len(qry_plaintiff.plaintiff_eid) ? qry_plaintiff.plaintiff_eid : (hasSubmittedData && structKeyExists(variables, "plaintiff_eid") ? plaintiff_eid : "");

	// Name, facility, district from LM
	plaintiff_fname    = qry_plaintiff.first_name;
	plaintiff_lname    = qry_plaintiff.last_name;
	plaintiff_facility = qry_plaintiff.plaintiff_facility;
	plaintiff_district = qry_plaintiff.plaintiff_district;

	// Query Plaintiff's address
	qry_plaintiff_addr = plaintiffComponent.getPlaintiffAddress(qry_plaintiff.entity_key);

	if (qry_plaintiff_addr.recordCount > 0) {
		// Street
		plaintiff_addr = len(qry_plaintiff_addr.street) ? qry_plaintiff_addr.street : (!hasSubmittedData ? "" : (structKeyExists(variables, "plaintiff_addr") ? plaintiff_addr : ""));

		// City / State / Zip — from LM address, or parse from submitted citystzip
		if (len(qry_plaintiff_addr.city)) {
			plaintiff_city = qry_plaintiff_addr.city;
		} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
			parsed = plaintiffComponent.parseCityStZip(plaintiff_citystzip);
			plaintiff_city = parsed.city;
		} else {
			plaintiff_city = "";
		}

		if (len(qry_plaintiff_addr.state)) {
			plaintiff_state = qry_plaintiff_addr.state;
		} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
			parsed = plaintiffComponent.parseCityStZip(plaintiff_citystzip);
			plaintiff_state = parsed.state;
		} else {
			plaintiff_state = "";
		}

		if (len(qry_plaintiff_addr.zip_code)) {
			plaintiff_zip = qry_plaintiff_addr.zip_code;
		} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
			parsed = plaintiffComponent.parseCityStZip(plaintiff_citystzip);
			plaintiff_zip = parsed.zip;
		} else {
			plaintiff_zip = "";
		}

		// Email
		plaintiff_email = len(qry_plaintiff_addr.email) ? qry_plaintiff_addr.email : (!hasSubmittedData ? "" : (structKeyExists(variables, "plaintiff_email") ? plaintiff_email : ""));

	} else {
		// No address data in LM — parse from submitted citystzip or initialize empty
		if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
			parsed = plaintiffComponent.parseCityStZip(plaintiff_citystzip);
			plaintiff_city  = parsed.city;
			plaintiff_state = parsed.state;
			plaintiff_zip   = parsed.zip;
		} else {
			plaintiff_addr  = "";
			plaintiff_city  = "";
			plaintiff_state = "";
			plaintiff_zip   = "";
			plaintiff_email = "";
		}
	}

	// Query Plaintiff's SSN
	try {
		qry_ssn = plaintiffComponent.getPlaintiffSSN(qry_plaintiff.entity_key);
		if (qry_ssn.recordCount > 0 && len(qry_ssn.plaintiff_ssn)) {
			plaintiff_ssn = qry_ssn.plaintiff_ssn;
		} else if (!hasSubmittedData) {
			plaintiff_ssn = "";
		}
	} catch (database e) {
		if (!structKeyExists(variables, "plaintiff_ssn")) {
			plaintiff_ssn = "";
		}
	}

} else {
	// No plaintiff in LawManager — use submitted data or initialize empty
	if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
		parsed = plaintiffComponent.parseCityStZip(plaintiff_citystzip);
		plaintiff_city  = parsed.city;
		plaintiff_state = parsed.state;
		plaintiff_zip   = parsed.zip;
	} else {
		plaintiff_eid      = "";
		plaintiff_ssn      = "";
		plaintiff_fname    = "";
		plaintiff_lname    = "";
		plaintiff_facility = "";
		plaintiff_district = "";
		plaintiff_addr     = "";
		plaintiff_city     = "";
		plaintiff_state    = "";
		plaintiff_zip      = "";
		plaintiff_phone    = "";
		plaintiff_email    = "";
	}
}

// Query case docket number
qry_docket_no = plaintiffComponent.getDocketNumber(url.matterkey);
if (qry_docket_no.recordCount > 0) {
	case_no = qry_docket_no.forum_number;
} else if (!hasSubmittedData) {
	case_no = "";
}

// Query Defendant's name
qry_defendant = plaintiffComponent.getDefendant(url.matterkey);
if (qry_defendant.recordCount > 0 && len(qry_defendant.defendant)) {
	defendant_name = qry_defendant.defendant;
} else if (!hasSubmittedData) {
	defendant_name = "";
}
</cfscript>

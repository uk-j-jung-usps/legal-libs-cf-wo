<cfscript>
// ****************** Plaintiff Rep's Information Queries and Variable Settings ******************

plaintiffRepComponent = new components.plaintiff_rep_data_component();

hasSubmittedData = (qry_last_submitted_data.recordCount > 0);

// Query Plaintiff Rep's name
qry_plaintiff_rep = plaintiffRepComponent.getPlaintiffRep(url.matterkey);

if (qry_plaintiff_rep.recordCount > 0) {

	plaintiff_rep_fname = qry_plaintiff_rep.first_name;
	plaintiff_rep_lname = qry_plaintiff_rep.last_name;

	// Query Plaintiff Rep's company
	qry_plaintiff_rep_company = plaintiffRepComponent.getPlaintiffRepCompany(qry_plaintiff_rep.entity_key);
	if (qry_plaintiff_rep_company.recordCount > 0) {
		plaintiff_rep_company = qry_plaintiff_rep_company.name;
	} else if (!hasSubmittedData) {
		plaintiff_rep_company = "";
	}

	// Query Plaintiff Rep's address
	qry_plaintiff_rep_addr = plaintiffRepComponent.getPlaintiffRepAddress(qry_plaintiff_rep.entity_key);

	if (qry_plaintiff_rep_addr.recordCount > 0) {
		// Street
		if (len(qry_plaintiff_rep_addr.street)) {
			plaintiff_rep_addr = qry_plaintiff_rep_addr.street;
		} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
			parsed = plaintiffRepComponent.parseCityStZip(plaintiff_rep_citystzip);
		} else {
			plaintiff_rep_addr = "";
		}

		// City
		if (len(qry_plaintiff_rep_addr.city)) {
			plaintiff_rep_city = qry_plaintiff_rep_addr.city;
		} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
			parsed = plaintiffRepComponent.parseCityStZip(plaintiff_rep_citystzip);
			plaintiff_rep_city = parsed.city;
		} else {
			plaintiff_rep_city = "";
		}

		// State
		if (len(qry_plaintiff_rep_addr.state)) {
			plaintiff_rep_state = qry_plaintiff_rep_addr.state;
		} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
			parsed = plaintiffRepComponent.parseCityStZip(plaintiff_rep_citystzip);
			plaintiff_rep_state = parsed.state;
		} else {
			plaintiff_rep_state = "";
		}

		// Zip
		if (len(qry_plaintiff_rep_addr.zip_code)) {
			plaintiff_rep_zip = qry_plaintiff_rep_addr.zip_code;
		} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
			parsed = plaintiffRepComponent.parseCityStZip(plaintiff_rep_citystzip);
			plaintiff_rep_zip = parsed.zip;
		} else {
			plaintiff_rep_zip = "";
		}

		// Email
		plaintiff_rep_email = len(qry_plaintiff_rep_addr.email) ? qry_plaintiff_rep_addr.email : "";

	} else {
		// No address data in LM
		if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
			parsed = plaintiffRepComponent.parseCityStZip(plaintiff_rep_citystzip);
			plaintiff_rep_city  = parsed.city;
			plaintiff_rep_state = parsed.state;
			plaintiff_rep_zip   = parsed.zip;
		} else {
			plaintiff_rep_addr  = "";
			plaintiff_rep_city  = "";
			plaintiff_rep_state = "";
			plaintiff_rep_zip   = "";
			plaintiff_rep_email = "";
		}
	}

	// Query Plaintiff Rep's phone
	qry_plaintiff_rep_phone = plaintiffRepComponent.getPlaintiffRepPhone(qry_plaintiff_rep.entity_key);
	if (qry_plaintiff_rep_phone.recordCount > 0) {
		plaintiff_rep_phone = qry_plaintiff_rep_phone.phone_number;
	} else if (!hasSubmittedData) {
		plaintiff_rep_phone = "";
	}

	// Query Plaintiff Rep's fax
	qry_plaintiff_rep_fax = plaintiffRepComponent.getPlaintiffRepFax(qry_plaintiff_rep.entity_key);
	if (qry_plaintiff_rep_fax.recordCount > 0) {
		plaintiff_rep_fax = qry_plaintiff_rep_fax.fax_number;
	} else if (!hasSubmittedData) {
		plaintiff_rep_fax = "";
	}

} else {
	// No Plaintiff Rep in LawManager
	if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
		parsed = plaintiffRepComponent.parseCityStZip(plaintiff_rep_citystzip);
		plaintiff_rep_city  = parsed.city;
		plaintiff_rep_state = parsed.state;
		plaintiff_rep_zip   = parsed.zip;
	} else {
		plaintiff_rep_fname   = "";
		plaintiff_rep_lname   = "";
		plaintiff_rep_company = "";
		plaintiff_rep_addr    = "";
		plaintiff_rep_city    = "";
		plaintiff_rep_state   = "";
		plaintiff_rep_zip     = "";
		plaintiff_rep_phone   = "";
		plaintiff_rep_fax     = "";
		plaintiff_rep_email   = "";
	}
}
</cfscript>

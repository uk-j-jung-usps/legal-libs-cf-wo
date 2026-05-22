<cfscript>
// ****************** Complainant Rep's Information Queries and Variable Settings ******************

// Instantiate complainant rep data component
compRepComponent = new components.complainant_rep_data_component();

// Track whether previously submitted data exists
hasPriorSubmission = (qry_last_submitted_data.recordCount > 0);

// Query Complainant Rep's name
qry_complainant_rep = compRepComponent.getComplainantRep(url.matterkey);

if (qry_complainant_rep.recordCount > 0) {

	// Run dependent queries
	qry_complainant_rep_company = compRepComponent.getComplainantRepCompany(qry_complainant_rep.entity_key);
	qry_comp_rep_addr           = compRepComponent.getComplainantRepAddress(qry_complainant_rep.entity_key);
	qry_comp_rep_phone          = compRepComponent.getComplainantRepPhone(qry_complainant_rep.entity_key);
	qry_comp_rep_fax            = compRepComponent.getComplainantRepFax(qry_complainant_rep.entity_key);

	comp_rep_fname = qry_complainant_rep.first_name;
	comp_rep_lname = qry_complainant_rep.last_name;

	// --- Company ---
	if (qry_complainant_rep_company.recordCount > 0) {
		comp_rep_comp = qry_complainant_rep_company.name;
	} else if (!hasPriorSubmission) {
		comp_rep_comp = "";
	}

	// --- Address ---
	if (qry_comp_rep_addr.recordCount > 0) {

		// Street
		if (len(qry_comp_rep_addr.street)) {
			comp_rep_addr = qry_comp_rep_addr.street;
		} else if (!hasPriorSubmission) {
			comp_rep_addr = "";
		}

		// City / State / Zip
		needsParse = false;

		if (len(qry_comp_rep_addr.city)) {
			comp_rep_city = qry_comp_rep_addr.city;
		} else {
			needsParse = true;
		}

		if (len(qry_comp_rep_addr.state)) {
			comp_rep_state = qry_comp_rep_addr.state;
		} else {
			needsParse = true;
		}

		if (len(qry_comp_rep_addr.zip_code)) {
			comp_rep_zip = qry_comp_rep_addr.zip_code;
		} else {
			needsParse = true;
		}

		// Parse from prior submission if any field was missing
		if (needsParse && hasPriorSubmission && structKeyExists(variables, "comp_rep_citystzip")) {
			parsed = compRepComponent.parseCityStateZip(comp_rep_citystzip);
			if (!structKeyExists(variables, "comp_rep_city"))  { comp_rep_city  = parsed.city; }
			if (!structKeyExists(variables, "comp_rep_state")) { comp_rep_state = parsed.state; }
			if (!structKeyExists(variables, "comp_rep_zip"))   { comp_rep_zip   = parsed.zip; }
		}

	} else {
		// No address data — fall back to prior submission
		if (hasPriorSubmission && structKeyExists(variables, "comp_rep_citystzip")) {
			parsed = compRepComponent.parseCityStateZip(comp_rep_citystzip);
			comp_rep_city  = parsed.city;
			comp_rep_state = parsed.state;
			comp_rep_zip   = parsed.zip;
		} else {
			comp_rep_addr  = "";
			comp_rep_city  = "";
			comp_rep_state = "";
			comp_rep_zip   = "";
		}
	}

	// --- Phone ---
	comp_rep_phone = (qry_comp_rep_phone.recordCount > 0) ? qry_comp_rep_phone.phone_number : "";

	// --- Fax ---
	if (qry_comp_rep_fax.recordCount > 0) {
		comp_rep_fax = qry_comp_rep_fax.fax_number;
	} else if (!hasPriorSubmission) {
		comp_rep_fax = "";
	}

} else {
	// --- Complainant Rep not found in LawManager ---
	if (hasPriorSubmission && structKeyExists(variables, "comp_rep_citystzip")) {
		parsed = compRepComponent.parseCityStateZip(comp_rep_citystzip);
		comp_rep_city  = parsed.city;
		comp_rep_state = parsed.state;
		comp_rep_zip   = parsed.zip;
		comp_rep_phone = "";
	} else {
		comp_rep_fname = "";
		comp_rep_lname = "";
		comp_rep_comp  = "";
		comp_rep_addr  = "";
		comp_rep_city  = "";
		comp_rep_state = "";
		comp_rep_zip   = "";
		comp_rep_phone = "";
		comp_rep_fax   = "";
	}
}
</cfscript>

<cfscript>
// ==================== Appellant Rep's Information Queries ====================

// Instantiate appellant rep component for data access
appellantRepComponent = new components.appellant_rep_component();

// Query Appellant Rep's name
qry_appellant_rep = appellantRepComponent.getAppellantRep(url.matterkey);

if (qry_appellant_rep.recordCount > 0) {

	appellant_rep_fname = qry_appellant_rep.first_name;
	appellant_rep_lname = qry_appellant_rep.last_name;

	// --- Company ---
	qry_appellant_rep_company = appellantRepComponent.getAppellantRepCompany(qry_appellant_rep.entity_key);
	appellant_rep_company = (qry_appellant_rep_company.recordCount > 0) ? qry_appellant_rep_company.name : "";

	// --- Address ---
	qry_appellant_rep_addr = appellantRepComponent.getAppellantRepAddress(qry_appellant_rep.entity_key);

	if (qry_appellant_rep_addr.recordCount > 0) {
		appellant_rep_addr = len(qry_appellant_rep_addr.street) ? qry_appellant_rep_addr.street : "";

		if (len(qry_appellant_rep_addr.city)) {
			appellant_rep_city = qry_appellant_rep_addr.city;
		} else if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = appellantRepComponent.parseCityStZip(appellant_rep_citystzip);
			appellant_rep_city = parsed.city;
		} else {
			appellant_rep_city = "";
		}

		if (len(qry_appellant_rep_addr.state)) {
			appellant_rep_state = qry_appellant_rep_addr.state;
		} else if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = appellantRepComponent.parseCityStZip(appellant_rep_citystzip);
			appellant_rep_state = parsed.state;
		} else {
			appellant_rep_state = "";
		}

		if (len(qry_appellant_rep_addr.zip_code)) {
			appellant_rep_zip = qry_appellant_rep_addr.zip_code;
		} else if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = appellantRepComponent.parseCityStZip(appellant_rep_citystzip);
			appellant_rep_zip = parsed.zip;
		} else {
			appellant_rep_zip = "";
		}
	} else {
		// No address in LM — parse from previously submitted citystzip if available
		if (structKeyExists(variables, "appellant_rep_citystzip") && len(appellant_rep_citystzip)) {
			parsed = appellantRepComponent.parseCityStZip(appellant_rep_citystzip);
			appellant_rep_city  = parsed.city;
			appellant_rep_state = parsed.state;
			appellant_rep_zip   = parsed.zip;
		} else {
			appellant_rep_addr  = "";
			appellant_rep_city  = "";
			appellant_rep_state = "";
			appellant_rep_zip   = "";
		}
	}

	// --- Phone ---
	qry_appellant_rep_phone = appellantRepComponent.getAppellantRepPhone(qry_appellant_rep.entity_key);
	appellant_rep_phone = (qry_appellant_rep_phone.recordCount > 0) ? qry_appellant_rep_phone.phone_number : "";

	// --- Fax ---
	qry_appellant_rep_fax = appellantRepComponent.getAppellantRepFax(qry_appellant_rep.entity_key);
	appellant_rep_fax = (qry_appellant_rep_fax.recordCount > 0) ? qry_appellant_rep_fax.fax_number : "";

} else {
	// No appellant rep found in LawManager — parse from submitted data or initialize empty
	if (structKeyExists(variables, "appellant_rep_citystzip") && len(trim(variables.appellant_rep_citystzip))) {
		parsed = appellantRepComponent.parseCityStZip(appellant_rep_citystzip);
		if (!structKeyExists(variables, "appellant_rep_city"))  { appellant_rep_city  = parsed.city; }
		if (!structKeyExists(variables, "appellant_rep_state")) { appellant_rep_state = parsed.state; }
		if (!structKeyExists(variables, "appellant_rep_zip"))   { appellant_rep_zip   = parsed.zip; }
	}
	// Ensure all appellant rep variables exist
	defaultVars = "appellant_rep_fname,appellant_rep_lname,appellant_rep_company,appellant_rep_addr,appellant_rep_city,appellant_rep_state,appellant_rep_zip,appellant_rep_phone,appellant_rep_fax";
	for (dv in listToArray(defaultVars)) {
		if (!structKeyExists(variables, dv)) {
			variables[dv] = "";
		}
	}
}
</cfscript>

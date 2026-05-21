<cfscript>
	// Parse plaintiff rep's "City, ST Zip" string into individual components
	if (qry_last_submitted_data.recordCount GT 0) {
		if (structKeyExists(variables, "plaintiff_rep_citystzip") && len(trim(plaintiff_rep_citystzip))) {
			plaintiff_rep_city = listFirst(plaintiff_rep_citystzip);
			if (listLen(plaintiff_rep_citystzip) GTE 2) {
				plaintiff_rep_state = left(trim(listGetAt(plaintiff_rep_citystzip, 2)), 2);
			} else {
				plaintiff_rep_state = "";
			}
			zipindex = reFind("[0-9]{5}", plaintiff_rep_citystzip);
			plaintiff_rep_zip = (zipindex GTE 1) ? mid(plaintiff_rep_citystzip, zipindex, 5) : "";
		} else {
			plaintiff_rep_city  = "";
			plaintiff_rep_state = "";
			plaintiff_rep_zip   = "";
		}
	} else {
		plaintiff_rep_addr  = "";
		plaintiff_rep_city  = "";
		plaintiff_rep_state = "";
		plaintiff_rep_zip   = "";
	}
</cfscript>

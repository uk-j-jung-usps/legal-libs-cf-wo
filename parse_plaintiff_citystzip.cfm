<cfscript>
	// Parse plaintiff's "City, ST Zip" string into individual components
	if (qry_last_submitted_data.recordCount GT 0) {
		if (structKeyExists(variables, "plaintiff_citystzip") && len(trim(plaintiff_citystzip))) {
			plaintiff_city = listFirst(plaintiff_citystzip);
			if (listLen(plaintiff_citystzip) GTE 2) {
				plaintiff_state = left(trim(listGetAt(plaintiff_citystzip, 2)), 2);
			} else {
				plaintiff_state = "";
			}
			zipindex = reFind("[0-9]{5}", plaintiff_citystzip);
			plaintiff_zip = (zipindex GTE 1) ? mid(plaintiff_citystzip, zipindex, 5) : "";
		} else {
			plaintiff_city  = "";
			plaintiff_state = "";
			plaintiff_zip   = "";
		}
	} else {
		plaintiff_addr  = "";
		plaintiff_city  = "";
		plaintiff_state = "";
		plaintiff_zip   = "";
	}
</cfscript>

<cfscript>
if (qry_last_submitted_data.recordCount > 0) {
	if (structKeyExists(variables, "comp_rep_citystzip") && len(trim(comp_rep_citystzip))) {
		comp_rep_city = listFirst(comp_rep_citystzip);
		if (listLen(comp_rep_citystzip) >= 2) {
			comp_rep_state = left(trim(listGetAt(comp_rep_citystzip, 2)), 2);
		} else {
			comp_rep_state = "";
		}
		zipindex = reFind("[0-9]{5}", comp_rep_citystzip);
		comp_rep_zip = (zipindex >= 1) ? mid(comp_rep_citystzip, zipindex, 5) : "";
	} else {
		comp_rep_city  = "";
		comp_rep_state = "";
		comp_rep_zip   = "";
	}
} else {
	comp_rep_addr  = "";
	comp_rep_city  = "";
	comp_rep_state = "";
	comp_rep_zip   = "";
}
</cfscript>

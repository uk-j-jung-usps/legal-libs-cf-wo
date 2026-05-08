<cfscript>
if (qry_last_submitted_data.recordCount > 0) {
	if (structKeyExists(variables, "comp_citystzip") && len(trim(comp_citystzip))) {
		comp_city = listFirst(comp_citystzip);
		if (listLen(comp_citystzip) >= 2) {
			comp_state = left(trim(listGetAt(comp_citystzip, 2)), 2);
		} else {
			comp_state = "";
		}
		zipindex = reFind("[0-9]{5}", comp_citystzip);
		comp_zip = (zipindex >= 1) ? mid(comp_citystzip, zipindex, 5) : "";
	} else {
		comp_city  = "";
		comp_state = "";
		comp_zip   = "";
	}
} else {
	comp_addr  = "";
	comp_city  = "";
	comp_state = "";
	comp_zip   = "";
}
</cfscript>

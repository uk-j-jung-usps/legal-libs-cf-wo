<cfscript>
if (qry_last_submitted_data.recordCount > 0) {
	if (structKeyExists(variables, "ajs_citystzip") && len(trim(ajs_citystzip))) {
		aj_city = listFirst(ajs_citystzip);
		if (listLen(ajs_citystzip) >= 2) {
			aj_state = left(trim(listGetAt(ajs_citystzip, 2)), 2);
		} else {
			aj_state = "";
		}
		zipindex = reFind("[0-9]{5}", ajs_citystzip);
		aj_zip = (zipindex >= 1) ? mid(ajs_citystzip, zipindex, 5) : "";
	} else {
		aj_city  = "";
		aj_state = "";
		aj_zip   = "";
	}
} else {
	aj_addr  = "";
	aj_city  = "";
	aj_state = "";
	aj_zip   = "";
}
</cfscript>

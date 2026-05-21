<cfscript>
// Parse appellant rep's "City, ST Zip" into individual variables
if (structKeyExists(variables, "appellant_rep_citystzip") && len(trim(appellant_rep_citystzip))) {
	appellant_rep_city = listFirst(appellant_rep_citystzip);
	if (listLen(appellant_rep_citystzip) >= 2) {
		appellant_rep_state = left(trim(listGetAt(appellant_rep_citystzip, 2)), 2);
	} else {
		appellant_rep_state = "";
	}
	var zipIndex = reFind("[0-9]{5}", appellant_rep_citystzip);
	appellant_rep_zip = (zipIndex >= 1) ? mid(appellant_rep_citystzip, zipIndex, 5) : "";
} else {
	appellant_rep_city  = "";
	appellant_rep_state = "";
	appellant_rep_zip   = "";
}
</cfscript>

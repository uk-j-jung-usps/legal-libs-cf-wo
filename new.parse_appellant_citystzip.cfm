<cfscript>
// Parse appellant's "City, ST Zip" into individual variables
if (structKeyExists(variables, "appellant_citystzip") && len(trim(appellant_citystzip))) {
	appellant_city = listFirst(appellant_citystzip);
	if (listLen(appellant_citystzip) >= 2) {
		appellant_state = left(trim(listGetAt(appellant_citystzip, 2)), 2);
	} else {
		appellant_state = "";
	}
	var zipIndex = reFind("[0-9]{5}", appellant_citystzip);
	appellant_zip = (zipIndex >= 1) ? mid(appellant_citystzip, zipIndex, 5) : "";
} else {
	appellant_city  = "";
	appellant_state = "";
	appellant_zip   = "";
}
</cfscript>

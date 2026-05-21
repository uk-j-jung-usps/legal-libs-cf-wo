<cfscript>
// Parse AUSA city/state/zip from the combined citystzip field
ausa_city = "";
ausa_state = "";
ausa_zip = "";

if (qry_last_submitted_data.recordCount GT 0) {
	if (isDefined("ajs_citystzip") && len(trim(ajs_citystzip))) {
		ausa_city = listFirst(ajs_citystzip);
		if (listLen(ajs_citystzip) GTE 2) {
			ausa_state = left(trim(listGetAt(ajs_citystzip, 2)), 2);
		}
		var zipIndex = reFind("[0-9]{5}", ajs_citystzip);
		if (zipIndex GTE 1) {
			ausa_zip = mid(ajs_citystzip, zipIndex, 5);
		}
	}
} else {
	ausa_addr = "";
}
</cfscript>

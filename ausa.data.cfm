<cfscript>
// ****************** AUSA (Assistant US Attorney) Information ******************

ausaComponent = new components.ausa_data_component();

qry_ausa = ausaComponent.getAusa(url.matterkey);

if (qry_ausa.recordCount > 0) {
	ausa_fname = qry_ausa.first_name;
	ausa_lname = qry_ausa.last_name;
	ausa_title = qry_ausa.title;
} else {
	ausa_fname = "";
	ausa_lname = "";
	ausa_title = "";
}
</cfscript>

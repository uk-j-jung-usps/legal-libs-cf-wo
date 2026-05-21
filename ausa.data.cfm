<!--- Assistant US Attorney's Information Queries --->
<cfquery name="qry_ausa" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name,
		   trim(initcap(b.title)) AS title
	FROM lawmanager.matter a
	INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
	INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 11
</cfquery>

<cfscript>
	if (qry_ausa.recordCount GT 0) {
		ausa_fname = qry_ausa.first_name;
		ausa_lname = qry_ausa.last_name;
		ausa_title = qry_ausa.title;
	} else {
		ausa_fname = "";
		ausa_lname = "";
		ausa_title = "";
	}
</cfscript>

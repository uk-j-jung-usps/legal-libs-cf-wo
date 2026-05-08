<!--- Insert first-time record into CMFT_BASE --->
<cfquery name="insert_cmft_base" datasource="lawmanager">
	INSERT INTO lawmanager.cmft_base
		(matter_key, process, date_added, added_by, date_updated, updated_by)
	VALUES (
		<cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">,
		'Y',
		<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
		<cfqueryparam value="#owner_key#" cfsqltype="cf_sql_integer" null="#NOT len(trim(owner_key))#">,
		<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
		<cfqueryparam value="#owner_key#" cfsqltype="cf_sql_integer" null="#NOT len(trim(owner_key))#">
	)
</cfquery>

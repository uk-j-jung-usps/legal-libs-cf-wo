<cfscript>
	/*
		Process the dynamic template "EEOC Template Ltr Applnt Rep Req Auth final.rtf" (template 78).
		Handles the radio button answer for "Are there allegations directly implicating
		a work related injury?" and saves the user's reason if answered "Yes".
	*/
</cfscript>

<!--- Clear any previous answer for this matter's dynamic question (key 23) --->
<cfquery name="delete_cmft_dynamic_ans" datasource="lawmanager">
	DELETE FROM cmft_dynamic_ans
	WHERE matter_key = <cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">
	  AND dynamic_quest_key = <cfqueryparam value="23" cfsqltype="cf_sql_integer">
</cfquery>

<!--- Insert the radio button answer for the OWCP question --->
<cfquery name="insert_cmft_dynamic_ans" datasource="lawmanager">
	INSERT INTO lawmanager.cmft_dynamic_ans
		(dynamic_quest_key, matter_key, answer, date_added, added_by, template_key)
	VALUES (
		<cfqueryparam value="23" cfsqltype="cf_sql_integer">,
		<cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">,
		<cfqueryparam value="#owcp_answer#" cfsqltype="cf_sql_varchar">,
		<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
		<cfqueryparam value="#ownerkey#" cfsqltype="cf_sql_integer">,
		<cfqueryparam value="78" cfsqltype="cf_sql_integer">
	)
</cfquery>

<!--- Save the user-entered reason text into cmft_matterkey_pairs --->
<cfquery name="insert_cmft_matterkey_pairs" datasource="lawmanager">
	INSERT INTO lawmanager.cmft_matterkey_pairs
		(matter_key, tempvar_key_name, tempvar_value, tempvar_key, date_added, added_by)
	VALUES (
		<cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">,
		<cfqueryparam value="BECAUSE" cfsqltype="cf_sql_varchar">,
		<cfqueryparam value="#trim(owcp_because)#" cfsqltype="cf_sql_varchar">,
		<cfqueryparam value="148" cfsqltype="cf_sql_integer">,
		<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
		<cfqueryparam value="#ownerkey#" cfsqltype="cf_sql_integer">
	)
</cfquery>

<cfscript>
	// Variable Initialization
	param name="templateid" default="";
	today = dateFormat(now(), "mm/dd/yyyy");
	aceid = mid(AUTH_USER, 5, 6);
</cfscript>

<cfif NOT len(trim(templateid))>
	<!--- No template selected — alert and redirect back --->
	<cfoutput>
	<script>
		alert("Please select at least one template!");
		location.href = "new.template.list.display.cfm?matterkey=#encodeForJavaScript(matterkey)#&matternumber=#encodeForJavaScript(matternumber)#&mattertypekey=#encodeForJavaScript(mattertypekey)#&ownerkey=#encodeForJavaScript(ownerkey)#";
	</script>
	</cfoutput>
<cfelse>

	<!--- Process extra dynamic question/answer inserts for templates with OWCP questions --->
	<cfif isDefined("owcp_answer")>
		<cfswitch expression="#mattertypekey#">
			<cfcase value="9">
				<cfinclude template="new.insert_template_answers_eeoc.cfm">
			</cfcase>
			<cfcase value="8">
				<cfinclude template="insert_template_answers_mspb.cfm">
			</cfcase>
		</cfswitch>
	</cfif>

	<!--- Get the base_key from CMFT_BASE for this matter --->
	<cfquery name="get_base_key" datasource="lawmanager">
		SELECT base_key
		FROM lawmanager.cmft_base
		WHERE matter_key = <cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfset cmft_base_key = get_base_key.base_key>

	<!--- Insert each selected template into CMFT_SELECTED_TEMPLATES --->
	<cfloop list="#templateid#" index="listElement">
		<cfquery name="insert_cmft_selected_templates" datasource="lawmanager">
			INSERT INTO lawmanager.cmft_selected_templates
				(base_key, template_key, date_added, added_by)
			VALUES (
				<cfqueryparam value="#cmft_base_key#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#listElement#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
				<cfqueryparam value="#ownerkey#" cfsqltype="cf_sql_integer">
			)
		</cfquery>
	</cfloop>

	<!--- Execute the batch file that runs the Java program --->
	<cfinclude template="new.submit.templates.cfm">
	<cflocation url="new.case.files.home.cfm?confirm_msg=Y" addtoken="no">

</cfif>

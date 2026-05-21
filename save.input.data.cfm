<cfscript>
	// Variable Initialization
	today = dateFormat(now(), "mm/dd/yyyy");
	aceid = mid(AUTH_USER, 5, 6);
	if (len(trim(aceid)) EQ 0) {
		aceid = "dd32j0";
	}
</cfscript>

<!--- Grab the owner_key (personnel_key) from user's ACE ID --->
<cfquery name="qry_personnel_key" datasource="lawmanager">
	SELECT personnel_key
	FROM lawmanager.personnel
	WHERE login_name = lower(<cfqueryparam value="#aceid#" cfsqltype="cf_sql_varchar">)
</cfquery>

<cfscript>
	owner_key = (qry_personnel_key.recordCount GT 0 AND len(trim(qry_personnel_key.personnel_key)))
		? qry_personnel_key.personnel_key
		: "";
</cfscript>

<!---
	Check if a specific matter has been processed before.
	If so, update the record in CMFT_BASE table and delete all existing
	entries in CMFT_SELECTED_TEMPLATES and CMFT_MATTERKEY_PAIRS tables
	for current matterkey, to be replaced by new records inserted by this run.
--->

<!--- Check for existing entry in cmft_base --->
<cfquery name="qry_existing_template" datasource="lawmanager">
	SELECT base_key, matter_key
	FROM lawmanager.cmft_base
	WHERE matter_key = <cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif qry_existing_template.recordCount EQ 0>

	<!--- First-time insert into CMFT_BASE --->
	<cfinclude template="new.process.cmft.base.cfm">

<cfelse>

	<!--- Update cmft_base: set process to 'Y' so Java program can process --->
	<cfquery name="update_cmft_base" datasource="lawmanager">
		UPDATE lawmanager.cmft_base
		SET process      = 'Y',
		    updated_by   = <cfqueryparam value="#owner_key#" cfsqltype="cf_sql_integer" null="#NOT len(trim(owner_key))#">,
		    date_updated = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
		WHERE matter_key = <cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Clear/reset entries in cmft_selected_templates for this matter --->
	<cfquery name="delete_cmft_sel_templates" datasource="lawmanager">
		DELETE FROM lawmanager.cmft_selected_templates
		WHERE base_key = <cfqueryparam value="#qry_existing_template.base_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Clear/reset entries in cmft_matterkey_pairs for this matter --->
	<cfquery name="delete_cmft_matterkey_pairs" datasource="lawmanager">
		DELETE FROM lawmanager.cmft_matterkey_pairs
		WHERE matter_key = <cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- For Advice FSSC: clear dynamic answers --->
	<cfif mattertypekey EQ 1>
		<cfquery name="delete_cmft_dynamic_ans" datasource="lawmanager">
			DELETE FROM lawmanager.cmft_dynamic_ans
			WHERE matter_key = <cfqueryparam value="#matterkey#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cfif>

</cfif>

<!--- Route to the appropriate matterkey pairs processor --->
<cfswitch expression="#mattertypekey#">

	<cfcase value="9">
		<cfinclude template="process.cmft.matterkey.pairs.eeoc.cfm">
	</cfcase>

	<cfcase value="8">
		<cfinclude template="process.cmft.matterkey.pairs.mspb.cfm">
	</cfcase>

	<cfcase value="5">
		<cfinclude template="process.cmft.matterkey.pairs.dct.cfm">
	</cfcase>

	<cfcase value="1">
		<cfinclude template="process.cmft.matterkey.pairs.advice_fssc.cfm">
		<cfinclude template="submit.templates.cfm">
		<cflocation url="case.files.home.cfm?confirm_msg=Y" addtoken="no">
	</cfcase>

</cfswitch>

<cflocation url="template.list.display.cfm?matterkey=#encodeForURL(matterkey)#&matternumber=#encodeForURL(matternumber)#&mattertypekey=#encodeForURL(mattertypekey)#&ownerkey=#encodeForURL(owner_key)#" addtoken="no">

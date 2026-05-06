
	<!----------------------------------->
	<!---   Variable Initialization   --->
	<!----------------------------------->

	<cfset Today = #DateFormat("#Now()#","mm/dd/YYYY")#>
	<cfset aceid = #mid(AUTH_USER,5,6)#>



	<!---*** Grab the owner_key(personnel_key) from user's ACE ID by querying personnel table ***--->
	<cfquery name="qry_personnel_key" datasource="lawmanager">
	  select personnel_key from lawmanager.personnel where login_name = lower('#aceid#')
	</cfquery>
	
	<cfif #qry_personnel_key.personnel_key# gt "">
		<cfset owner_key = #qry_personnel_key.personnel_key#>
	<cfelse>
		<cfset owner_key = "">
	</cfif>



	 
	<!---**********Comments**********
	Find out if a specific matter has been processed before. 
	If so, update the record in CMFT_BASE table and delete all existing 
	entries in CMFT_SELECTED_TEMPLATES and 	CMFT_MATTERKEY_PAIRS tables 
	for current matterkey to be replaced by new records inserted by the 
	current run.--->
	
	
	<!---*** Check to see if there is an entry for the matter_key in cmft_base table ***--->
	<cfquery name="qry_existing_template" datasource="lawmanager">
	  select * from cmft_base where matter_key = #matterkey#
	</cfquery>

	<!---*** if templates are processed for the very first time for this matter, do the very first insert in CMFT_BASE table ***--->
	<cfif qry_existing_template.RecordCount eq 0>  
			<cfinclude template = "process.cmft.base.cfm"> <!--- does first-time insert --->
		
	<cfelse>
			<!--- update cmft_base table. Set the "process" to 'Y' so java program can process --->
			<cfquery name="update_cmft_base" datasource="lawmanager">
	  		update cmft_base 
	  		set process 		= 'Y',
	  	    updated_by 	= #owner_key#,
	  	    date_updated = TO_DATE('#TODAY#', 'mm/dd/YYYY')
	  		where matter_key = #matterkey#
			</cfquery>	

			<!--- **** For all templates, clear/reset the entries in cmft_selected_templates table by deleting records for a given matterkey *** --->	
			<cfquery name="delete_cmft_sel_templates" datasource="lawmanager">
		 	 delete from CMFT_SELECTED_TEMPLATES where  base_key= #qry_existing_template.base_key#
			</cfquery>	

			<!--- **** For all templates, clear/reset the entries in cmft_matterkey_pair table by deleting records for a given matterkey *** --->	
			<cfquery name="delete_cmft_matterkey_pairs" datasource="lawmanager">
		 	 delete from CMFT_MATTERKEY_PAIRS where matter_key = #matterkey#
			</cfquery>

			<!--- **** For Advice FSSC template, clear/reset the answers in cmft_dynamic_ans table by deleting records for a given matterkey *** --->
			<cfif #mattertypekey# eq 1>
				<cfquery name="delete_cmft_dynamic_ans" datasource="lawmanager">
				  delete from CMFT_DYNAMIC_ANS where matter_key = #matterkey#
				</cfquery>		
			</cfif>

	</cfif>


 <cfswitch expression="#mattertypekey#">
   <cfcase value="9">
 	  <cfinclude template = "process.cmft.matterkey.pairs.eeoc.cfm">
  </cfcase>
   <cfcase value="8">
 	  <cfinclude template = "process.cmft.matterkey.pairs.mspb.cfm">
  </cfcase>		 
   <cfcase value="5">
 	  <cfinclude template = "process.cmft.matterkey.pairs.dct.cfm">
  </cfcase>		 
   <cfcase value="1">
	 	 <cfinclude template = "process.cmft.matterkey.pairs.advice_fssc.cfm">
			 <cfinclude template = "submit.templates.cfm"><!---will excecute the batch file that run java program--->
			 <cflocation url="case.files.home.cfm?confirm_msg=Y">
			
  </cfcase>	  
  <cfdefaultcase>
  'none',
  </cfdefaultcase>		
		   		   	  
 </cfswitch>
	<cflocation url="template.list.display.cfm?matterkey=#matterkey#&matternumber=#matternumber#&mattertypekey=#mattertypekey#&ownerkey=#owner_key#">




<!---
<cfoutput> #attorney_name# <br> #qry_attny_email.eaddress# </cfoutput>


<cfoutput> SQL: #qry_attny_email.getMetaData().getExtendedMetaData().sql# </cfoutput>
--->
	

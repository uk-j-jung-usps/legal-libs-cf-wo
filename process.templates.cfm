
<!----------------------------------->
<!---   Variable Initialization   --->
<!----------------------------------->
<cfparam Name="TemplateID" Default="">
<cfset Today = #DateFormat("#Now()#","mm/dd/YYYY")#>
<cfset aceid = #mid(AUTH_USER,5,6)#>

<cfif trim(templateid) IS "">  <!--- if no template is selected, send an error message --->
	<cfoutput>
	<SCRIPT language="javascript">
   alert("Please select at least one template!");
   location.href = "template.list.display.cfm?matterkey=#matterkey#&matternumber=#matternumber#&mattertypekey=#mattertypekey#&ownerkey=#ownerkey#"
  </script>
  </cfoutput>
<cfelse>

		<!---******************************************************************************************************
		Added September 2015. Calling newly added modules to process extra db calls for new templates 
		that have extra dynamic question/answer featur among static ones. two of these template are 
		EEOC Template Ltr Applnt Rep Req Auth final.rtf and MSPB Template Ltr Applnt Rep Req Auth final.rtf  
		************************************************************************************************************--->
 <cfswitch expression="#(mattertypekey)#"> 
   <cfcase value="9">
				<cfif IsDefined("owcp_answer")>
					<cfinclude template = "insert_template_answers_eeoc.cfm">
				</cfif>
   </cfcase>
		
   <cfcase value="8">
				<cfif IsDefined("owcp_answer")>
					<cfinclude template = "insert_template_answers_mspb.cfm">
				</cfif>
   </cfcase>   
     
 </cfswitch>
 <!---*** End of Sept. 2015 addition ***--->
	


	<!---*** Grab the base_key in CMFT_BASE table for insert sql down below in CMFT_SELECTED_TEMPLATES table ***--->
	<cfquery name="get_base_key" datasource="lawmanager">
	  select base_key from cmft_base where matter_key = #matterkey#
	</cfquery>
	<cfset cmft_base_key = #get_base_key.base_key#>
	
	
	
	<cfloop index = "ListElement" list = "#templateid#">
	
		<cfquery name="Insert_cmft_selected_templates" datasource="lawmanager">
			INSERT INTO lawmanager.CMFT_SELECTED_TEMPLATES
				(base_key,
				 template_key,
				 date_added,
				 added_by)
	 	VALUES(#cmft_base_key#,
	 			 #ListElement#,
	       TO_DATE('#TODAY#', 'mm/dd/YYYY'),
				 #ownerkey#)
		</cfquery>
	
	

	<!---
	<cfoutput>#templateid#<br>#ListElement#<br>	</cfoutput>
	<cfoutput> #mattertypekey#  <br>  #owcp_because#</cfoutput> 
 --->

	</cfloop>
	
	
	
	<!---<cfoutput> #matterkey#  <br>  #owcp_because# <br>#mattertypekey#</cfoutput>--->

	<cfinclude template = "submit.templates.cfm"> <!---will excecute the batch file that run java program--->
	<cflocation url="case.files.home.cfm?confirm_msg=Y">	

</cfif>


	
		
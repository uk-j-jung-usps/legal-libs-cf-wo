
			
		
	<!---*** first grab the base_key in CMFT_BASE table for a matter_key and then insert in CMFT_SELECTED_TEMPLATES table ***--->
	<cfquery name="get_base_key" datasource="lawmanager">
	  select base_key from cmft_base where matter_key = #matterkey#
	</cfquery>
	<cfset cmft_base_key = #get_base_key.base_key#>
	
			
	
		<cfquery name="Insert_cmft_selected_templates" datasource="lawmanager">		
			INSERT INTO lawmanager.CMFT_SELECTED_TEMPLATES
				(base_key,
				 template_key,
				 date_added,
				 added_by)
	 	VALUES(#cmft_base_key#,
	 		 '73',
	    TO_DATE('#TODAY#', 'mm/dd/YYYY'),
			  #owner_key#)
		</cfquery>
		
		
		

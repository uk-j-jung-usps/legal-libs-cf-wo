
	


	<!---*** Grab the next sequence for CMFT_BASE table to be used also for insert in CMFT_SELECTED_TEMPLATES table ***--->
	<!---
	<cfquery name="qry_next_key_cmft_base" datasource="lawmanager">
		SELECT cmft_base_seq.nextval as next_seq FROM DUAL 
	</cfquery>
	--->

	<!---<cfset cmft_base_key = #qry_next_key_cmft_base.next_seq#>--->
	
	<cfquery name="Insert_cmft_base" datasource="lawmanager">
		INSERT INTO lawmanager.CMFT_BASE
			(
			 matter_key,
			 process,
			 date_added,
			 added_by,
			 date_updated,
			 updated_by)
 	VALUES(
 			 #matterkey#,
		   'Y',
		   TO_DATE('#TODAY#', 'mm/dd/YYYY'),
		   '#owner_key#',
       TO_DATE('#TODAY#', 'mm/dd/YYYY'),
			 '#owner_key#')
	</cfquery>	
	

	 
	 


<!---****************************************************************************************************************************
This module is specifically written for processing the dynamic template called "MSPB Template Ltr Applnt Rep Req Auth final.rtf".
Once selecting this template the user has a choice of selecting a radio button and if the answer is "Yes", they can enter a reason
why there are allegations directly implicating a work related injury.
*****************************************************************************************************************************--->


<!---***************************************************************************************************************
Here we clear up the previous entry, if any, for radio button answer to the dynamic question for 
template number 80 which is MSPB Template Ltr Applnt Rep Req Auth final.rtf.
     ***************************************************************************************************************--->
	<cfquery name="update_cmft_dynamic_ans" datasource="lawmanager">
	  delete from CMFT_DYNAMIC_ANS where matter_key = #matterkey# and dynamic_quest_key = '24'	  
	</cfquery>



<!---***************************************************************************************************************
Here we insert the answer for radio button for the template MSPB Template Ltr Applnt Rep Req Auth final.rtf. 
The question for the radio button is "Are there allegations directly implicating a work related injury?" 
     ***************************************************************************************************************--->
     
	<cfquery name="Insert_CMFT_DYNAMIC_ANS" datasource="lawmanager">
		INSERT INTO lawmanager.CMFT_DYNAMIC_ANS
			  (dynamic_quest_key,
			  matter_key,
			  answer,
			  date_added,
			  added_by,
			  template_key)
	VALUES('24',
		 	  #matterkey#,
			   '#owcp_answer#',
	     TO_DATE('#TODAY#', 'mm/dd/YYYY'),
	     #ownerkey#,
			   '80')
	</cfquery>	
	


	<!---****************************************************************************************************************
	If the answer to the quesion "Are there allegations directly implicating a work related injury"
	is "yes" for "MSPB Template Ltr Applnt Rep Req Auth final.rtf" template, the user input
	will be saved in cmft_matterkey_pairs  
	*********************************************************************************************************************--->

			<cfquery name="Insert_cmft_matterkey_pairs" datasource="lawmanager">
				INSERT INTO lawmanager.CMFT_MATTERKEY_PAIRS
					(matter_key,
					 tempvar_key_name,
					 tempvar_value,			 
					 tempvar_key,
					 date_added,
					 added_by)
			 VALUES(#matterkey#,  
					    'BECAUSE',
						   '#trim(owcp_because)#',
					    '148',
			      TO_DATE('#TODAY#', 'mm/dd/YYYY'),
					    #ownerkey#)
			</cfquery>

	
	
	<!---
	<cfoutput> #mattertypekey#  <br>  #owcp_because#</cfoutput>	
	--->
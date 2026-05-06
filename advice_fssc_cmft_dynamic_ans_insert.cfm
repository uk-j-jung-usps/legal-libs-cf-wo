
<cfset Today = #DateFormat("#Now()#","mm/dd/YYYY")#>


<cfquery name="qry_template_questions" datasource="lawmanager">
  select * from cmft_dynamic_quest  order by dynamic_quest_key
</cfquery>


<cfoutput query="qry_template_questions">

	
	<cfquery name="Insert_CMFT_DYNAMIC_ANS" datasource="lawmanager">
		INSERT INTO lawmanager.CMFT_DYNAMIC_ANS
			  (dynamic_quest_key,
			  matter_key,
			  answer,
			  date_added,
			  added_by,
			  template_key)
	VALUES('#qry_template_questions.dynamic_quest_key#',
		 	  #matterkey#,
	 	  
			 <cfswitch expression="#Trim(qry_template_questions.dynamic_quest_key)#"> 
			   <cfcase value="1">
				 		'#answer1#',
			   </cfcase>
			   
			   <cfcase value="2">
				   '#answer2#',
			   </cfcase>
			   
			   <cfcase value="3">		   
				   '#answer3#',				 					 					 
			   </cfcase>

			   <cfcase value="4">
				   '#answer4#',
			   </cfcase>			   
			   
			   <cfcase value="5">
				   '#answer5#',
			   </cfcase>			   

			   <cfcase value="6">
				   '#answer6#',
			   </cfcase>
			   			   
			   <cfcase value="7">
				   '#answer7#',
			   </cfcase>			   
			   
			   <cfcase value="8">
				 '#answer8#',
			   </cfcase>			   
			   
			   <cfcase value="9">
				 '#answer9#',
			   </cfcase>			   
			   
			   <cfcase value="10">
				 '#answer10#',
			   </cfcase>			   

			   <cfcase value="11">
				 '#answer11#',
			   </cfcase>			   
			   <cfdefaultcase>
			   '',
			   </cfdefaultcase>		
			 </cfswitch>		 	  
	       TO_DATE('#TODAY#', 'mm/dd/YYYY'),
	       #owner_key#,
			   '#qry_template_questions.template_key#')
	</cfquery>	
	
</cfoutput>

<!---
<cfoutput>
SQL: #Insert_CMFT_DYNAMIC_ANS.getMetaData().getExtendedMetaData().sql#
</cfoutput>

--->







































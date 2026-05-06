

<!--- Query  cmft_matterkey_pairs for non-question data fields of ADVICE FSSC template from the last submission by the user for this matterkey--->

	<cfquery name="qry_last_submitted_data" datasource="lawmanager">
	  select tempvar_key, tempvar_key_name, tempvar_value
	  from cmft_matterkey_pairs
	  where matter_key=#url.matterkey# order by tempvar_key
	</cfquery>


<!--- Query  CMFT_DYNAMIC_ANS to get the previously submitted answers, if any, for radio-button questions and initialize the related variables--->

	<cfquery name="qry_last_submitted_data_answers" datasource="lawmanager">
	  select *  from CMFT_DYNAMIC_ANS   where matter_key=#url.matterkey# order by dynamic_quest_key
	</cfquery>




<!---<cfoutput>#qry_last_submitted_data.recordcount#</cfoutput>--->

	

<!---
<cfoutput query="qry_last_submitted_data">
#tempvar_value# #tempvar_key#<br>
</cfoutput>
--->
<!---*** set the variables to the previously-saved data for non-radio button section of the screen (upper screen) ***--->

<cfloop Query="qry_last_submitted_data">
<cfoutput>

 <cfswitch expression="#tempvar_key#">

  <cfcase value="34"> 
			<cfif len(tempvar_key)>    
    <cfset alo_addr1= #trim(qry_last_submitted_data.tempvar_value)#>
   </cfif>		       
  </cfcase>

 <cfcase value="35"> 
		<cfif len(tempvar_key)>    
   <cfset alo_addr2= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="37"> 
 	<cfif len(tempvar_key)>    
   <cfset alo_fax= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="38"> 
		<cfif len(tempvar_key)>    
   <cfset alo_office= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="40"> 
		<cfif len(tempvar_key)>    
   <cfset alo_phone= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="41"> 
		<cfif len(tempvar_key)>    
   <cfset alo_zip= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="51"> 
		<cfif len(tempvar_key)>    
   <cfset paralgl_name= #trim(qry_last_submitted_data.tempvar_value)#>
  <cfelse>
  </cfif>		       
 </cfcase>

 <cfcase value="112"> 
		<cfif len(tempvar_key)>    
   <cfset case_no= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="113"> 
		<cfif len(tempvar_key)>    
   <cfset sentense1a= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="114"> 
		<cfif len(tempvar_key)>    
   <cfset sentense1b= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="115"> 
		<cfif len(tempvar_key)>    
   <cfset subfor= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="116"> 
		<cfif len(tempvar_key)>    
   <cfset date= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="117"> 
		<cfif len(tempvar_key)>    
   <cfset recvd_date= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="118"> 
		<cfif len(tempvar_key)>    
   <cfset provide= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="119"> 
		<cfif len(tempvar_key)>    
   <cfset sentense2a= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="120"> 
		<cfif len(tempvar_key)>    
   <cfset sentense2b= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="121"> 
		<cfif len(tempvar_key)>    
   <cfset via= #trim(qry_last_submitted_data.tempvar_value)#>
  <cfelse>
   <cfset via= "">
   <cfset via1= "">   
  </cfif>		       
 </cfcase>

 <cfcase value="122"> 
		<cfif len(tempvar_key)>    
   <cfset recipient_addr= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="123"> 
		<cfif len(tempvar_key)>    
   <cfset recipient_name= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="124"> 
		<cfif len(tempvar_key)>    
   <cfset recipient_citystzip= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="125"> 
		<cfif len(tempvar_key)>    
   <cfset case_name= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="126"> 
		<cfif len(tempvar_key)>    
   <cfset work_order_no= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="127"> 
		<cfif len(tempvar_key)>    
   <cfset customer_name= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="128"> 
		<cfif len(tempvar_key)>    
   <cfset po_loc_lkn_box= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>
 
 <cfcase value="129"> 
		<cfif len(tempvar_key)>    
   <cfset tracking_no= #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="130"> 
		<cfif len(tempvar_key)>    
   <cfset non_para = #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 <cfcase value="131"> 
		<cfif len(tempvar_key)>    
   <cfset fax_no = #trim(qry_last_submitted_data.tempvar_value)#>
  </cfif>		       
 </cfcase>

 </cfswitch>
 </cfoutput>
</cfloop>
	

<!---*** initialize the answers variables to the previously-saved data for the radio button questions section of the data entry screen(lower screen)  ***--->

<cfloop Query="qry_last_submitted_data_answers">
<cfoutput>

 <cfswitch expression="#dynamic_quest_key#">

 <cfcase value="1"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer1 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 <cfcase value="3"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer3 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 <cfcase value="4"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer4 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 <cfcase value="5"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer5 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 <cfcase value="6"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer6 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 <cfcase value="7"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer7 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 <cfcase value="8"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer8 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 <cfcase value="11"> 
		<cfif len(dynamic_quest_key)>    
   <cfset answer11 = #trim(qry_last_submitted_data_answers.answer)#>
  </cfif>		       
 </cfcase>

 </cfswitch>

 </cfoutput>
</cfloop>











<!---*** parse recipient_citystzip ***--->

<cfif qry_last_submitted_data.RecordCount gt 0> 

			<cfif len(recipient_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset recipient_city = ListFirst(recipient_citystzip) >
				<cfset recipient_state = Left(Trim(ListGetAt(recipient_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",recipient_citystzip)>
				<cfif zipindex gte 1>
					<cfset recipient_zip = Mid(recipient_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset recipient_zip = 0>
				</cfif>	
			<cfelse>
				<cfset recipient_city = "">
				<cfset recipient_state = "">
				<cfset recipient_zip = "">			
			</cfif>

<cfelse>
			<cfset recipient_addr= "">
			<cfset recipient_city = "">
			<cfset recipient_state = "">
			<cfset recipient_zip = "">
			<cfset RECVD_DATE = "">			
			<cfset PO_LOC_LKN_BOX = "">
			<cfset CUSTOMER_NAME = "">						
			<cfset CASE_NO = "">
			<cfset RECIPIENT_NAME = "">
			<cfset FAX_NO = "">	
			<cfset tracking_no = "">																				
			<cfset work_order_no = "">	
			<cfset alo_office = "">	
			<cfset via1 = "">			
						
</cfif>
		
<cfif not qry_last_submitted_data_answers.RecordCount gt 0>		

	<cfset answer1 = "">
	<cfset answer3 = "">
	<cfset answer4 = "">
	<cfset answer5 = "">	
	<cfset answer6 = "">
	<cfset answer7 = "">
	<cfset answer8 = "">
	<cfset answer11 = "">	


</cfif>



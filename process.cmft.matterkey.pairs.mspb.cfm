


 <!---******************************************************************************************************************************************
 Added 12/5/2015 - for template #78:
 If the case has a Appellant Representative, the third paragraph contains "Appellant has" otherwise it contains 
 "you have" after "If" for template #78.
 **********************************************************************************************************************************************--->
	<cfif len(trim(#appellant_rep_fname#)) && len(trim(#appellant_rep_lname#)) && !trim(#appellant_rep_fname#) eq "Pro Se" && !trim(#appellant_rep_lname#) eq "Pro Se"> 
		<cfset sentence_extra = "If Appellant has never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.">
	<cfelse>
		<cfset sentence_extra = "If you have never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.">
	</cfif>
		<!---<cfoutput> #sentence_extra#   </cfoutput>--->
<!---*******************************************************************************************************************************************--->




	<!---****** Correct the mix casing of an attorney ******--->
	<cfif attorney_name eq "Sherilyn Deninno">
		<cfset attorney_name = "Sherilyn DeNinno">
	</cfif>


	<!---****** retreiveing all relevant template variables ******--->
	<cfquery name="qry_cmft_tempvars" datasource="lawmanager">
	  select tempvar_key, tempvar_name from lawmanager.cmft_tempvars where (matter_type_key = 8 or matter_type_key=0 or matter_type_key is null) and control is null
	</cfquery>



	<!---****** retreiveing attorney email from EADDARESS table for the selected attorney name ******--->
	<cfquery name="qry_attny_email" datasource="lawmanager">
	  select eaddress from entity a, cmft_entity_wo b, eaddress c where a.entity_key = b.entity_key and b.attorney_name = '#attorney_name#' and a.entity_key=c.entity_key
	</cfquery>



	<!---****** Setting all uppercase names to proper case before inserts ******--->

	<cfparam name="appellant_city" default="#appellant_city#">
	<cfset appellant_city = REReplace(LCase(appellant_city), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>

	<cfparam name="appellant_facility" default="#appellant_facility#">
	<cfset appellant_facility = REReplace(LCase(appellant_facility), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>
	<cfset temp_fac = #find("&",appellant_facility)#>
	
	<cfif temp_fac gt 0>
		<cfset sentence = "appellant_facility">	
		<cfset sentence = UCase(Left(sentence, 1)) & LCase(Right(sentence, Len(sentence)-1))>
		<cfset found_at = REFind(" [[:lower:]]", sentence)>
		<cfloop condition="found_at">
			<cfset string_is = Mid(sentence, found_at, 2)>
			<cfset sentence = ReplaceNoCase(sentence, string_is, UCase(string_is), "ALL")>
			<cfset found_at = REFind(" [[:lower:]]", sentence)>
		</cfloop>
		<!---********************BEGINNING OF MODIFICATION *************************
		Searching for the character " ' " in the string in the textfield and assign its index position to noRefoun_at variable
		the condition checks if the " ' " character has been found and replace the character at the index following the " ' " with the
		UPPERCASE version of the same character.
		 --->
		<cfset noREfound_at = Find("&", sentence, 1) />
		<cfif noREfound_at NEQ 0>
		<cfset sentence = Replace(sentence, Mid(sentence, noREfound_at+1,1), Ucase(Mid(sentence, noREfound_at+1,1)), "all") />
		</cfif>
		<!--- ********************END OF MODIFICATION *************************--->
		<cfset sentenceULName = sentence>
  </cfif> 
	
	

	<cfparam name="appellant_district" default="#appellant_district#">
	<cfset appellant_district = REReplace(LCase(appellant_district), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>



	<!---****** Concatenating variables that are grouped (city, state, zip) together for correct display ******--->
	<cfif len(trim(#aj_city#)) && len(trim(#aj_state#)) && len(trim(#aj_zip#))>
		<cfset aj_citystatezip = #aj_city# & ", " & #aj_state# & " " & #aj_zip#>
	<cfelse>
		<cfset aj_citystatezip = #aj_city# & #aj_state# & #aj_zip#>
	</cfif>

	<cfif len(trim(#appellant_city#)) && len(trim(#appellant_state#)) && len(trim(#appellant_zip#))>
		<cfset appellant_citystatezip = #appellant_city# & ", " & #appellant_state# & " " & #appellant_zip#>
	<cfelse>
		<cfset appellant_citystatezip = #appellant_city# & #appellant_state# & #appellant_zip#>
	</cfif>


	<cfif len(trim(#appellant_rep_city#)) && len(trim(#appellant_rep_state#)) && len(trim(#appellant_rep_zip#))>
		<cfset appellant_rep_citystatezip = #appellant_rep_city# & ", " & #appellant_rep_state# & " " & #appellant_rep_zip#>
	<cfelse>
		<cfset appellant_rep_citystatezip = #appellant_rep_city# & #appellant_rep_state# & #appellant_rep_zip#>
	</cfif>



	<!---****** initializing variables with fixed values******--->
	<cfif trim(#alo_office#) eq "Denver">
		<cfset alo_zip = "80299-5555">
	</cfif>
	
	<cfif trim(#alo_office#) eq "Long Beach">
		<cfset alo_zip = "90802-2496">
	</cfif>
	
	<cfif trim(#alo_office#) eq "Salt Lake">
		<cfset alo_zip = "84070-2716">
	</cfif>
	
	<cfif trim(#alo_office#) eq "San Francisco">
		<cfset alo_zip = "94188-3790">
	</cfif>	

	<cfif trim(#alo_office#) eq "San Diego">
		<cfset alo_zip = "92197-4400">
	</cfif>	
	
	<cfif trim(#alo_office#) eq "Seattle">
		<cfset alo_zip = "98124-3686">
	</cfif>
	
<!---
	<cfparam name="alo_addr1" default="#alo_addr1#">
	<cfif alo_addr1 eq "1300 Evans Ave., Rm 217,P.O. Box 883790">
		<cfset alo_addr1 = "1300 Evans Ave., Rm 217, P.O. Box 883790">
	</cfif>
--->


	<!---****** and here, we finally insert all relevant variables into CMFT_MATTERKEY_PARIS ******--->
	<!---****** table. then, Greg's java program will read the entries in this table and     ******--->
	<!---****** processes all selected templates by replacing their empty variables with the ******--->
	<!---****** variable contents read from this table 
	                                      ******--->
	<cfoutput query="qry_cmft_tempvars">
 
	<!---#qry_cmft_tempvars.tempvar_key# &nbsp; #qry_cmft_tempvars.tempvar_name#<br>--->
	
	<cfquery name="Insert_cmft_matterkey_pairs" datasource="lawmanager">
		INSERT INTO lawmanager.CMFT_MATTERKEY_PAIRS
			(matter_key,
			 tempvar_key_name,
			 tempvar_value,			 
			 tempvar_key,
			 date_added,
			 added_by)
	VALUES(#matterkey#,
			 '#qry_cmft_tempvars.tempvar_name#',
			 		 
			 <cfswitch expression="#Trim(tempvar_key)#"> 
			   <cfcase value="81">
				 '#docket_no#',
			   </cfcase>
			   
			   <cfcase value="2">
				 '#aj_citystatezip#',
			   </cfcase>
			   
			   <cfcase value="3">
				 '#aj_addr#',
			   </cfcase>			   

			   <cfcase value="4">
				 '#aj_fax#',
			   </cfcase>

			   <cfcase value="5">
				 '#aj_fname#',
			   </cfcase>

			   <cfcase value="6">
				 '#aj_lname#',
			   </cfcase>

			   <cfcase value="7">
				 '#aj_title#',
			   </cfcase>

			   <cfcase value="8">
				 '#attorney_name#',
			   </cfcase>

			   <cfcase value="9">
				 '#attorney_title#',
			   </cfcase>

			   <cfcase value="67">
				 '#appellant_addr#',
			   </cfcase>

			   <cfcase value="69">
				 '#appellant_phone#',
			   </cfcase>

			   <cfcase value="68">
				 '#appellant_citystatezip#',
			   </cfcase>

			   <cfcase value="71">
				 '#appellant_eid#',
			   </cfcase>

			   <cfcase value="66">
				 '#appellant_facility#',
			   </cfcase>

			   <cfcase value="64">
				 '#appellant_fname#',
			   </cfcase>

			   <cfcase value="65">
				 '#appellant_lname#',
			   </cfcase>

			   <cfcase value="76">
				 '#appellant_rep_addr#',
			   </cfcase>

			   <cfcase value="75">
				 '#appellant_rep_company#',
			   </cfcase>

			   <cfcase value="73">
				 '#appellant_rep_fname#',
			   </cfcase>

			   <cfcase value="74">
				 '#appellant_rep_lname#',
			   </cfcase>

			   <cfcase value="43">
				 '#appellant_email#',
			   </cfcase>


			   <cfcase value="70">
				 '#appellant_ssn#',
			   </cfcase>
			   
			   <cfcase value="24">
				 '#appellant_district#',
			   </cfcase>

			   <cfcase value="25">
				 '#dist_mgr#',
			   </cfcase>

			   <cfcase value="80">
				 '#mspb_office#',
			   </cfcase>

			   <cfcase value="29">
				 '#appellant_pronoun1#',
			   </cfcase>

			   <cfcase value="30">
				 '#appellant_pronoun2#',
			   </cfcase>

			   <cfcase value="31">
				 '#hr_mgr_dist#',
			   </cfcase>

			   <cfcase value="32">
				 '#hr_mgr#',
			   </cfcase>

			   <cfcase value="34">
				 '#alo_addr1#',
			   </cfcase>

			   <cfcase value="35">
				 '#alo_addr2#',
			   </cfcase>

			   <cfcase value="36">
				 'West Law Office',
			   </cfcase>

			   <cfcase value="37">
				 '#alo_fax#',
			   </cfcase>

			   <cfcase value="38">
				 '#alo_office#',
			   </cfcase>

			   <cfcase value="39">
				 'CA',
			   </cfcase>

			   <cfcase value="40">
				 '#alo_phone#',
			   </cfcase>

			   <cfcase value="41">
				 '#alo_zip#',
			   </cfcase>

			   <cfcase value="42">
				 '#lr_mgr#',
			   </cfcase>

			   <cfcase value="72">
				 '#appellant_prefix#',
			   </cfcase>

			   <cfcase value="45">
				 '#ohna_dist#',
			   </cfcase>

			   <cfcase value="51">
				 '#paralgl_name#',
			   </cfcase>

			   <cfcase value="52">
				 'David P. Steiner',
			   </cfcase>

			   <cfcase value="53">
				 'DAVID P. STEINER',
			   </cfcase>

			   <cfcase value="79">
				 '#appellant_rep_fax#',
			   </cfcase>


			   <cfcase value="78">
				 '#appellant_rep_phone#',
			   </cfcase>

			   <cfcase value="55">
				 '#appellant_rep_citystatezip#',
			   </cfcase>

			   <cfcase value="77">
				 '#appellant_rep_prefix#',
			   </cfcase>

			   <cfcase value="83">
				 '#UCase(appellant_fname)#',
			   </cfcase>

			   <cfcase value="84">
				 '#UCase(appellant_lname)#',
			   </cfcase>
			   
			   <cfcase value="85">
				 '#UCase(mspb_office)#',
			   </cfcase>

			   <cfcase value="60">
				 '#matternumber#',
			   </cfcase>

			   <cfcase value="61">
				 '#admin_assist#',
			   </cfcase>

			   <cfcase value="62">
				 '#ucase(aj_citystatezip)#',
			   </cfcase>

			   <cfcase value="63">
				 '#ucase(aj_addr)#',
			   </cfcase>

			   <cfcase value="158">
				 '#(qry_attny_email.eaddress)#',
			   </cfcase>

			   <cfcase value="161">
				 '#(sentence_extra)#',
			   </cfcase>

			   <cfcase value="164">
				 '#(appellant_city)#',
			   </cfcase>

			   <cfcase value="165">
				 '#(appellant_zip)#',
			   </cfcase>

			   <cfdefaultcase>
			   'none',
			   </cfdefaultcase>		
			   		   
			 </cfswitch>
			 			 
			 '#qry_cmft_tempvars.tempvar_key#',
	     TO_DATE('#TODAY#', 'mm/dd/YYYY'),
			 #owner_key#)
	</cfquery>	
	
	</cfoutput>




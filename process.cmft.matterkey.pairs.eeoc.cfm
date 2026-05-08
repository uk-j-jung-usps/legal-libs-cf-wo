


 <!---******************************************************************************************************************************************
 Added 12/5/2015 - for template #78:
 If the case has a Complainant Representative, the third paragraph contains "Complainant has" otherwise it contains 
 "you have" after "If" for template #78.
 ***********************************************************************************************************************************************--->
	<cfif len(trim(#comp_rep_fname#)) && len(trim(#comp_rep_lname#)) && !trim(#comp_rep_fname#) eq "Pro Se" && !trim(#comp_rep_lname#) eq "Pro Se"> 
		<cfset sentence_extra = "If Complainant has never had a work related injury, please initial here __________ to confirm that fact, and return this letter in lieu of the executed authorization.">
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
	  select tempvar_key, tempvar_name from lawmanager.cmft_tempvars where (matter_type_key = 9 or matter_type_key=0 or matter_type_key is null) and control is null
	</cfquery>



	<!---****** retreiveing attorney email from EADDARESS table for the selected attorney name ******--->
	<cfquery name="qry_attny_email" datasource="lawmanager">
	  select eaddress from entity a, cmft_entity_wo b, eaddress c where a.entity_key = b.entity_key and b.attorney_name = '#attorney_name#' and a.entity_key=c.entity_key
	</cfquery>




	<!---****** Setting all uppercase names to proper case before inserts ******--->
	
	<cfparam name="comp_city" default="#comp_city#">
	<cfset comp_city = REReplace(LCase(comp_city), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>

	<cfparam name="comp_facility" default="#comp_facility#">
	<cfset comp_facility = REReplace(LCase(comp_facility), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>
	<cfset temp_fac = #find("&",comp_facility)#>
	
	<cfif temp_fac gt 0>
		<cfset sentence = "comp_facility">	
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
	

	<cfparam name="comp_district" default="#comp_district#">
	<cfset comp_district = REReplace(LCase(comp_district), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>



	<!---****** Concatenating variables that are grouped (city, state, zip) together for correct display ******--->
	<cfif len(trim(#aj_city#)) && len(trim(#aj_state#)) && len(trim(#aj_zip#))>
		<cfset aj_citystatezip = #aj_city# & ", " & #aj_state# & " " & #aj_zip#>
	<cfelse>
		<cfset aj_citystatezip = #aj_city# & #aj_state# & #aj_zip#>
	</cfif>

	<cfif len(trim(#comp_city#)) && len(trim(#comp_state#)) && len(trim(#comp_zip#))>
		<cfset comp_citystatezip = #comp_city# & ", " & #comp_state# & " " & #comp_zip#>
	<cfelse>
		<cfset comp_citystatezip = #comp_city# & #comp_state# & #comp_zip#>
	</cfif>


	<cfif len(trim(#comp_rep_city#)) && len(trim(#comp_rep_state#)) && len(trim(#comp_rep_zip#))>
		<cfset comp_rep_citystatezip = #comp_rep_city# & ", " & #comp_rep_state# & " " & #comp_rep_zip#>
	<cfelse>
		<cfset comp_rep_citystatezip = #comp_rep_city# & #comp_rep_state# & #comp_rep_zip#>
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
	

	<cfparam name="alo_addr1" default="#alo_addr1#">
	<cfif alo_addr1 eq "1300 Evans Ave., Rm 217,P.O. Box 883790">
		<cfset alo_addr1 = "1300 Evans Ave., Rm 217, P.O. Box 883790">
	</cfif>

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
			   <cfcase value="1">
				 '#agency_no#',
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

			   <cfcase value="11">
				 '#comp_addr#',
			   </cfcase>

			   <cfcase value="13">
				 '#comp_citystatezip#',
			   </cfcase>

			   <cfcase value="14">
				 '#comp_eid#',
			   </cfcase>

			   <cfcase value="15">
				 '#comp_facility#',
			   </cfcase>


			   <cfcase value="16">
				 '#comp_fname#',
			   </cfcase>

			   <cfcase value="17">
				 '#comp_lname#',
			   </cfcase>

			   <cfcase value="18">
				 '#comp_rep_addr#',
			   </cfcase>

			   <cfcase value="20">
				 '#comp_rep_comp#',
			   </cfcase>

			   <cfcase value="21">
				 '#comp_rep_fname#',
			   </cfcase>

			   <cfcase value="22">
				 '#comp_rep_lname#',
			   </cfcase>

			   <cfcase value="23">
				 '#comp_ssn#',
			   </cfcase>
			   
			   <cfcase value="24">
				 '#comp_district#',
			   </cfcase>

			   <cfcase value="25">
				 '#dist_mgr#',
			   </cfcase>

			   <cfcase value="26">
				 '#eeoc_no#',
			   </cfcase>

			   <cfcase value="27">
				 '#eeoc_office#',
			   </cfcase>

			   <cfcase value="29">
				 '#comp_pronoun1#',
			   </cfcase>

			   <cfcase value="30">
				 '#comp_pronoun2#',
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

			   <cfcase value="44">
				 '#comp_prefix#',
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

			   <cfcase value="54">
				 '#comp_rep_fax#',
			   </cfcase>

			   <cfcase value="55">
				 '#comp_rep_citystatezip#',
			   </cfcase>

			   <cfcase value="56">
				 '#comp_rep_prefix#',
			   </cfcase>

			   <cfcase value="57">
				 '#UCase(comp_fname)#',
			   </cfcase>

			   <cfcase value="58">
				 '#UCase(comp_lname)#',
			   </cfcase>
			   
			   <cfcase value="59">
				 '#UCase(eeoc_office)#',
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
			   
			   <!---2/13/2026 added for date variable--->
			   <cfcase value="116">
				 '#DateFormat(Now(), "mmmm dd, yyyy")#',
			   </cfcase>	

			   <cfcase value="158">
				 '#(qry_attny_email.eaddress)#',
			   </cfcase>

			   <cfcase value="161">
				 '#(sentence_extra)#',
			   </cfcase>

			   <cfcase value="162">
				 '#(comp_city)#',
			   </cfcase>

			   <cfcase value="163">
				 '#(comp_zip)#',
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






	<!---****** Correct the mix casing of an attorney ******--->
	<cfif attorney_name eq "Sherilyn Deninno">
		<cfset attorney_name = "Sherilyn DeNinno">
	</cfif>

	<!---****** retreiveing all relevant template variables ******--->
	<cfquery name="qry_cmft_tempvars" datasource="lawmanager">
	  select tempvar_key, tempvar_name from lawmanager.cmft_tempvars where (matter_type_key = 5 or matter_type_key = 0) and control is null
	</cfquery>


	<!---****** retreiveing attorney email from EADDARESS table for the selected attorney name ******--->
	<cfquery name="qry_attny_email" datasource="lawmanager">
	  select eaddress from entity a, cmft_entity_wo b, eaddress c where a.entity_key = b.entity_key and b.attorney_name = '#attorney_name#' and a.entity_key=c.entity_key
	</cfquery>



	<!---****** Setting all uppercase names to proper case before inserts ******--->
	
	<!---
	<cfparam name="ausa_city" default="#ausa_city#">
	<cfset ausa_city = REReplace(LCase(ausa_city), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>
	--->
	
	<cfparam name="plaintiff_facility" default="#plaintiff_facility#">
	<cfset plaintiff_facility = REReplace(LCase(plaintiff_facility), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>
	<cfset temp_fac = #find("&",plaintiff_facility)#>
	
	<cfif temp_fac gt 0>
		<cfset sentence = "plaintiff_facility">	
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


	<cfparam name="plaintiff_district" default="#plaintiff_district#">
	<cfset plaintiff_district = REReplace(LCase(plaintiff_district), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>


	<!---****** Concatenating variables that are grouped (city, state, zip) together for correct display ******--->
	
	<cfif len(trim(#plaintiff_city#)) && len(trim(#plaintiff_state#)) && len(trim(#plaintiff_zip#))>
		<cfset plaintiff_citystzip = #plaintiff_city# & ", " & #plaintiff_state# & " " & #plaintiff_zip#>
	<cfelse>
		<cfset plaintiff_citystzip = #plaintiff_city# & #plaintiff_state# & #plaintiff_zip#>
	</cfif>

	<cfif len(trim(#plaintiff_rep_city#)) && len(trim(#plaintiff_rep_state#)) && len(trim(#plaintiff_rep_zip#))>
		<cfset plaintiff_rep_citystzip = #plaintiff_rep_city# & ", " & #plaintiff_rep_state# & " " & #plaintiff_rep_zip#>
	<cfelse>
		<cfset plaintiff_rep_citystzip = #plaintiff_rep_city# & #plaintiff_rep_state# & #plaintiff_rep_zip#>
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
	
	<cfquery name="Insert_cmft_matterkey_pairs" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
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

			   <cfcase value="86">
				 '#plaintiff_fname#',
			   </cfcase>

			   <cfcase value="87">
				 '#plaintiff_lname#',
			   </cfcase>

			   <cfcase value="89">
				 '#plaintiff_eid#',
			   </cfcase>
			   
			   <cfcase value="88">
				 '#plaintiff_ssn#',
			   </cfcase>			   
   
			   <cfcase value="112">
				 '#case_no#',
			   </cfcase>

			   <cfcase value="90">
				 '#plaintiff_addr#',
			   </cfcase>
			   
			   <cfcase value="91">
				 '#plaintiff_citystzip#',
			   </cfcase>	
			   
			   <cfcase value="55">
				 '#plaintiff_rep_citystzip#',
			   </cfcase>				   
			   
			   <cfcase value="92">
				 '#plaintiff_facility#',
			   </cfcase>			   		   

			   <cfcase value="24">
				 '#plaintiff_district#',
			   </cfcase>	

			   <cfcase value="103">
				 '#plaintiff_email#',
			   </cfcase>

			   <cfcase value="111">
				 '#plaintiff_rep_email#',
			   </cfcase>

			   <cfcase value="93">
				 '#defendant_name#',
			   </cfcase>

			   <cfcase value="94">
				 '#ausa_fname#',
			   </cfcase>

			   <cfcase value="95">
				 '#ausa_lname#',
			   </cfcase>

			   <cfcase value="96">
				 '#ausa_title#',
			   </cfcase>

			   <cfcase value="8">
				 '#attorney_name#',
			   </cfcase>

			   <cfcase value="9">
				 '#attorney_title#',
			   </cfcase>

			   <cfcase value="98">
				 '#ausa_addr1#',
			   </cfcase>

			   <cfcase value="99">
				 '#ausa_addr2#',
			   </cfcase>

			   <cfcase value="100">
				 '#ausa_citystzip#',
			   </cfcase>

			   <cfcase value="104">
				 '#ausa_bar_no#',
			   </cfcase>

			   <cfcase value="97">
				 '#ausa_district#',
			   </cfcase>

			   <cfcase value="25">
				 '#dist_mgr#',
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

			   <cfcase value="102">
				 '#ausa_prefix#',
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

			   <cfcase value="101">
				 '#ausa_fax#',
			   </cfcase>
		   
			   <cfcase value="110">
				 '#ausa_phone#',
			   </cfcase>
			   
			   <cfcase value="109">
				 '#ausa_us_attorney#',
			   </cfcase>
			   
			   <cfcase value="106">
				 '#ausa_email#',
			   </cfcase>
	
			   <cfcase value="60">
				 '#matternumber#',
			   </cfcase>

			   <cfcase value="107">
				 '#ausa_chief_fname#',
			   </cfcase>

			   <cfcase value="108">
				 '#ausa_chief_lname#',
			   </cfcase>

			   <cfcase value="73">
				 '#plaintiff_rep_fname#',
			   </cfcase>

			   <cfcase value="74">
				 '#plaintiff_rep_lname#',
			   </cfcase>

			   <cfcase value="75">
				 '#plaintiff_rep_company#',
			   </cfcase>

			   <cfcase value="76">
				 '#plaintiff_rep_addr#',
			   </cfcase>
			   
			   <cfcase value="78">
				 '#plaintiff_rep_phone#',
			   </cfcase>
			   
			   <cfcase value="79">
				 '#plaintiff_rep_fax#',
			   </cfcase>

			   <cfcase value="158">
				 '#(qry_attny_email.eaddress)#',
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





<!--*** insert, into cmft_dynamic_ans table, user selected answers to template questions per user/matterkey ***--->
<cfinclude template = "advice_fssc_cmft_dynamic_ans_insert.cfm">

<!--*** insert a single record in cmft_selected_templates for advice fssc template per user/matterkey***--->
<cfinclude template = "advice_fssc_cmft_selected_templates_insert.cfm">


	<!---****** retreiveing all relevant template variables ******--->
	<cfquery name="qry_cmft_tempvars" datasource="lawmanager">
		select tempvar_key, tempvar_name from lawmanager.cmft_tempvars 
		where (matter_type_key = 1 or tempvar_key=112 or tempvar_key=34 or tempvar_key=35 or tempvar_key=36 or tempvar_key=37 or tempvar_key=38 or tempvar_key=39 or tempvar_key=40 or tempvar_key=41 or tempvar_key=51 or tempvar_key=60)
	</cfquery>
	
	

<!*** initialize SUBFOR variable based on answer to question 1 *** --->
<cfif isDefined("answer1")>
 <cfswitch expression="#Trim(answer1)#"> 			   
  <cfcase value="1">
   <cfset subfor = 'Deposition Testimony'>
  </cfcase>
  <cfcase value="2">
   <cfset subfor = 'Records Production'>
  </cfcase>
  <cfcase value="3">
   <cfset subfor = 'Deposition Testimony and Production of Documents'>
  </cfcase>
  <cfdefaultcase>
  <cfset subfor = ''>,
  </cfdefaultcase>			   
 </cfswitch>			   
</cfif>

<!*** initialize PROVIDE variable based on answer to question 2 *** --->
<cfif isDefined("answer10")>
 <cfswitch expression="#Trim(answer10)#"> 			   
  <cfcase value="4">
   <cfset provide = 'Provide testimony'>
  </cfcase>
  <cfcase value="5">
   <cfset provide = 'Provide testimony and records'>
  </cfcase>
  <cfcase value="9">
   <cfset provide = 'Provide records'>
  </cfcase>  
  <cfdefaultcase>
  	<cfset provide = ''>,
  </cfdefaultcase>			   
 </cfswitch>			   
</cfif>

<!*** initialize sentence1a, sentence1b, sentence2a, sentence2b variables based on answer to question 2 *** --->
<cfif isDefined("answer11")>
	<cfif answer11 eq '1'>
		<cfset sentence1a="and the United States Attorney for the Central District of California">
		<cfset sentence1b="with a written statement pursuant to 39 C.F.R. \'a7 265.12(c)(2) that">	
		<cfset sentence2a="and to the United States Attorney c/o Leon W. Weidman, Chief, Civil Division">
		<cfset sentence2b="300 North Los Angeles Street, Room 7516, Los Angeles, CA 90012">	
	<cfelse>	
		<cfset sentence1a = "">
		<cfset sentence1b = "">
		<cfset sentence2a = "">
		<cfset sentence2b = "">						
	</cfif>
</cfif>



	<!---****** Setting all uppercase names to proper case before inserts ******--->

	<cfparam name="case_name" default="#case_name#">
	<cfset case_name = REReplace(LCase(case_name), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>
<!---
	<cfparam name="work_order_no" default="#work_order_no#">
	<cfset work_order_no = REReplace(LCase(work_order_no), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>
--->	
	<cfparam name="recipient_name" default="#recipient_name#">
	<cfset recipient_name = REReplace(LCase(recipient_name), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>

	<cfparam name="recipient_addr" default="#recipient_addr#">
	<cfset recipient_addr = REReplace(LCase(recipient_addr), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>

	<cfparam name="recipient_city" default="#recipient_city#">
	<cfset recipient_city = REReplace(LCase(recipient_city), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>


	<!---****** Concatenating citystzip (city, state, zip) together for correct display ******--->
	<cfif len(trim(#recipient_city#)) && len(trim(#recipient_state#)) && len(trim(#recipient_zip#))>
		<cfset recipient_citystatezip = #recipient_city# & ", " & #ucase(recipient_state)# & " " & #recipient_zip#>
	<cfelse>
		<cfset recipient_citystatezip = #recipient_city# & #recipient_state# & #recipient_zip#>
	</cfif>





	<cfparam name="customer_name" default="#customer_name#">
	<cfset customer_name = REReplace(LCase(customer_name), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>

	<cfparam name="po_loc_lkn_box" default="#po_loc_lkn_box#">
	<cfset po_loc_lkn_box = REReplace(LCase(po_loc_lkn_box), "(^[[:alpha:]]|[[:blank:]][[:alpha:]])", "\U\1\E", "ALL")>



	<!---****** initializing variables with fixed values******--->
	<cfif trim(#alo_office#) eq "Long Beach">
		<cfset alo_zip = "90802-2496">
	</cfif>
	
	<cfif trim(#alo_office#) eq "San Francisco">
		<cfset alo_zip = "94188-3790">
	</cfif>	

	<cfif trim(#alo_office#) eq "San Diego">
		<cfset alo_zip = "92197-4400">
	</cfif>	
	

	<cfparam name="alo_addr1" default="#alo_addr1#">
	<cfif alo_addr1 eq "1300 Evans Ave., Rm 217,P.O. Box 883790">
	 <cfset alo_addr1 = "1300 Evans Ave., Rm 217, P.O. Box 883790">
	</cfif>
	
	<!---*** Set and reset the fax_no, tracking number based on user selection ***--->
	<cfif via eq "Via Priority Mail with Tracking Number">
		<cfset fax_no = "">
	</cfif>

	<cfif via eq "Via Fax">
		<cfset tracking_no = "">
	</cfif>

	<cfif via eq "Via First Class Mail">
		<cfset fax_no = "">
		<cfset tracking_no = "">	
	</cfif>



	<!---****** and here, we finally insert all relevant variables into CMFT_MATTERKEY_PARIS ******--->
	<!---****** table. then, Greg's java program will read the entries in this table and     ******--->
	<!---****** processes all selected templates by replacing their empty variables with the ******--->
	<!---****** variable contents read from this table                                       ******--->
	
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

			   <cfcase value="60">
				 '#matternumber#',
			   </cfcase>

			   <cfcase value="112">
				  '#case_no#',
			   </cfcase>
			   
			   <cfcase value="113">
				  '#sentence1a#',
			   </cfcase>

			   <cfcase value="114">
			 	 '#sentence1b#',
			   </cfcase>

			   <cfcase value="115">
				  '#subfor#',
			   </cfcase>

			   <cfcase value="116">
				  '#DateFormat(today, "mmmm d, yyyy")#',
			   </cfcase>
			   
			   <cfcase value="117">
			   '#DateFormat(recvd_date, "mmmm d, yyyy")#',
			   </cfcase>			   

			   <cfcase value="118">
				  '#provide#',
			   </cfcase>

			   <cfcase value="119">
				  '#sentence2a#',
			   </cfcase>
			   
			   <cfcase value="120">
				  '#sentence2b#',
			   </cfcase>

			   <cfcase value="121">
				  '#via#',
			   </cfcase>

			   <cfcase value="122">
				  '#recipient_addr#',
			   </cfcase>

			   <cfcase value="123">
				  '#recipient_name#',
			   </cfcase>

			   <cfcase value="124">
				  '#(recipient_citystatezip)#',
			   </cfcase>

			   <cfcase value="125">
				  '#case_name#',
			   </cfcase>

			   <cfcase value="126">
				  '#work_order_no#',
			   </cfcase>

			   <cfcase value="127">
				  '#customer_name#',
			   </cfcase>

			   <cfcase value="128">
				  '#po_loc_lkn_box#',
			   </cfcase>

			   <cfcase value="129">
				  '#tracking_no#',
			   </cfcase>

			   <cfcase value="131">
				  '#fax_no#',
			   </cfcase>

			   <cfdefaultcase>
			   'none',
			   </cfdefaultcase>		
			   		   
			 </cfswitch>
			 			 
			 '#qry_cmft_tempvars.tempvar_key#',
	   TO_DATE('#TODAY#', 'mm/dd/YYYY'),
			 #owner_key#)
	</cfquery>	

<!---	
#answer10#<br>
#provide#<br>
#DateFormat(today, "mmmm d, yyyy")#<br>
#work_order_no#
--->	
	</cfoutput>






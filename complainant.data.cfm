
<!---******************** Complainant's Information Queries and variable settings - Begin ********************--->

<!--- Query Complainant's name, eid, facility and district --->
<cfquery name="qry_complainant" datasource="lawmanager">
	 <!---
		10/01/2021 --Updated to reflect the organizational changes and error that was caused in LL.  Data was not being set in the 
		cmft_matterkey_pairs table cmft_matterkey_pairs.COMP_CITYSTATEZIP
	 --->
	  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name, b.usps_eid as comp_eid, 
	  trim(d.finance_name) as comp_facility, 
	  trim(e.lvl2_desc) ||', ' || trim(e.lvl3_desc) as comp_district
	  from matter a, entity b, matterentity c, fncm d, matterclientorgsusps e
	  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
	  c.matter_entity_type_key=39  and a.usps_fac_id=d.lm_facility_key   and a.usps_client_orgs_key=e.usps_client_orgs_key
</cfquery>

<cfif qry_complainant.RecordCount gt 0>

	<cfif len(qry_complainant.comp_eid)>
		<cfset comp_eid = qry_complainant.comp_eid>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0><!--- if no data in LM for complainant EID, load screen with data the user submitted--->
			<cfset comp_eid = "">
		</cfif>
	</cfif>

	<cfset comp_fname = qry_complainant.first_name>
	<cfset comp_lname = qry_complainant.last_name>
	<cfset comp_facility = qry_complainant.comp_facility>
	<cfset comp_district = qry_complainant.comp_district>	




	<!--- Query Complainant's address --->
	<cfquery name="qry_comp_addr" datasource="lawmanager">
	  select a.entity_key, trim(b.street)as street, trim(b.city) as city, b.state, trim(b.zip_code) as zip_code
	  from entity a, address b
	  where a.entity_key=#qry_complainant.entity_key# and a.entity_key=b.entity_key
	</cfquery>
	
	<!---<CFOUTPUT>#comp_facility#</CFOUTPUT>	--->
	
	
	
	<cfif qry_comp_addr.RecordCount gt 0> <!---if above query returns data --->
		<cfif len(qry_comp_addr.street)> <!--- if street is not blank --->
			<cfset comp_addr = qry_comp_addr.street>
		<cfelse>
			<cfif not qry_last_submitted_data.RecordCount gt 0> <!--- if no entry in CMFT_MATTERKEY_PAIRS table from previous submission --->
				<cfset comp_addr = "">
			</cfif>
		</cfif>

		<cfif len(qry_comp_addr.city)> 
			<cfset comp_city = qry_comp_addr.city>
		<cfelse>
			<cfinclude template = "parse_comp_citystzip.cfm">		
		</cfif>
		
		<cfif len(qry_comp_addr.state)> 
			<cfset comp_state = qry_comp_addr.state>
		<cfelse>
			<cfset comp_state = "">		
		</cfif>

		<cfif len(qry_comp_addr.zip_code)> 
			<cfset comp_zip = qry_comp_addr.zip_code>
		<cfelse>
			<cfset comp_zip = "">		
		</cfif>

		
	<cfelse> <!---if no data from LM--->
	
		<!---comment***
		if no data has been entered in Lawmanager for complainant's address, fax, etc. repopulate 
		the complainant's misc. data with data from the last template submission for this matterkey
		by querying from cmft_matterkey_pairs for a specific matterkey.
		***--->

		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(comp_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset comp_city = ListFirst(comp_citystzip) >
				<cfset comp_state = Left(Trim(ListGetAt(comp_citystzip,1)),1)>
				<cfset zipindex = REFIND("[0-9]{5}",comp_citystzip)>
				<cfif zipindex gte 1>
					<cfset comp_zip = Mid(comp_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset comp_zip = 0>
				</cfif>	
			<cfelse>
				<cfset comp_city = "">
				<cfset comp_state = "">
				<cfset comp_zip = "">			
			</cfif>
		<cfelse>
			<cfset comp_addr= "">
			<cfset comp_city = "">
			<cfset comp_state = "">
			<cfset comp_zip = "">
		</cfif>
  </cfif>
	

	<!--- Query Complainant's phone --->
	<cfquery name="qry_comp_phone" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as comp_phone
	  from entity a, phone b
	  where a.entity_key=#qry_complainant.entity_key# and a.entity_key=b.entity_key
	</cfquery>
	<cfif qry_comp_phone.RecordCount gt 0>
		<cfset comp_phone = qry_comp_phone.comp_phone>
	<cfelse>
		  <cfset comp_phone = "">
 </cfif>


<cfelse>	<!--- Initilaize Complainant's variables if not present in LawManager --->

	<cfif qry_last_submitted_data.RecordCount gt 0>	<!---if there are submitted data from a previous submission --->
		<cfinclude template = "parse_comp_citystzip.cfm">
		<cfset comp_phone = "">
	<cfelse>

		<cfset comp_eid = "">
		<cfset comp_fname = "">
		<cfset comp_lname = "">
		<cfset comp_facility = "">
		<cfset comp_district = "">	
		<cfset comp_addr = "">
		<cfset comp_city = "">
		<cfset comp_state = "">
		<cfset comp_zip = "">
		<cfset comp_phone = "">

	</cfif>
		
</cfif>



<!--- Query Complainant's ssn --->
<cfif qry_complainant.RecordCount gt 0>
	<cfquery name="qry_ssn" datasource="lawmanager">
	  select ssn as comp_ssn from hr.emp_xref where entity_key = #qry_complainant.entity_key# 
	</cfquery> 
	<cfif qry_ssn.RecordCount gt 0>
		<cfif len(qry_ssn.comp_ssn)>
			<cfset comp_ssn = qry_ssn.comp_ssn>
		<cfelse>
			<cfset comp_ssn = "">
		</cfif>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0><!--- if no data in LM, load screen with data the user submitted--->
			<cfset comp_ssn = "">
		</cfif> 
	</cfif>
<cfelse>
	<cfset comp_ssn = "">
</cfif>


<!---
<cfif qry_plaintiff.RecordCount gt 0>
	<cfquery name="qry_ssn" datasource="lawmanager">
	  select ssn as plaintiff_ssn from hr.emp_xref where entity_key = #qry_plaintiff.entity_key# 
	</cfquery> 
	<cfif qry_ssn.RecordCount gt 0>
		<cfset plaintiff_ssn = qry_ssn.plaintiff_ssn>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0><!--- if no data in LM, load screen with data the user submitted--->
			<cfset plaintiff_ssn = "">
		</cfif> 
	</cfif>	
</cfif>

--->



<!--- Query case's agency number --->
<cfquery name="qry_agency_no" datasource="lawmanager">
  select forum_number from forum where matter_key=#url.matterkey# and venue_type_key=1101 and forum_type_key=1
</cfquery>
<cfif qry_agency_no.RecordCount gt 0>
	<cfset agency_no = qry_agency_no.forum_number>
<cfelse>  <!---otherwise grab from CMFT_MATTERKEY_PAIRS done in submitted.data.cfm script --->
	<cfif not qry_last_submitted_data.RecordCount gt 0>
		<cfset agency_no = "">
	</cfif>
</cfif>


<!--- Query case's eeoc number --->
<!---*****Need to dispaly th latest EEOC number, if more than one *****--->
<cfquery name="qry_eeoc_no" datasource="lawmanager">
  select forum_number from forum where matter_key=#url.matterkey# and venue_type_key like '8%' order by forum_number desc
</cfquery>


<cfif qry_eeoc_no.RecordCount gt 0>
	<cfset eeoc_no = qry_eeoc_no.forum_number>
<cfelse> <!---otherwise grab from CMFT_MATTERKEY_PAIRS done in submitted.data.cfm script --->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset eeoc_no = "">
		</cfif>
</cfif>



<!---<cfoutput> #eeoc_no# </cfoutput>--->






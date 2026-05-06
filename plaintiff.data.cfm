



<!---******************** Plaintiff's Information Queries and variable settings - Begin ********************--->

<!--- Query Plaintiff's name, eid, facility and district --->
<cfquery name="qry_plaintiff" datasource="lawmanager">
  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name, b.usps_eid as plaintiff_eid, 
  trim(d.finance_name)  as plaintiff_facility, 
  trim(e.lvl2_desc) ||', ' || trim(e.lvl3_desc) as plaintiff_district
  from matter a, entity b, matterentity c, fncm d, matterclientorgsusps e
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
  c.matter_entity_type_key=33  and a.usps_fac_id=d.lm_facility_key   and a.usps_client_orgs_key=e.usps_client_orgs_key
</cfquery>


<!---<cfoutput>#qry_last_submitted_data.RecordCount#</cfoutput>--->

<cfif qry_plaintiff.RecordCount gt 0>

	<cfif len(qry_plaintiff.plaintiff_eid)>
		<cfset plaintiff_eid = qry_plaintiff.plaintiff_eid>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0><!--- if no data in LM for plaintiff EID, load screen with data the user submitted--->
			<cfset plaintiff_eid = "">
		</cfif>
	</cfif>
	
	<cfset plaintiff_fname = qry_plaintiff.first_name>
	<cfset plaintiff_lname = qry_plaintiff.last_name>
	<cfset plaintiff_facility = qry_plaintiff.plaintiff_facility>
	<cfset plaintiff_district = qry_plaintiff.plaintiff_district>	


	<!--- Query Plaintiff's address --->
	<cfquery name="qry_plaintiff_addr" datasource="lawmanager">
	  select a.entity_key, trim(b.street)as street, trim(b.city) as city, b.state, trim(b.zip_code) as zip_code, c.eaddress as email
	  from entity a, address b, eaddress c
	  where a.entity_key=#qry_plaintiff.entity_key# and a.entity_key=b.entity_key(+) and a.entity_key=c.entity_key(+)
	</cfquery>
	
	<!---<CFOUTPUT>#qry_last_submitted_data.RecordCount#</CFOUTPUT>--->

	<cfif qry_plaintiff_addr.RecordCount gt 0> <!---if above query returns data --->
		<cfif len(qry_plaintiff_addr.street)> <!--- if street is not blank --->
			<cfset plaintiff_addr = qry_plaintiff_addr.street>
		<cfelse>
			<cfif not qry_last_submitted_data.RecordCount gt 0> <!--- if no entry in CMFT_MATTERKEY_PAIRS table from previous submission --->
				<cfset plaintiff_addr = "">
			</cfif>
		</cfif>

		<cfif len(qry_plaintiff_addr.city)> 
			<cfset plaintiff_city = qry_plaintiff_addr.city>
		<cfelse>
			<cfinclude template = "parse_plaintiff_citystzip.cfm">
		</cfif>
		
		<cfif len(qry_plaintiff_addr.state)> 
			<cfset plaintiff_state = qry_plaintiff_addr.state>
		<cfelse>
			<cfinclude template = "parse_plaintiff_citystzip.cfm">			
		</cfif>

		<cfif len(qry_plaintiff_addr.zip_code)> 
			<cfset plaintiff_zip = qry_plaintiff_addr.zip_code>
		<cfelse>
			<cfinclude template = "parse_plaintiff_citystzip.cfm">		
		</cfif>

		<cfif len(qry_plaintiff_addr.email)> 
			<cfset plaintiff_email = qry_plaintiff_addr.email>
		<cfelse>
			<cfif not qry_last_submitted_data.RecordCount gt 0><!---if there is no data for emai from previous submission then initialze--->
				<cfset plaintiff_email = "">
			</cfif>	
		</cfif>


	<cfelse> <!---if no data from LM--->
	
		<!---comment***
		if no data has been entered in Lawmanager for plaintiff's address, fax, etc. repopulate 
		the plaintiff's misc. data with data from the last template submission for this matterkey
		by querying from cmft_matterkey_pairs for a specific matterkey.
		***--->

		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(plaintiff_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset plaintiff_city = ListFirst(plaintiff_citystzip) >
				<cfset plaintiff_state = Left(Trim(ListGetAt(plaintiff_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",plaintiff_citystzip)>
				<cfif zipindex gte 1>
					<cfset plaintiff_zip = Mid(plaintiff_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset plaintiff_zip = 0>
				</cfif>	
			<cfelse>
				<cfset plaintiff_city = "">
				<cfset plaintiff_state = "">
				<cfset plaintiff_zip = "">			
			</cfif>
		<cfelse>
			<cfset plaintiff_addr= "">
			<cfset plaintiff_city = "">
			<cfset plaintiff_state = "">
			<cfset plaintiff_zip = "">
			<cfset plaintiff_email = "">
		</cfif>
  </cfif>
	

<cfelse>	<!--- Initilaize Plaintiff's variables if not present in LawManager --->

	<cfif qry_last_submitted_data.RecordCount gt 0>	<!---if there are submitted data from a previous submission --->
		<cfinclude template = "parse_plaintiff_citystzip.cfm">
	<cfelse>
		<cfset plaintiff_eid = "">
		<cfset plaintiff_ssn = "">		
		<cfset plaintiff_fname = "">
		<cfset plaintiff_lname = "">
		<cfset plaintiff_facility = "">
		<cfset plaintiff_district = "">	
		<cfset plaintiff_addr = "">
		<cfset plaintiff_city = "">
		<cfset plaintiff_state = "">
		<cfset plaintiff_zip = "">
		<cfset plaintiff_phone = "">
		<cfset plaintiff_email = "">
		
	</cfif>
</cfif>


<!--- Query Plaintiff's ssn --->
<cfif qry_plaintiff.RecordCount gt 0>
	<cfquery name="qry_ssn" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
	  select ssn as plaintiff_ssn from hr.emp_xref where entity_key = #qry_plaintiff.entity_key# 
	</cfquery> 
	<cfif qry_ssn.RecordCount gt 0>
		<cfif len(qry_ssn.plaintiff_ssn)>
			<cfset plaintiff_ssn = qry_ssn.plaintiff_ssn>
		<cfelse>
			<cfset plaintiff_ssn = "">			
		</cfif>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0><!--- if no data in LM, load screen with data the user submitted--->
			<cfset plaintiff_ssn = "">
		</cfif> 
	</cfif>
<cfelse>
	<cfset comp_ssn = "">		
</cfif>



<!--- Query case's docket number --->
<cfquery name="qry_docket_no" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
  select forum_number from forum where matter_key=#url.matterkey# and (venue_type_key=10 or venue_type_key=11 or venue_type_key=12 or venue_type_key=13) and forum_type_key=3
</cfquery>
<cfif qry_docket_no.RecordCount gt 0>
	<cfset case_no = qry_docket_no.forum_number>
<cfelse>  <!---otherwise grab from CMFT_MATTERKEY_PAIRS done in submitted.data.cfm script --->
	<cfif not qry_last_submitted_data.RecordCount gt 0>
		<cfset case_no = "">
	</cfif>
</cfif>


<!--- Query Defendant's name,  --->
<cfquery name="qry_defendant" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
  select b.entity_key, trim(b.name) as defendant
  from matter a, entity b, matterentity c
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
  c.matter_entity_type_key=36  
</cfquery>

<cfif qry_defendant.RecordCount gt 0>
	<cfif len(qry_defendant.defendant)> <!--- if street is not blank --->
		<cfset defendant_name = qry_defendant.defendant>
	</cfif>
<cfelse>
	<cfif not qry_last_submitted_data.RecordCount gt 0> <!--- if no entry in CMFT_MATTERKEY_PAIRS table from previous submission --->
		<cfset defendant_name = "">
	</cfif>
</cfif>







<!---******************** Appellant's Information Queries and variable settings - Begin ********************--->

<!--- Query Appellant's name, eid, facility and district --->
<cfquery name="qry_appellant" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name, b.usps_eid as appellant_eid, 
  trim(d.finance_name) as appellant_facility, 
  trim(e.lvl2_desc) ||', ' || trim(e.lvl3_desc) as appellant_district
  from matter a, entity b, matterentity c, fncm d, matterclientorgsusps e
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
  c.matter_entity_type_key=38  and a.usps_fac_id=d.lm_facility_key   and a.usps_client_orgs_key=e.usps_client_orgs_key
</cfquery>



<cfif qry_appellant.RecordCount gt 0>

	<cfif len(qry_appellant.appellant_eid)>
		<cfset appellant_eid = qry_appellant.appellant_eid>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0><!--- if no data in LM for appellant EID, load screen with data the user submitted--->
			<cfset appellant_eid = "">
		</cfif>
	</cfif>

	<cfset appellant_fname = qry_appellant.first_name>
	<cfset appellant_lname = qry_appellant.last_name>
	<cfset appellant_facility = qry_appellant.appellant_facility>
	<cfset appellant_district = qry_appellant.appellant_district>	


	<!--- Query Appellant's address --->
	<cfquery name="qry_appellant_addr" datasource="#datasrc#" username="lawmanager" password="zaq1xsw2ZAQ!XSW">
	  select a.entity_key, trim(b.street)as street, trim(b.city) as city, b.state, trim(b.zip_code) as zip_code, eaddress as email
	  from entity a, address b, eaddress c
	  where a.entity_key=#qry_appellant.entity_key# and a.entity_key=b.entity_key(+) and a.entity_key=c.entity_key(+)
	</cfquery>

	<!---<CFOUTPUT>#len(qry_appellant_addr.city)#</CFOUTPUT>--->
	
	
	<cfif qry_appellant_addr.RecordCount gt 0> <!---if above query returns data --->
		<cfif len(qry_appellant_addr.street)> <!--- if street is not blank --->
			<cfset appellant_addr = qry_appellant_addr.street>
		<cfelse>
			<cfif not qry_last_submitted_data.RecordCount gt 0> <!--- if no entry in CMFT_MATTERKEY_PAIRS table from previous submission --->
				<cfset appellant_addr = "">
			</cfif>
		</cfif>

		<cfif len(qry_appellant_addr.city)> 
			<cfset appellant_city = qry_appellant_addr.city>
		<cfelse>
			<cfinclude template = "parse_appellant_citystzip.cfm">
		</cfif>
		
		<cfif len(qry_appellant_addr.state)> 
			<cfset appellant_state = qry_appellant_addr.state>
		<cfelse>
			<cfinclude template = "parse_appellant_citystzip.cfm">		
		</cfif>

		<cfif len(qry_appellant_addr.zip_code)> 
			<cfset appellant_zip = qry_appellant_addr.zip_code>
		<cfelse>
			<cfinclude template = "parse_appellant_citystzip.cfm">		
		</cfif>
		
		<!---<cfoutput>#len(qry_appellant_addr.email)#</cfoutput>--->
		<cfif len(qry_appellant_addr.email)> 
			<cfset appellant_email = qry_appellant_addr.email>
		<cfelse>
			<cfif not qry_last_submitted_data.RecordCount gt 0><!---if there is no data for emai from previous submission then initialze--->
				<cfset appellant_email = "">
			</cfif>	
		</cfif>

		
	<cfelse> <!---if no data from LM--->
	
		<!---comment***
		if no data has been entered in Lawmanager for appellant's address, fax, etc. repopulate 
		the appellant's misc. data with data from the last template submission for this matterkey
		by querying from cmft_matterkey_pairs for a specific matterkey.
		***--->

		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(appellant_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset appellant_city = ListFirst(appellant_citystzip) >
				<cfset appellant_state = Left(Trim(ListGetAt(appellant_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",appellant_citystzip)>
				<cfif zipindex gte 1>
					<cfset appellant_zip = Mid(appellant_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset appellant_zip = 0>
				</cfif>	
			<cfelse>
				<cfset appellant_city = "">
				<cfset appellant_state = "">
				<cfset appellant_zip = "">			
			</cfif>
		<cfelse>
			<cfset appellant_addr= "">
			<cfset appellant_city = "">
			<cfset appellant_state = "">
			<cfset appellant_zip = "">
			<cfset appellant_email = "">
		</cfif>
  </cfif>	
	
	<!--- Query Appellant's phone --->
	<cfquery name="qry_appellant_phone" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as appellant_phone
	  from entity a, phone b
	  where a.entity_key=#qry_appellant.entity_key# and a.entity_key=b.entity_key
	</cfquery>
	<cfif qry_appellant_phone.RecordCount gt 0>
		<cfset appellant_phone = qry_appellant_phone.appellant_phone>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset appellant_phone = "">
		</cfif>
  </cfif>	



	
<cfelse>	<!--- Initilaize Appellant's variables if not present in LawManager --->

	<cfif qry_last_submitted_data.RecordCount gt 0>	<!---if there are submitted data from a previous submission --->
		<cfinclude template = "parse_appellant_citystzip.cfm">
		<cfset appellant_phone = "">
	<cfelse>

		<cfset appellant_eid = "">
		<cfset appellant_ssn = "">		
		<cfset appellant_fname = "">
		<cfset appellant_lname = "">
		<cfset appellant_facility = "">
		<cfset appellant_district = "">	
		<cfset appellant_addr = "">
		<cfset appellant_city = "">
		<cfset appellant_state = "">
		<cfset appellant_zip = "">
		<cfset appellant_phone = "">
		<cfset appellant_email = "">		

	</cfif>		
	
</cfif>



<!--- Query Appellant's ssn --->
<cfif qry_appellant.RecordCount gt 0>
	<cfquery name="qry_ssn" datasource="lawmanager">
	  select ssn as appellant_ssn from hr.emp_xref where entity_key = #qry_appellant.entity_key# 
	</cfquery> 
	<cfif qry_ssn.RecordCount gt 0>
		<cfif len(qry_ssn.appellant_ssn)>
			<cfset appellant_ssn = qry_ssn.appellant_ssn>
		<cfelse>
			<cfset appellant_ssn = "">
		</cfif>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0><!--- if no data in LM, load screen with data the user submitted--->
			<cfset appellant_ssn = "">
		</cfif> 
	</cfif>
<cfelse>
	<cfset comp_ssn = "">	
</cfif>

<!---<cfoutput>#qry_ssn.RecordCount#</cfoutput>--->

<!--- Query case's Docket Number --->
<cfquery name="qry_docket_no" datasource="lawmanager">
  select forum_number from forum where matter_key=#url.matterkey# and venue_type_key=700 and forum_type_key=4
</cfquery>
<cfif qry_docket_no.RecordCount gt 0>
	<cfset docket_no = qry_docket_no.forum_number>
<cfelse>  <!---otherwise grab from CMFT_MATTERKEY_PAIRS done in submitted.data.cfm script --->
	<cfif not qry_last_submitted_data.RecordCount gt 0>
		<cfset docket_no = "">
	</cfif>
</cfif>


<!---****************** Complainant Rep.'s Information Queries and variable settings Begin*******************--->

<!--- Query Complainant Rep's. name, address, facility and district --->
<cfquery name="qry_complainant_rep" datasource="lawmanager">
  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name
  from matter a, entity b, matterentity c
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
  c.matter_entity_type_key=21 order by c.start_date desc 
</cfquery>


<cfif qry_complainant_rep.RecordCount gt 0>
	<cfset comp_rep_fname = qry_complainant_rep.first_name>
	<cfset comp_rep_lname = qry_complainant_rep.last_name>


	<!--- Query Complainant Rep.'s company --->
	<cfquery name="qry_complainant_rep_company" datasource="lawmanager">
		select name from ENTITY t where entity_key=#qry_complainant_rep.entity_key# and entity_type_key =21 and person_company_flag='C' 
	</cfquery>
	<cfif qry_complainant_rep_company.RecordCount gt 0>
		<cfset comp_rep_comp = qry_complainant_rep_company.office_name>
	<cfelse><!---when Complianant Rep. is in LM but no Comp. Rep. Comapny data is there from previous submssion	--->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset comp_rep_comp = "">
		</cfif>	
	</cfif>



	<!--- Query Complainant Rep.'s address --->
	<cfquery name="qry_comp_rep_addr" datasource="lawmanager">
	  select a.entity_key, trim(b.street)as street, trim(b.city) as city, b.state, trim(b.zip_code) as zip_code
	  from entity a, address b
	  where a.entity_key=#qry_complainant_rep.entity_key# and a.entity_key=b.entity_key
	</cfquery>
	
	<cfif qry_comp_rep_addr.RecordCount gt 0>
		<cfif len(qry_comp_rep_addr.street)> <!--- if street address is in LM, get it, else populate from last submitted data --->
			<cfset comp_rep_addr = qry_comp_rep_addr.street>
		<cfelse>
			<cfif not qry_last_submitted_data.RecordCount gt 0> <!--- if no entry in CMFT_MATTERKEY_PAIRS table from previous submission --->
				<cfset comp_rep_addr = "">
			</cfif>
		</cfif>


		<!---<cfset comp_rep_city = qry_comp_rep_addr.city>--->
		<cfif len(qry_comp_rep_addr.city)>
			<cfset comp_rep_city = qry_comp_rep_addr.city>
		<cfelse>
			<cfinclude template = "parse_comp_rep_citystzip.cfm">
		</cfif>

		
		<!---<cfset comp_rep_state = qry_comp_rep_addr.state>--->
		<cfif len(qry_comp_rep_addr.state)>
			<cfset comp_rep_state = qry_comp_rep_addr.state>
		<cfelse>
			<cfinclude template = "parse_comp_rep_citystzip.cfm">
		</cfif>

		
		<cfif len(qry_comp_rep_addr.zip_code)>
			<cfset comp_rep_zip = qry_comp_rep_addr.zip_code>
		<cfelse>
			<cfinclude template = "parse_comp_rep_citystzip.cfm">
		</cfif>
		<!---<cfoutput>#comp_rep_zip#</cfoutput>--->
	<cfelse> <!---if no data from LM--->
	
		<!---comment***
		if no data has been entered in Lawmanager for Complainant Rep.s' address, fax, etc. repopulate 
		the comp. rep.'s misc. data with data from the last template submission for this matterkey
		by querying from cmft_matterkey_pairs for a specific matterkey.
		***--->

		<cfif qry_last_submitted_data.RecordCount gt 0> 
        	<!---Also check for list with one index--->
            
            
			<cfif isdefined("comp_rep_citystzip") and len(comp_rep_citystzip) and listlen(comp_rep_citystzip)gt 1> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset comp_rep_city = ListFirst(comp_rep_citystzip) >
				<cfset comp_rep_state = Left(Trim(ListGetAt(comp_rep_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",comp_rep_citystzip)>
				<cfif zipindex gte 1>
					<cfset comp_rep_zip = Mid(comp_rep_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset comp_rep_zip = 0>
				</cfif>	
			<cfelse>
				<cfset comp_rep_city = "">
				<cfset comp_rep_state = "">
				<cfset comp_rep_zip = "">			
			</cfif>
		<cfelse>
			<cfset comp_rep_addr= "">
			<cfset comp_rep_city = "">
			<cfset comp_rep_state = "">
			<cfset comp_rep_zip = "">
		</cfif>
  </cfif>
	

	

	<!--- Query Complainant Rep.'s phone --->
	<cfquery name="qry_comp_rep_phone" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as comp_rep_phone
	  from entity a, phone b
	  where a.entity_key=#qry_complainant_rep.entity_key# and a.entity_key=b.entity_key 
	  and (b.phone_type_key=2 or b.phone_type_key=3 or b.phone_type_key=4 or phone_type_key=6)
	</cfquery>
	<cfif qry_comp_rep_phone.RecordCount gt 0>
		<cfset comp_rep_phone = qry_comp_rep_phone.comp_rep_phone>
	<cfelse>
		<cfset comp_rep_phone = "">
	</cfif>


	<!--- Query Complainant Rep's fax --->
	<cfquery name="qry_comp_rep_fax" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as comp_rep_fax
	  from entity a, phone b
	  where a.entity_key=#qry_complainant_rep.entity_key# and a.entity_key=b.entity_key 
	  and b.phone_type_key=5 
	</cfquery>
	<cfif qry_comp_rep_fax.RecordCount gt 0>
		<cfset comp_rep_fax = qry_comp_rep_fax.comp_rep_fax>
	<cfelse><!---when Complianant Rep. is in LM but no Comp. Rep. fax data is there from previous submssion	--->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset comp_rep_fax = "">
		</cfif>	
	</cfif>

<cfelse>

	<cfif qry_last_submitted_data.RecordCount gt 0>	<!---if there are submitted data from a previous submission --->
		<cfinclude template = "parse_comp_rep_citystzip.cfm">
		<cfset comp_rep_phone = "">
	<cfelse>

		<cfset comp_rep_fname = "">
		<cfset comp_rep_lname = "">
		<cfset comp_rep_comp = "">
		<cfset comp_rep_addr = "">
		<cfset comp_rep_city = "">
		<cfset comp_rep_state = "">
		<cfset comp_rep_zip = "">	
		<cfset comp_rep_phone = "">
		<cfset comp_rep_fax = "">
	</cfif>
	
</cfif>

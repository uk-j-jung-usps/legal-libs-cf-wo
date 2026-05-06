

<!---****************** Plaintiff Rep.'s Information Queries and variable settings Begin*******************--->

<!--- Query Plaintiff Rep's. name, address, facility and district --->
<cfquery name="qry_plaintiff_rep" datasource="lawmanager">
  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name
  from matter a, entity b, matterentity c
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
  c.matter_entity_type_key=37  
</cfquery>

<!---<cfoutput>#qry_plaintiff_rep.RecordCount#</cfoutput>--->

<cfif qry_plaintiff_rep.RecordCount gt 0>
	<cfset plaintiff_rep_fname = qry_plaintiff_rep.first_name>
	<cfset plaintiff_rep_lname = qry_plaintiff_rep.last_name>



	<!--- Query Plaintiff Rep.'s company --->
	<cfquery name="qry_plaintiff_rep_company" datasource="lawmanager">
		select name from ENTITY t where entity_key=#qry_plaintiff_rep.entity_key# and entity_type_key =37 and person_company_flag='C' 
	</cfquery>
	<cfif qry_plaintiff_rep_company.RecordCount gt 0>
		<cfset plaintiff_rep_company = qry_plaintiff_rep_company.name>
	<cfelse><!---when Plaintiff Rep. is in LM but no Plaintiff Rep. Comapny data is there from previous submssion	--->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset plaintiff_rep_company = "">
		</cfif>	
	</cfif>
	
	<!--- Query Plaintiff Rep.'s address --->
	<cfquery name="qry_plaintiff_rep_addr" datasource="lawmanager">
	  select a.entity_key, trim(b.street)as street, trim(b.city) as city, b.state, trim(b.zip_code) as zip_code, c.eaddress as email
	  from entity a, address b, eaddress c
	  where a.entity_key=#qry_plaintiff_rep.entity_key# and a.entity_key=b.entity_key(+) and a.entity_key=c.entity_key(+)
	</cfquery>
	
	<cfif qry_plaintiff_rep_addr.RecordCount gt 0>
 
		<cfif len(qry_plaintiff_rep_addr.street)> <!--- if street address is in LM, get it, else populate from last submitted data --->
			<cfset plaintiff_rep_addr = qry_plaintiff_rep_addr.street>
		<cfelse>
			<cfinclude template = "parse_plaintiff_rep_citystzip.cfm">
		</cfif>	

		<cfif len(qry_plaintiff_rep_addr.city)>
			<cfset plaintiff_rep_city = qry_plaintiff_rep_addr.city>
		<cfelse>
			<cfinclude template = "parse_plaintiff_rep_citystzip.cfm">
		</cfif>

		<cfif len(qry_plaintiff_rep_addr.state)>
			<cfset plaintiff_rep_state = qry_plaintiff_rep_addr.state>
		<cfelse>
			<cfinclude template = "parse_plaintiff_rep_citystzip.cfm">
		</cfif>

		<cfif len(qry_plaintiff_rep_addr.zip_code)>
			<cfset plaintiff_rep_zip = qry_plaintiff_rep_addr.zip_code>
		<cfelse>
			<cfinclude template = "parse_plaintiff_rep_citystzip.cfm">
		</cfif>
		
		<cfif len(qry_plaintiff_rep_addr.email)> 
			<cfset plaintiff_rep_email = qry_plaintiff_rep_addr.email>
		<cfelse>
			<cfset plaintiff_rep_email = "">		
		</cfif>		
		
		
		<!---<cfoutput>#plaintiff_rep_zip#</cfoutput>--->
		
	<cfelse> <!---if no data from LM--->

		<!---comment***
		if no data has been entered in Lawmanager for Plaintiff Rep.s' address, fax, etc. repopulate 
		the appellant rep.'s misc. data with data from the last template submission for this matterkey
		by querying from cmft_matterkey_pairs for specific matterkey.
		***--->

		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(plaintiff_rep_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset plaintiff_rep_city = ListFirst(plaintiff_rep_citystzip) >
				<cfset plaintiff_rep_state = Left(Trim(ListGetAt(plaintiff_rep_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",plaintiff_rep_citystzip)>
				<cfif zipindex gte 1>
					<cfset plaintiff_rep_zip = Mid(plaintiff_rep_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset plaintiff_rep_zip = 0>
				</cfif>	
			<cfelse>
				<cfset plaintiff_rep_city = "">
				<cfset plaintiff_rep_state = "">
				<cfset plaintiff_rep_zip = "">			
			</cfif>
		<cfelse>
			<cfset plaintiff_rep_addr= "">
			<cfset plaintiff_rep_city = "">
			<cfset plaintiff_rep_state = "">
			<cfset plaintiff_rep_zip = "">
			<cfset plaintiff_rep_email = "">			
		</cfif>

	</cfif>


	<!--- Query Plaintiff Rep.'s phone --->
	<cfquery name="qry_plaintiff_rep_phone" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as plaintiff_rep_phone
	  from entity a, phone b
	  where a.entity_key=#qry_plaintiff_rep.entity_key# and a.entity_key=b.entity_key and 
	  (b.phone_type_key=2 or b.phone_type_key=3 or b.phone_type_key=4 or phone_type_key=6)
	</cfquery>
	<cfif qry_plaintiff_rep_phone.RecordCount gt 0>
		<cfset plaintiff_rep_phone = qry_plaintiff_rep_phone.plaintiff_rep_phone>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset plaintiff_rep_phone = "">
		</cfif>	
	</cfif>



	<!--- Query Plaintiff Rep's fax --->
	<cfquery name="qry_plaintiff_rep_fax" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as plaintiff_rep_fax
	  from entity a, phone b
	  where a.entity_key=#qry_plaintiff_rep.entity_key# and a.entity_key=b.entity_key 
	  and b.phone_type_key=5 
	</cfquery>
	<cfif qry_plaintiff_rep_fax.RecordCount gt 0>
		<cfset plaintiff_rep_fax = qry_plaintiff_rep_fax.plaintiff_rep_fax>
	<cfelse><!---initialize when no data from a previous submission	--->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset plaintiff_rep_fax = "">
		</cfif>	
	</cfif>

	
<cfelse>

	<cfif qry_last_submitted_data.RecordCount gt 0>	<!---if there are submitted data from a previous submission --->
		<cfinclude template = "parse_plaintiff_rep_citystzip.cfm">

	<cfelse>
		<cfset plaintiff_rep_fname = "">
		<cfset plaintiff_rep_lname = "">
		<cfset plaintiff_rep_company = "">
		<cfset plaintiff_rep_addr = "">
		<cfset plaintiff_rep_city = "">
		<cfset plaintiff_rep_state = "">
		<cfset plaintiff_rep_zip = "">	
		<cfset plaintiff_rep_phone = "">
		<cfset plaintiff_rep_fax = "">
		<cfset plaintiff_rep_email = "">
	</cfif>

</cfif>	
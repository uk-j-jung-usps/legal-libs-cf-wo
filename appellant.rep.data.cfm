

<!---****************** Appellant Rep.'s Information Queries and variable settings Begin*******************--->

<!--- Query Appellant Rep's. name, address, facility and district --->
<cfquery name="qry_appellant_rep" datasource="lawmanager">
  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name
  from matter a, entity b, matterentity c
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
  c.matter_entity_type_key=12  
</cfquery>


<cfif qry_appellant_rep.RecordCount gt 0>
	<cfset appellant_rep_fname = qry_appellant_rep.first_name>
	<cfset appellant_rep_lname = qry_appellant_rep.last_name>


	<!--- Query Appellant Rep.'s company --->
	<cfquery name="qry_appellant_rep_company" datasource="lawmanager">
		select name from ENTITY t where entity_key=#qry_appellant_rep.entity_key# and entity_type_key =12 and person_company_flag='C' 
	</cfquery>
	<cfif qry_appellant_rep_company.RecordCount gt 0>
		<cfset appellant_rep_company = qry_appellant_rep_company.name>
	<cfelse><!---when Appellant Rep. is in LM but no Appellant Rep. Comapny data is there from previous submssion	--->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset appellant_rep_company = "">
		</cfif>	
	</cfif>
	
	<!--- Query Appellant Rep.'s address --->
	<cfquery name="qry_appellant_rep_addr" datasource="lawmanager">
	  select a.entity_key, trim(b.street)as street, trim(b.city) as city, b.state, trim(b.zip_code) as zip_code
	  from entity a, address b
	  where a.entity_key=#qry_appellant_rep.entity_key# and a.entity_key=b.entity_key
	</cfquery>
	
	<cfif qry_appellant_rep_addr.RecordCount gt 0>
 
		<cfif len(qry_appellant_rep_addr.street)> <!--- if street address is in LM, get it, else populate from last submitted data --->
			<cfset appellant_rep_addr = qry_appellant_rep_addr.street>
		<cfelse>
			<cfset appellant_rep_addr = "">
		</cfif>	
	

		<cfif len(qry_appellant_rep_addr.city)>
			<cfset appellant_rep_city = qry_appellant_rep_addr.city>
		<cfelse>
			<cfinclude template = "parse_appellant_rep_citystzip.cfm">
		</cfif>


		<cfif len(qry_appellant_rep_addr.state)>
			<cfset appellant_rep_state = qry_appellant_rep_addr.state>
		<cfelse>
			<cfinclude template = "parse_appellant_rep_citystzip.cfm">
		</cfif>

		<cfif len(qry_appellant_rep_addr.zip_code)>
			<cfset appellant_rep_zip = qry_appellant_rep_addr.zip_code>
		<cfelse>
			<cfinclude template = "parse_appellant_rep_citystzip.cfm">
		</cfif>
		<!---<cfoutput>#appellant_rep_zip#</cfoutput>--->
		
	<cfelse> <!---if no data from LM--->

		<!---comment***
		if no data has been entered in Lawmanager for Appellant Rep.s' address, fax, etc. repopulate 
		the appellant rep.'s misc. data with data from the last template submission for this matterkey
		by querying from cmft_matterkey_pairs for specific matterkey.
		***--->

		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(appellant_rep_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset appellant_rep_city = ListFirst(appellant_rep_citystzip) >
				<cfset appellant_rep_state = Left(Trim(ListGetAt(appellant_rep_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",appellant_rep_citystzip)>
				<cfif zipindex gte 1>
					<cfset appellant_rep_zip = Mid(appellant_rep_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset appellant_rep_zip = 0>
				</cfif>	
			<cfelse>
				<cfset appellant_rep_city = "">
				<cfset appellant_rep_state = "">
				<cfset appellant_rep_zip = "">			
			</cfif>
		<cfelse>
			<cfset appellant_rep_addr= "">
			<cfset appellant_rep_city = "">
			<cfset appellant_rep_state = "">
			<cfset appellant_rep_zip = "">
		</cfif>

	</cfif>


	<!--- Query Appellent Rep.'s phone --->
	<cfquery name="qry_appellant_rep_phone" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as appellant_rep_phone
	  from entity a, phone b
	  where a.entity_key=#qry_appellant_rep.entity_key# and a.entity_key=b.entity_key 
	  and (b.phone_type_key=2 or b.phone_type_key=3 or b.phone_type_key=4 or phone_type_key=6)
	</cfquery>
	<cfif qry_appellant_rep_phone.RecordCount gt 0>
		<cfset appellant_rep_phone = qry_appellant_rep_phone.appellant_rep_phone>
	<cfelse>
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset appellant_rep_phone = "">
		</cfif>		
	</cfif>



	<!--- Query Appellant Rep's fax --->
	<cfquery name="qry_appellant_rep_fax" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as appellant_rep_fax
	  from entity a, phone b
	  where a.entity_key=#qry_appellant_rep.entity_key# and a.entity_key=b.entity_key 
	  and b.phone_type_key=5 
	</cfquery>
	<cfif qry_appellant_rep_fax.RecordCount gt 0>
		<cfset appellant_rep_fax = qry_appellant_rep_fax.appellant_rep_fax>
	<cfelse><!---when Appellant Rep. is in LM but no Appellant Rep. fax data is there from previous submssion	--->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset appellant_rep_fax = "">
		</cfif>	
	</cfif>

	
<cfelse>

	<cfif qry_last_submitted_data.RecordCount gt 0>	<!---if there are submitted data from a previous submission --->
		<cfinclude template = "parse_appellant_rep_citystzip.cfm">
		<cfset appellant_rep_phone = "">
	<cfelse>
		<cfset appellant_rep_fname = "">
		<cfset appellant_rep_lname = "">
		<cfset appellant_rep_company = "">
		<cfset appellant_rep_addr = "">
		<cfset appellant_rep_city = "">
		<cfset appellant_rep_state = "">
		<cfset appellant_rep_zip = "">	
		<cfset appellant_rep_phone = "">
		<cfset appellant_rep_fax = "">
	</cfif>



</cfif>	
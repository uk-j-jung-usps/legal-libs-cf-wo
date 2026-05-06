

<!---******************** Administrative Judge's Information Queries ********************--->

<!--- Query AJ's name --->
<cfquery name="qry_aj" datasource="lawmanager">
  select b.entity_key, trim(initcap(b.first_name)) as first_name, trim(initcap(b.last_name)) as last_name
  from matter a, entity b, matterentity c
  where a.matter_key=#url.matterkey# and a.matter_key=c.matter_key and b.entity_key=c.entity_key and 
  (c.matter_entity_type_key=15 or c.matter_entity_type_key=52 or c.matter_entity_type_key=50 
  or c.matter_entity_type_key=49 or c.matter_entity_type_key=48 or c.matter_entity_type_key=51)
  order by c.start_date desc
</cfquery>

	<!---<cfoutput>#qry_aj.recordCount#</cfoutput>--->
	
<cfif qry_aj.RecordCount gt 0>   <!--- if AJ's data available from LM --->
	<cfset aj_fname = qry_aj.first_name>
	<cfset aj_lname = qry_aj.last_name>

	<!--- Query AJ's address --->
	<cfquery name="qry_aj_addr" datasource="lawmanager">
	  select a.entity_key, trim(initcap(b.street))as street, trim(initcap(b.city)) as city, b.state, trim(b.zip_code) as zip_code
	  from entity a, address b
	  where a.entity_key=#qry_aj.entity_key# and a.entity_key=b.entity_key
	</cfquery>	
	

	<cfif qry_aj_addr.RecordCount gt 0>
		<cfset aj_addr= qry_aj_addr.street>
		<cfset aj_city= qry_aj_addr.city>
		<cfset aj_state= qry_aj_addr.state>
		<cfset aj_zip= qry_aj_addr.zip_code>
		
	<cfelse> <!---if no data from LM--->
	
		<!---comment***
		if no data has been entered in Lawmanager for judge's address, fax, etc. repopulate 
		the judge's misc. data with data from the last template submission for this matterkey
		by querying from cmft.matterkey.pairs table for a specific matterkey.
		***--->

		<cfinclude template = "parse_aj_citystzip.cfm">

		
  </cfif>

		<!---<cfoutput>#aj_addr#</cfoutput>--->


	<!--- Query AJ's phone --->
	<cfquery name="qry_aj_phone" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as aj_phone
	  from entity a, phone b
	  where a.entity_key=#qry_aj.entity_key# and a.entity_key=b.entity_key 
	  and (b.phone_type_key=2 or b.phone_type_key=3 or b.phone_type_key=4 or phone_type_key=6)
	</cfquery>
	<cfif qry_aj_phone.RecordCount gt 0>
		<cfset aj_phone= qry_aj_phone.aj_phone>
	<cfelse>
		<cfset aj_phone = "">
  </cfif>


	<!--- Query AJ's fax --->
	<cfquery name="qry_aj_fax" datasource="lawmanager">
	  select a.entity_key, trim(b.phone_number)as aj_fax
	  from entity a, phone b
	  where a.entity_key=#qry_aj.entity_key# and a.entity_key=b.entity_key 
	  and b.phone_type_key=5 
	</cfquery>
	
	<cfif qry_aj_fax.RecordCount gt 0> <!---if fax is available form LM --->
		<cfset aj_fax= qry_aj_fax.aj_fax>
	<cfelse>  <!---initializing when AJ's name is in LM but no AJ's fax number data is there from previous submssion  --->
		<cfif not qry_last_submitted_data.RecordCount gt 0>
			<cfset aj_fax="">
		</cfif>
	</cfif>

<cfelse>  <!--- Grab AJ's screen data from submitted.data.cfm script if it is not present in LawManager --->
	<cfif qry_last_submitted_data.RecordCount gt 0>	<!---if there are submitted data from a previous submission --->
		<cfinclude template = "parse_aj_citystzip.cfm">
		<cfset aj_phone = "">
	<cfelse>

		<cfset aj_fname = "">
		<cfset aj_lname = "">
		<cfset aj_addr= "">
		<cfset aj_city = "">
		<cfset aj_state = "">
		<cfset aj_zip = "">	
		<cfset aj_fax = "">
		<cfset aj_phone = "">
	</cfif>	
	
	
</cfif>





<!---
<cfloop index = "LoopCount" from = "1" to = "51">

<cfoutput>#qry_last_submitted_data.tempvar_value#  </cfoutput>
The loop index is <cfoutput>#LoopCount#</cfoutput>.

</cfloop>


--->
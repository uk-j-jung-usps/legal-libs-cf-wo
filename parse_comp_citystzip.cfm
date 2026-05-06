	<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(comp_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset comp_city = ListFirst(comp_citystzip) >
				<cfset comp_state = Left(Trim(ListGetAt(comp_citystzip,2)),2)>
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


<!--- 6/1/2022 -Commented out.  Throws and error --->
	
<!---
		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif isdefined('comp_citystzip') AND len(comp_citystzip) gte 2> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset comp_city = ListFirst(comp_citystzip) >
				<cfif Left(Trim(ListGetAt(comp_citystzip,2)),2)>
					<cfset comp_state = Left(Trim(ListGetAt(comp_citystzip,2)),2)>
                </cfif>
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

--->



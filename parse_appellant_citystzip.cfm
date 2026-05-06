
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
		</cfif>
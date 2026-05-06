

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
		</cfif>




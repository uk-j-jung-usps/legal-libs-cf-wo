

		<cfif qry_last_submitted_data.RecordCount gt 0> 
			<cfif len(ajs_citystzip)> <!---here we're parsing and breaking up the citystzip and initializeing each--->
				<cfset aj_city = ListFirst(ajs_citystzip) >
				<cfset aj_state = Left(Trim(ListGetAt(ajs_citystzip,2)),2)>
				<cfset zipindex = REFIND("[0-9]{5}",ajs_citystzip)>
				<cfif zipindex gte 1>
					<cfset aj_zip = Mid(ajs_citystzip, zipindex, (zipindex+4))>
				<cfelse>
					<cfset aj_zip = 0>
				</cfif>	
			<cfelse>
				<cfset aj_city = "">
				<cfset aj_state = "">
				<cfset aj_zip = "">			
			</cfif>
		<cfelse>
			<cfset aj_addr= "">
			<cfset aj_city = "">
			<cfset aj_state = "">
			<cfset aj_zip = "">
		</cfif>

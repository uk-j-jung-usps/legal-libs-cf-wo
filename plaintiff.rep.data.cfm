<!--- Plaintiff Rep's Information Queries and variable settings --->

<!--- Query Plaintiff Rep's name --->
<cfquery name="qry_plaintiff_rep" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name
	FROM lawmanager.matter a
	INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
	INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 37
</cfquery>

<cfscript>
	// Helper: Parse a "City, ST Zip" string into individual components
	function parseRepCityStZip(citystzip) {
		var result = { city: "", state: "", zip: "" };
		if (len(trim(arguments.citystzip))) {
			result.city = listFirst(arguments.citystzip);
			if (listLen(arguments.citystzip) GTE 2) {
				result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
			}
			var zipindex = reFind("[0-9]{5}", arguments.citystzip);
			if (zipindex GTE 1) {
				result.zip = mid(arguments.citystzip, zipindex, 5);
			}
		}
		return result;
	}

	hasSubmittedData = (qry_last_submitted_data.recordCount GT 0);
</cfscript>

<cfif qry_plaintiff_rep.recordCount GT 0>

	<cfscript>
		plaintiff_rep_fname = qry_plaintiff_rep.first_name;
		plaintiff_rep_lname = qry_plaintiff_rep.last_name;
	</cfscript>

	<!--- Query Plaintiff Rep's company --->
	<cfquery name="qry_plaintiff_rep_company" datasource="lawmanager">
		SELECT name
		FROM lawmanager.entity
		WHERE entity_key = <cfqueryparam value="#qry_plaintiff_rep.entity_key#" cfsqltype="cf_sql_integer">
		  AND entity_type_key = 37
		  AND person_company_flag = 'C'
	</cfquery>

	<cfscript>
		if (qry_plaintiff_rep_company.recordCount GT 0) {
			plaintiff_rep_company = qry_plaintiff_rep_company.name;
		} else if (!hasSubmittedData) {
			plaintiff_rep_company = "";
		}
	</cfscript>

	<!--- Query Plaintiff Rep's address --->
	<cfquery name="qry_plaintiff_rep_addr" datasource="lawmanager">
		SELECT a.entity_key,
			   trim(b.street) AS street,
			   trim(b.city) AS city,
			   b.state,
			   trim(b.zip_code) AS zip_code,
			   c.eaddress AS email
		FROM lawmanager.entity a
		LEFT JOIN lawmanager.address b ON a.entity_key = b.entity_key
		LEFT JOIN lawmanager.eaddress c ON a.entity_key = c.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_plaintiff_rep.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfscript>
		if (qry_plaintiff_rep_addr.recordCount GT 0) {
			// Street
			if (len(qry_plaintiff_rep_addr.street)) {
				plaintiff_rep_addr = qry_plaintiff_rep_addr.street;
			} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
				parsed = parseRepCityStZip(plaintiff_rep_citystzip);
			} else {
				plaintiff_rep_addr = "";
			}

			// City
			if (len(qry_plaintiff_rep_addr.city)) {
				plaintiff_rep_city = qry_plaintiff_rep_addr.city;
			} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
				parsed = parseRepCityStZip(plaintiff_rep_citystzip);
				plaintiff_rep_city = parsed.city;
			} else {
				plaintiff_rep_city = "";
			}

			// State
			if (len(qry_plaintiff_rep_addr.state)) {
				plaintiff_rep_state = qry_plaintiff_rep_addr.state;
			} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
				parsed = parseRepCityStZip(plaintiff_rep_citystzip);
				plaintiff_rep_state = parsed.state;
			} else {
				plaintiff_rep_state = "";
			}

			// Zip
			if (len(qry_plaintiff_rep_addr.zip_code)) {
				plaintiff_rep_zip = qry_plaintiff_rep_addr.zip_code;
			} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
				parsed = parseRepCityStZip(plaintiff_rep_citystzip);
				plaintiff_rep_zip = parsed.zip;
			} else {
				plaintiff_rep_zip = "";
			}

			// Email
			plaintiff_rep_email = len(qry_plaintiff_rep_addr.email) ? qry_plaintiff_rep_addr.email : "";

		} else {
			// No address data in LM — parse from submitted citystzip or initialize empty
			if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
				parsed = parseRepCityStZip(plaintiff_rep_citystzip);
				plaintiff_rep_city  = parsed.city;
				plaintiff_rep_state = parsed.state;
				plaintiff_rep_zip   = parsed.zip;
			} else {
				plaintiff_rep_addr  = "";
				plaintiff_rep_city  = "";
				plaintiff_rep_state = "";
				plaintiff_rep_zip   = "";
				plaintiff_rep_email = "";
			}
		}
	</cfscript>

	<!--- Query Plaintiff Rep's phone --->
	<cfquery name="qry_plaintiff_rep_phone" datasource="lawmanager">
		SELECT a.entity_key, trim(b.phone_number) AS plaintiff_rep_phone
		FROM lawmanager.entity a
		INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_plaintiff_rep.entity_key#" cfsqltype="cf_sql_integer">
		  AND b.phone_type_key IN (2, 3, 4, 6)
	</cfquery>

	<cfscript>
		if (qry_plaintiff_rep_phone.recordCount GT 0) {
			plaintiff_rep_phone = qry_plaintiff_rep_phone.plaintiff_rep_phone;
		} else if (!hasSubmittedData) {
			plaintiff_rep_phone = "";
		}
	</cfscript>

	<!--- Query Plaintiff Rep's fax --->
	<cfquery name="qry_plaintiff_rep_fax" datasource="lawmanager">
		SELECT a.entity_key, trim(b.phone_number) AS plaintiff_rep_fax
		FROM lawmanager.entity a
		INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_plaintiff_rep.entity_key#" cfsqltype="cf_sql_integer">
		  AND b.phone_type_key = 5
	</cfquery>

	<cfscript>
		if (qry_plaintiff_rep_fax.recordCount GT 0) {
			plaintiff_rep_fax = qry_plaintiff_rep_fax.plaintiff_rep_fax;
		} else if (!hasSubmittedData) {
			plaintiff_rep_fax = "";
		}
	</cfscript>

<cfelse>
	<!--- No Plaintiff Rep in LawManager --->
	<cfscript>
		if (hasSubmittedData && structKeyExists(variables, "plaintiff_rep_citystzip")) {
			parsed = parseRepCityStZip(plaintiff_rep_citystzip);
			plaintiff_rep_city  = parsed.city;
			plaintiff_rep_state = parsed.state;
			plaintiff_rep_zip   = parsed.zip;
		} else {
			plaintiff_rep_fname   = "";
			plaintiff_rep_lname   = "";
			plaintiff_rep_company = "";
			plaintiff_rep_addr    = "";
			plaintiff_rep_city    = "";
			plaintiff_rep_state   = "";
			plaintiff_rep_zip     = "";
			plaintiff_rep_phone   = "";
			plaintiff_rep_fax     = "";
			plaintiff_rep_email   = "";
		}
	</cfscript>
</cfif>

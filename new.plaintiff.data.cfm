<!--- Plaintiff's Information Queries and variable settings --->

<!--- Query Plaintiff's name, eid, facility and district --->
<cfquery name="qry_plaintiff" datasource="lawmanager">
	SELECT b.entity_key,
		   trim(initcap(b.first_name)) AS first_name,
		   trim(initcap(b.last_name)) AS last_name,
		   b.usps_eid AS plaintiff_eid,
		   trim(d.finance_name) AS plaintiff_facility,
		   trim(e.lvl2_desc) || ', ' || trim(e.lvl3_desc) AS plaintiff_district
	FROM lawmanager.matter a
	INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
	INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
	INNER JOIN lawmanager.fncm d ON a.usps_fac_id = d.lm_facility_key
	INNER JOIN lawmanager.matterclientorgsusps e ON a.usps_client_orgs_key = e.usps_client_orgs_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 33
</cfquery>

<cfscript>
	// Helper: Parse a "City, ST Zip" string into individual components
	function parseCityStZip(citystzip) {
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

	if (qry_plaintiff.recordCount GT 0) {

		// EID
		plaintiff_eid = len(qry_plaintiff.plaintiff_eid) ? qry_plaintiff.plaintiff_eid : (hasSubmittedData && structKeyExists(variables, "plaintiff_eid") ? plaintiff_eid : "");

		// Name, facility, district from LM
		plaintiff_fname    = qry_plaintiff.first_name;
		plaintiff_lname    = qry_plaintiff.last_name;
		plaintiff_facility = qry_plaintiff.plaintiff_facility;
		plaintiff_district = qry_plaintiff.plaintiff_district;

	} else {
		// No plaintiff in LawManager — use submitted data or initialize empty
		if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
			parsed = parseCityStZip(plaintiff_citystzip);
			plaintiff_city  = parsed.city;
			plaintiff_state = parsed.state;
			plaintiff_zip   = parsed.zip;
		} else {
			plaintiff_eid      = "";
			plaintiff_ssn      = "";
			plaintiff_fname    = "";
			plaintiff_lname    = "";
			plaintiff_facility = "";
			plaintiff_district = "";
			plaintiff_addr     = "";
			plaintiff_city     = "";
			plaintiff_state    = "";
			plaintiff_zip      = "";
			plaintiff_phone    = "";
			plaintiff_email    = "";
		}
	}
</cfscript>

<!--- Query Plaintiff's address (only if plaintiff found in LM) --->
<cfif qry_plaintiff.recordCount GT 0>
	<cfquery name="qry_plaintiff_addr" datasource="lawmanager">
		SELECT a.entity_key,
			   trim(b.street) AS street,
			   trim(b.city) AS city,
			   b.state,
			   trim(b.zip_code) AS zip_code,
			   c.eaddress AS email
		FROM lawmanager.entity a
		LEFT JOIN lawmanager.address b ON a.entity_key = b.entity_key
		LEFT JOIN lawmanager.eaddress c ON a.entity_key = c.entity_key
		WHERE a.entity_key = <cfqueryparam value="#qry_plaintiff.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfscript>
		if (qry_plaintiff_addr.recordCount GT 0) {
			// Street
			plaintiff_addr = len(qry_plaintiff_addr.street) ? qry_plaintiff_addr.street : (!hasSubmittedData ? "" : (structKeyExists(variables, "plaintiff_addr") ? plaintiff_addr : ""));

			// City / State / Zip — from LM address, or parse from submitted citystzip
			if (len(qry_plaintiff_addr.city)) {
				plaintiff_city = qry_plaintiff_addr.city;
			} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
				parsed = parseCityStZip(plaintiff_citystzip);
				plaintiff_city = parsed.city;
			} else {
				plaintiff_city = "";
			}

			if (len(qry_plaintiff_addr.state)) {
				plaintiff_state = qry_plaintiff_addr.state;
			} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
				parsed = parseCityStZip(plaintiff_citystzip);
				plaintiff_state = parsed.state;
			} else {
				plaintiff_state = "";
			}

			if (len(qry_plaintiff_addr.zip_code)) {
				plaintiff_zip = qry_plaintiff_addr.zip_code;
			} else if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
				parsed = parseCityStZip(plaintiff_citystzip);
				plaintiff_zip = parsed.zip;
			} else {
				plaintiff_zip = "";
			}

			// Email
			plaintiff_email = len(qry_plaintiff_addr.email) ? qry_plaintiff_addr.email : (!hasSubmittedData ? "" : (structKeyExists(variables, "plaintiff_email") ? plaintiff_email : ""));

		} else {
			// No address data in LM — parse from submitted citystzip or initialize empty
			if (hasSubmittedData && structKeyExists(variables, "plaintiff_citystzip")) {
				parsed = parseCityStZip(plaintiff_citystzip);
				plaintiff_city  = parsed.city;
				plaintiff_state = parsed.state;
				plaintiff_zip   = parsed.zip;
			} else {
				plaintiff_addr  = "";
				plaintiff_city  = "";
				plaintiff_state = "";
				plaintiff_zip   = "";
				plaintiff_email = "";
			}
		}
	</cfscript>
</cfif>

<!--- Query Plaintiff's SSN --->
<cfif qry_plaintiff.recordCount GT 0>
	<cfquery name="qry_ssn" datasource="lawmanager">
		SELECT ssn AS plaintiff_ssn
		FROM lawmanager.hr.emp_xref
		WHERE entity_key = <cfqueryparam value="#qry_plaintiff.entity_key#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfscript>
		if (qry_ssn.recordCount GT 0 && len(qry_ssn.plaintiff_ssn)) {
			plaintiff_ssn = qry_ssn.plaintiff_ssn;
		} else if (!hasSubmittedData) {
			plaintiff_ssn = "";
		}
	</cfscript>
<cfelse>
	<cfset plaintiff_ssn = "">
</cfif>

<!--- Query case docket number --->
<cfquery name="qry_docket_no" datasource="lawmanager">
	SELECT forum_number
	FROM lawmanager.forum
	WHERE matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND venue_type_key IN (10, 11, 12, 13)
	  AND forum_type_key = 3
</cfquery>

<cfscript>
	if (qry_docket_no.recordCount GT 0) {
		case_no = qry_docket_no.forum_number;
	} else if (!hasSubmittedData) {
		case_no = "";
	}
</cfscript>

<!--- Query Defendant's name --->
<cfquery name="qry_defendant" datasource="lawmanager">
	SELECT b.entity_key, trim(b.name) AS defendant
	FROM lawmanager.matter a
	INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
	INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
	WHERE a.matter_key = <cfqueryparam value="#url.matterkey#" cfsqltype="cf_sql_integer">
	  AND c.matter_entity_type_key = 36
</cfquery>

<cfscript>
	if (qry_defendant.recordCount GT 0 && len(qry_defendant.defendant)) {
		defendant_name = qry_defendant.defendant;
	} else if (!hasSubmittedData) {
		defendant_name = "";
	}
</cfscript>

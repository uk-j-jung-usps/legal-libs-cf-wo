component displayname="Complainant Data Component" hint="Data access functions for complainant-related queries." {

	/**
	 * Parse "City, ST Zip" into a struct with city, state, zip keys.
	 * @citystzip Combined city/state/zip string (e.g., "Washington, DC 20001").
	 * @return Struct with keys: city, state, zip.
	 */
	public struct function parseCityStateZip(required string citystzip) {
		var result = { city: "", state: "", zip: "" };
		if (len(trim(arguments.citystzip))) {
			result.city = listFirst(arguments.citystzip);
			if (listLen(arguments.citystzip) >= 2) {
				result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
			}
			var zipIndex = reFind("[0-9]{5}", arguments.citystzip);
			if (zipIndex >= 1) {
				result.zip = mid(arguments.citystzip, zipIndex, 5);
			}
		}
		return result;
	}

	/**
	 * Retrieves the Complainant's name, EID, facility, and district for a given matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name, comp_eid, comp_facility, comp_district.
	 */
	public query function getComplainant(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name,
					b.usps_eid AS comp_eid,
					trim(d.finance_name) AS comp_facility,
					trim(e.lvl2_desc) || ', ' || trim(e.lvl3_desc) AS comp_district
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 INNER JOIN lawmanager.fncm d ON a.usps_fac_id = d.lm_facility_key
			 INNER JOIN lawmanager.matterclientorgsusps e ON a.usps_client_orgs_key = e.usps_client_orgs_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 39",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the Complainant's address by entity_key.
	 * @entityKey The entity_key to look up.
	 * @return Query with entity_key, street, city, state, zip_code.
	 */
	public query function getComplainantAddress(required numeric entityKey) {
		return queryExecute(
			"SELECT a.entity_key,
					trim(b.street) AS street,
					trim(b.city) AS city,
					b.state,
					trim(b.zip_code) AS zip_code
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.address b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the Complainant's phone number by entity_key.
	 * @entityKey The entity_key to look up.
	 * @return Query with phone_number.
	 */
	public query function getComplainantPhone(required numeric entityKey) {
		return queryExecute(
			"SELECT a.entity_key, trim(b.phone_number) AS phone_number
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the Complainant's SSN from the HR cross-reference table.
	 * @entityKey The entity_key to look up.
	 * @return Query with comp_ssn.
	 */
	public query function getComplainantSSN(required numeric entityKey) {
		return queryExecute(
			"SELECT ssn AS comp_ssn
			 FROM hr.emp_xref
			 WHERE entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the agency number for a given matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with forum_number.
	 */
	public query function getAgencyNumber(required numeric matterKey) {
		return queryExecute(
			"SELECT forum_number
			 FROM lawmanager.forum
			 WHERE matter_key = :matterKey
			   AND venue_type_key = 1101
			   AND forum_type_key = 1",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the EEOC number for a given matter (latest if multiple).
	 * @matterKey The matter_key to look up.
	 * @return Query with forum_number.
	 */
	public query function getEeocNumber(required numeric matterKey) {
		return queryExecute(
			"SELECT forum_number
			 FROM lawmanager.forum
			 WHERE matter_key = :matterKey
			   AND venue_type_key LIKE '8%'
			 ORDER BY forum_number DESC",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

}

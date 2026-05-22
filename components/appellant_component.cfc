component displayname="Appellant Component" hint="Data access functions for appellant-related queries." {

	/**
	 * Parse "City, ST Zip" into a struct with city, state, zip keys.
	 * @citystzip Combined city/state/zip string (e.g., "Washington, DC 20001").
	 * @return Struct with keys: city, state, zip.
	 */
	public struct function parseCityStZip(required string citystzip) {
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
	 * Retrieves the Appellant's name, EID, facility, and district for a given matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name, appellant_eid, appellant_facility, appellant_district.
	 */
	public query function getAppellant(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name,
					b.usps_eid AS appellant_eid,
					trim(d.finance_name) AS appellant_facility,
					trim(e.lvl2_desc) || ', ' || trim(e.lvl3_desc) AS appellant_district
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 INNER JOIN lawmanager.fncm d ON a.usps_fac_id = d.lm_facility_key
			 INNER JOIN lawmanager.matterclientorgsusps e ON a.usps_client_orgs_key = e.usps_client_orgs_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 38",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the Appellant's address and email by entity_key.
	 * @entityKey The entity_key to look up.
	 * @return Query with entity_key, street, city, state, zip_code, email.
	 */
	public query function getAppellantAddress(required numeric entityKey) {
		return queryExecute(
			"SELECT a.entity_key,
					trim(b.street) AS street,
					trim(b.city) AS city,
					b.state,
					trim(b.zip_code) AS zip_code,
					c.eaddress AS email
			 FROM lawmanager.entity a
			 LEFT JOIN lawmanager.address b ON a.entity_key = b.entity_key
			 LEFT JOIN lawmanager.eaddress c ON a.entity_key = c.entity_key
			 WHERE a.entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the Appellant's phone number by entity_key.
	 * @entityKey The entity_key to look up.
	 * @return Query with phone_number.
	 */
	public query function getAppellantPhone(required numeric entityKey) {
		return queryExecute(
			"SELECT trim(b.phone_number) AS phone_number
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the Appellant's SSN from the HR cross-reference table.
	 * @entityKey The entity_key to look up.
	 * @return Query with appellant_ssn.
	 */
	public query function getAppellantSSN(required numeric entityKey) {
		return queryExecute(
			"SELECT ssn AS appellant_ssn
			 FROM hr.emp_xref
			 WHERE entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the Docket Number for a given matter (MSPB venue).
	 * @matterKey The matter_key to look up.
	 * @return Query with forum_number.
	 */
	public query function getDocketNumber(required numeric matterKey) {
		return queryExecute(
			"SELECT forum_number
			 FROM lawmanager.forum
			 WHERE matter_key = :matterKey
			   AND venue_type_key = 700
			   AND forum_type_key = 4",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

}


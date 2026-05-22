component displayname="Complainant Rep Data Component" hint="Data access functions for complainant representative queries." {

	/**
	 * Parse "City, ST Zip" into a struct with city, state, zip keys.
	 * @citystzip Combined city/state/zip string (e.g., "Washington, DC 20001").
	 * @return Struct with keys: city, state, zip.
	 */
	public struct function parseCityStateZip(required string citystzip) {
		var result = { city: "", state: "", zip: "" };
		if (len(trim(arguments.citystzip)) && listLen(arguments.citystzip) > 1) {
			result.city = listFirst(arguments.citystzip);
			result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
			var zipIndex = reFind("[0-9]{5}", arguments.citystzip);
			if (zipIndex >= 1) {
				result.zip = mid(arguments.citystzip, zipIndex, 5);
			}
		}
		return result;
	}

	/**
	 * Retrieves the Complainant Representative's name for a given matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name.
	 */
	public query function getComplainantRep(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 21
			 ORDER BY c.start_date DESC",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the company name for a complainant rep entity.
	 * @entityKey The entity_key to look up.
	 * @return Query with name.
	 */
	public query function getComplainantRepCompany(required numeric entityKey) {
		return queryExecute(
			"SELECT name
			 FROM lawmanager.entity
			 WHERE entity_key = :entityKey
			   AND entity_type_key = 21
			   AND person_company_flag = 'C'",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the address for a complainant rep entity.
	 * @entityKey The entity_key to look up.
	 * @return Query with entity_key, street, city, state, zip_code.
	 */
	public query function getComplainantRepAddress(required numeric entityKey) {
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
	 * Retrieves phone number for a complainant rep entity.
	 * @entityKey The entity_key to look up.
	 * @return Query with phone_number.
	 */
	public query function getComplainantRepPhone(required numeric entityKey) {
		return queryExecute(
			"SELECT a.entity_key, trim(b.phone_number) AS phone_number
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey
			   AND b.phone_type_key IN (2, 3, 4, 6)",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves fax number for a complainant rep entity (phone_type_key = 5).
	 * @entityKey The entity_key to look up.
	 * @return Query with fax_number.
	 */
	public query function getComplainantRepFax(required numeric entityKey) {
		return queryExecute(
			"SELECT a.entity_key, trim(b.phone_number) AS fax_number
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey
			   AND b.phone_type_key = 5",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

}

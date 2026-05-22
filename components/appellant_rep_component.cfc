component displayname="Appellant Rep Component" hint="Data access functions for appellant representative queries." {

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
	 * Retrieves the Appellant Representative's name for a given matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name.
	 */
	public query function getAppellantRep(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 12",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the company name for an appellant rep entity (person_company_flag = 'C').
	 * @entityKey The entity_key to look up.
	 * @return Query with name.
	 */
	public query function getAppellantRepCompany(required numeric entityKey) {
		return queryExecute(
			"SELECT name
			 FROM lawmanager.entity
			 WHERE entity_key = :entityKey
			   AND entity_type_key = 12
			   AND person_company_flag = 'C'",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the address for an appellant rep entity.
	 * @entityKey The entity_key to look up.
	 * @return Query with street, city, state, zip_code.
	 */
	public query function getAppellantRepAddress(required numeric entityKey) {
		return queryExecute(
			"SELECT trim(b.street) AS street,
					trim(b.city) AS city,
					b.state,
					trim(b.zip_code) AS zip_code
			 FROM lawmanager.entity a
			 LEFT JOIN lawmanager.address b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves phone number for an appellant rep entity.
	 * @entityKey The entity_key to look up.
	 * @return Query with phone_number.
	 */
	public query function getAppellantRepPhone(required numeric entityKey) {
		return queryExecute(
			"SELECT trim(b.phone_number) AS phone_number
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey
			   AND b.phone_type_key IN (2, 3, 4, 6)",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves fax number for an appellant rep entity (phone_type_key = 5).
	 * @entityKey The entity_key to look up.
	 * @return Query with fax_number.
	 */
	public query function getAppellantRepFax(required numeric entityKey) {
		return queryExecute(
			"SELECT trim(b.phone_number) AS fax_number
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey
			   AND b.phone_type_key = 5",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

}

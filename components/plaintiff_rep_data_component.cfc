component displayname="Plaintiff Rep Data Component" hint="Data access for plaintiff representative information." {

	/**
	 * Parses a "City, ST Zip" combined string into individual components.
	 * @citystzip The combined city/state/zip string.
	 * @return Struct with keys: city, state, zip.
	 */
	public struct function parseCityStZip(required string citystzip) {
		var result = { city: "", state: "", zip: "" };
		if (len(trim(arguments.citystzip))) {
			result.city = listFirst(arguments.citystzip);
			if (listLen(arguments.citystzip) >= 2) {
				result.state = left(trim(listGetAt(arguments.citystzip, 2)), 2);
			}
			var zipindex = reFind("[0-9]{5}", arguments.citystzip);
			if (zipindex >= 1) {
				result.zip = mid(arguments.citystzip, zipindex, 5);
			}
		}
		return result;
	}

	/**
	 * Retrieves plaintiff representative entity by matter key (matter_entity_type_key = 37).
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name.
	 */
	public query function getPlaintiffRep(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 37",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves plaintiff representative company name by entity key.
	 * @entityKey The entity_key to look up.
	 * @return Query with name column.
	 */
	public query function getPlaintiffRepCompany(required numeric entityKey) {
		return queryExecute(
			"SELECT name
			 FROM lawmanager.entity
			 WHERE entity_key = :entityKey
			   AND entity_type_key = 37
			   AND person_company_flag = 'C'",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves plaintiff representative address and email by entity key.
	 * @entityKey The entity_key to look up.
	 * @return Query with entity_key, street, city, state, zip_code, email.
	 */
	public query function getPlaintiffRepAddress(required numeric entityKey) {
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
	 * Retrieves plaintiff representative phone by entity key.
	 * @entityKey The entity_key to look up.
	 * @return Query with phone_number column.
	 */
	public query function getPlaintiffRepPhone(required numeric entityKey) {
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
	 * Retrieves plaintiff representative fax by entity key.
	 * @entityKey The entity_key to look up.
	 * @return Query with fax_number column.
	 */
	public query function getPlaintiffRepFax(required numeric entityKey) {
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

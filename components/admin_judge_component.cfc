component displayname="Admin Judge Component" hint="Data access functions for administrative judge queries." {

	/**
	 * Retrieves the Administrative Judge's name for a given matter.
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name.
	 */
	public query function getAdminJudge(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key IN (15, 48, 49, 50, 51, 52)
			 ORDER BY c.start_date DESC",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves the address for a given entity.
	 * @entityKey The entity_key to look up.
	 * @return Query with entity_key, street, city, state, zip_code.
	 */
	public query function getEntityAddress(required numeric entityKey) {
		return queryExecute(
			"SELECT a.entity_key,
					trim(initcap(b.street)) AS street,
					trim(initcap(b.city)) AS city,
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
	 * Retrieves phone number(s) for a given entity.
	 * @entityKey The entity_key to look up.
	 * @phoneTypeKeys Comma-delimited list of phone_type_key values to filter by.
	 * @return Query with entity_key, phone_number.
	 */
	public query function getEntityPhone(required numeric entityKey, string phoneTypeKeys = "2,3,4,6") {
		return queryExecute(
			"SELECT a.entity_key, trim(b.phone_number) AS phone_number
			 FROM lawmanager.entity a
			 INNER JOIN lawmanager.phone b ON a.entity_key = b.entity_key
			 WHERE a.entity_key = :entityKey
			   AND b.phone_type_key IN (#arguments.phoneTypeKeys#)",
			{ entityKey = { value = arguments.entityKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

	/**
	 * Retrieves fax number for a given entity (phone_type_key = 5).
	 * @entityKey The entity_key to look up.
	 * @return Query with entity_key, fax_number.
	 */
	public query function getEntityFax(required numeric entityKey) {
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

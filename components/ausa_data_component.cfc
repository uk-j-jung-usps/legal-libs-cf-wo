component displayname="AUSA Data Component" hint="Data access for Assistant US Attorney information." {

	/**
	 * Retrieves AUSA (Assistant US Attorney) entity by matter key.
	 * @matterKey The matter_key to look up.
	 * @return Query with entity_key, first_name, last_name, title.
	 */
	public query function getAusa(required numeric matterKey) {
		return queryExecute(
			"SELECT b.entity_key,
					trim(initcap(b.first_name)) AS first_name,
					trim(initcap(b.last_name)) AS last_name,
					trim(initcap(b.title)) AS title
			 FROM lawmanager.matter a
			 INNER JOIN lawmanager.matterentity c ON a.matter_key = c.matter_key
			 INNER JOIN lawmanager.entity b ON b.entity_key = c.entity_key
			 WHERE a.matter_key = :matterKey
			   AND c.matter_entity_type_key = 11",
			{ matterKey = { value = arguments.matterKey, cfsqltype = "cf_sql_integer" } },
			{ datasource = "lawmanager" }
		);
	}

}

#### Query Evidences
1. Query 1 - ST_Area
The output was ```P-001, Residential, and area_sqm = 10000.``` This confirms that the geometry of the object survives as a database row. Additionally, area_sqm is calculated from the geometry rather than a copied method result.

2. Query 2 - JOIN
The result show ```B-001, floors = 2, parcel_id = P-001, and land_use = Residential.``` This confirms that the tables were joined using the keys (primary and foreign).

#### Explain in one sentence how this JOIN reconstructs the Building -> Parcel relationship from persistent keys.

Answer: The JOIN operation included in the query reconstructs the relationship of Building -> Parcel by matching the foreign key (FK) of parcel_id in the buildings table, with the corresponding primary key (PK) in the parcels_table, allowing the database to identify which parcel each building belongs to.

3. Query 3 - ST_Within
The results show ```B-001, parcel_id = P-001, and is_inside (bool) = true.``` This confirms that the FK records which parcel each building belongs to. On the other hand, the ST_Within method checks if the geometry agrees with that claim. In this case, it did.

4. Query 4 - ST_DWithin
The output is ```P-001, road_id = R-001, and within_15m = true.``` This confirms that there are no parcel_id stored in the roads table. It only came up when asked specifically.

#### Part A.2 - Database Preflight
This shows the results after executing the queries in pgAdmin 4.

**SELECT current_database();**
```gisdb```

**SELECT version();**
```PostgreSQL 15.19, compiled by Visual C++ build 1944, 64-bit```

**SELECT postgis_full_version();**
```POSTGIS="3.6.2 3.6.2" [EXTENSION] PGSQL="150" GEOS="3.14.1-CAPI-1.20.5" SFCGAL="SFCGAL 2.2.0, CGAL 6.0.1, BOOST 1.88.0" PROJ="8.2.1 NETWORK_ENABLED=OFF URL_ENDPOINT=https://cdn.proj.org USER_WRITABLE_DIRECTORY=C:\WINDOWS\ServiceProfiles\NetworkService\AppData\Local/proj DATABASE_PATH=C:\Program Files\PostgreSQL\15\share\contrib\postgis-3.6\proj\proj.db" (compiled against PROJ 8.2.1) LIBXML="2.12.5" LIBJSON="0.12" LIBPROTOBUF="1.2.1" WAGYU="0.5.0 (Internal)" TOPOLOGY```

#### Part B.3 Ask the Persistence Question
| Object-model Element | Should it persist? (Y/N) | Reason |
| -------------------- | ------------------ | ------ |
| Parcel.id, zone, geometry | Y | The parcel must retain an identity; it needs a unique identifier. It also should retain the zone and geometry as they are important characteristics of the parcel. |
| Parcel.area() | N | This is calculated from the stored geometry. The geometry is already stored. |
| Building.id, floors, geometry | Y | The building needs a unique identifier, which is why Building.id must be retained. Floors should remain as well since it represents a physical characteristic of the building that cannot be determined from geometry in two-dimensional form. Building.geometry must also remain since it provides the shape and location of the building itself. It enables the building to be represented spatially. |
| Building -> Parcel relationship | Y | The database must retain this, as this represents how the Building is connected to the Parcel, or which parcel a building belongs to. Similar to how Relational Databases work. |
| Road.id, road_class, geometry | Y | Roads need unique identifiers. The road_class represents the category of the road, and the geometry enables the road to be represented spatially. |
| SpatialRule.evaluation(parcel) | N | Like Parcel.area(), this one's a method that is executed. It evaluates whether a parcel satisfies a certain condition. It can be omitted since it represents an executable behavior than an object state. |

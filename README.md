# Programming Exercise 6
## Introductory Spatial Database Modeling

### Introduction to the Programming Exercise
This programming exercise focuses on converting a small Lecture 5 object model into a relational or PostGIS design. It also verifies if the identity, relationships, and geometry of that object persists.

The core idea is that object organize state and behavior in memory. A relational database stores persistent state as rows, columns, keys, and relationships. Methods do not automatically become columns.

### Materials/Requirements
1. PostgreSQL + PostGIS
2. pgAdmin or psql
3. draw.io
4. Git/GitHub

### Project Structure
The structure of the project is as follows:
```
gme205-lab6/
    diagrams/
        lab6_relational_model.png
    sql/
        01_schema.sql
        02_seed.sql
        03_queries.sql
    evidence/
        query_results.md
    README.md
    .gitignore
```

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
| Parcel.is_active | Y | This must persist, since it determines if a parcel is valid or eligible. This is not available or saved on any other object-model elements and cannot be calculated with geometry alone. |

#### Part F.2 README Reflections

**1. Name one attribute from your object model that became a database column. Why must it persist?**
The attribute that started as an object model, and later on became a database column, is the land_use attribute. Zoning or land_use is an important characteristic of the parcel. It contains information on the parcel's classification. By allowing it to persist, I'm still able to access the land_use or zoning information even after the program itself stops.

**2. Name one method or behavior that did not become a column. Why not?**
One method that did not become a database column is the area() method. This is because the area() method is a behavior that calculates the area of a parcel using its geometry. Since the geometry is already stored in the database, there is no need to store the method itself as a separate column. Instead, I can simply use the ST_Area() function whenever I need to calculate the parcel's area.

**3. How did the Building → Parcel object relationship become a relational relationship?**

The Building → Parcel relationship became a relational relationship by using a foreign key. In the buildings table, the parcel_id attribute serves as a foreign key that references the parcel_id primary key in the parcels table. By doing this, I'm able to identify which parcel a particular building belongs to, while also maintaining the relationship between the two tables.

**4. Why can Road proximity be discovered spatially instead of storing parcel_id in roads?**

Road proximity can be determined spatially because both the Road and Parcel objects have their own stored geometries. By using the ST_DWithin() function, I'm able to determine whether a particular road is within a specified distance of a parcel. Since a road can be near multiple parcels without necessarily belonging to them, there is no need to store parcel_id in the roads table.

**5. What is one advantage of explicitly storing geometry type and SRID in the schema?**

One advantage of explicitly storing the geometry type and SRID in the schema is that it ensures the spatial data follows the required format and coordinate reference system. The geometry type determines what kind of spatial object can be stored, such as Polygon or LineString, while the SRID identifies the coordinate reference system being used. By specifying both, I'm able to maintain consistency in the spatial data and prevent incompatible geometries from being stored in the database.
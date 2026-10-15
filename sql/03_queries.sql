-- SELECT parcel_id, land_use, ST_Area(geom) AS area_sqm 
-- FROM lab6.parcels;

SELECT b.building_id, 
       b.floors, 
       p.parcel_id, 
       p.land_use 
FROM lab6.buildings AS b 
JOIN lab6.parcels AS p 
  ON p.parcel_id = b.parcel_id; 

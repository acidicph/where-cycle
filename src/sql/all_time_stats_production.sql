DROP TABLE IF EXISTS all_time_stats_production;

CREATE TABLE all_time_stats_production AS
    SELECT
        z.zone_id,
        CONCAT(z.zone_name, ', ', z.borough) AS zone,
        COALESCE(SUM(t.endpoint_visits), 0) AS taxi_visits,
		COALESCE(SUM(c.endpoint_visits), 0) AS citibike_visits,
        COALESCE(MAX(c.stations), 0) AS citibike_stations,
		COALESCE(y.avg_rating, 0) AS yelp_avg_rating,
		COALESCE(y.sum_reviews, 0) AS yelp_sum_reviews,
        COALESCE(y.weighted_sum_reviews, 0) AS yelp_weighted_sum_reviews
    FROM
        taxi_zones AS z
        LEFT JOIN taxi_endpoint_visits AS t USING (zone_id)
        LEFT JOIN citibike_stats AS c USING (zone_id)
        LEFT JOIN yelp_stats AS y USING (zone_id)
    GROUP BY 1, 2, 6, 7, 8
    ORDER BY 1;
flights_new <- flights %>%
  select("sched_dep_time", "dest_lon", "dest_tz", "wind_speed", "wind_gust","carrier", "tailnum", "dest","time_hour","dest_name","dest_tzone","plane_model","carrier_name","date","dow","arr_delay" )

flights_sub <- flights %>%
  select("sched_dep_time", "dest_lon", "wind_speed", "visib", "plane_seats", "carrier_name", "dow","arr_delay")

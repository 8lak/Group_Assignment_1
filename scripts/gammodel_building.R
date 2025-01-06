```{r}

gam_spec <- gen_additive_mod() %>%
  set_mode("regression") %>% 
  set_engine(engine = "mgcv") %>% 
  set_args(adjust_deg_free = tune(), select_features = TRUE)
  
variable_recipe <- recipe(arr_delay ~ sched_dep_time + dest_lon+ wind_speed + visib + plane_seats + carrier_name + dow, data = flights_sub) %>% 
step_normalize(all_numeric_predictors())
  
  
  baked_data <- prep(variable_recipe) %>% bake(new_data = NULL)
head(baked_data)
  
gam_workflow <- workflow() %>% 
  add_recipe(variable_recipe) %>% 
  add_model(gam_spec,
            formula = arr_delay ~ s(sched_dep_time) + s(dest_lon) + 
                      s(wind_speed) + s(visib) + s(plane_seats) + 
                      carrier_name + dow )
```

```{r}
set.seed(253)
gam_models <- gam_workflow %>% 
  tune_grid(
    grid = grid_regular(adjust_deg_free(range = c(7, 9)), 
                        levels = 10),
    resamples = vfold_cv(flights_sub, v = 10),
    metrics = metric_set(mae))
```

```{r}
gam_models %>%
  collect_metrics()
  
  best_penalty <- gam_models %>% 
  select_best(metric = "mae")
best_penalty  
  
  
final_gam <- gam_workflow %>% 
  finalize_workflow(parameters = best_penalty) %>% 
  fit(data = flights)

  
final_gam %>% 
  tidy()
```

```{r}
lasso_spec <- linear_reg() %>%             
  set_mode("regression") %>% 
  set_engine("glmnet") %>%                 
  set_args(mixture = 1, penalty = tune()) 
  
variable_recipe <- recipe(arr_delay ~ ., data = flights_sub ) %>% 
step_nzv(all_predictors())%>%
step_normalize(all_numeric_predictors())%>%
step_dummy(all_nominal_predictors())


lasso_workflow <- workflow() %>% 
  add_recipe(variable_recipe) %>% 
  add_model(lasso_spec)

```

```{r}
set.seed(139)
lasso_models <- lasso_workflow %>% 
  tune_grid(
    grid = grid_regular(penalty(range = c(-7, 5)), levels = 50),  
    resamples = vfold_cv(flights_sub, v = 10),   
    metrics = metric_set(mae)
  )
  
lasso_models %>% collect_metrics()

```


```{r}
autoplot(lasso_models) + 
  scale_x_log10() + 
  xlab(expression(lambda))
  
  best_penalty <- lasso_models %>% 
  select_best(metric = "mae")
best_penalty
```

```{r}
final_lasso <- lasso_workflow %>% 
  finalize_workflow(parameters = best_penalty) %>% 
  fit(data = flights)

  
final_lasso %>% 
  tidy()%>%
  filter(estimate != 0)

```

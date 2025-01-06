To evaluate the performance of our models, we calculated the Mean Absolute Error (MAE) on the test dataset. MAE measures the average magnitude of errors in the predictions, with lower values indicating better performance.

- **LASSO Regression Model**: The LASSO model achieved an MAE of **20.9**, indicating its ability to reduce overfitting by shrinking less important coefficients to zero.
- **Generalized Additive Model (GAM)**: The GAM achieved an MAE of **20.7**, slightly outperforming the LASSO model. The GAM's flexibility in capturing non-linear relationships contributed to its improved accuracy.

Both models provided reasonable predictions of arrival delays, with the GAM showing a marginal improvement in predictive performance.

### Strengths and Weaknesses
- **Strengths**:
  - The LASSO model effectively reduced complexity by selecting only the most important predictors.
  - The GAM captured non-linear effects between predictors and the outcome, leading to better predictions.
- **Weaknesses**:
  - Both models struggled with extreme delays, suggesting potential areas for feature engineering or alternative modeling approaches.


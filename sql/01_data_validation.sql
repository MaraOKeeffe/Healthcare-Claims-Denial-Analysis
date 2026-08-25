The dataset contained null values in the denial reason code field. Before using denial reason code in later analyses, I verified how null and non-null denial reason codes appeared within claims outcomes. The validation showed that null denial reason codes occurred only among paid, partially paid, and pending claims while all 33,664 claims with non-null denial reason codes had an outcome of denied. This confirmed that denial reason code presence could be used as a proxy for denial claims in this dataset
  SELECT
  outcome,
  COUNTIF(denial_reason_code IS NULL) AS null_reason_code,
  COUNTIF(denial_reason_code IS NOT NULL) AS has_reason_code
FROM `rcm-project-501818.claims.claims`
GROUP BY outcome;

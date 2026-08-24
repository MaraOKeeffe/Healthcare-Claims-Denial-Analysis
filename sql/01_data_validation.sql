The dataset had null values for many claims that did not have a denial code. To be sure that all null values were considered accepted claims and that all denied claims had a denial code, I ran this query before completing other analysis.
  SELECT
  outcome,
  COUNTIF(denial_reason_code IS NULL) AS null_reason_code,
  COUNTIF(denial_reason_code IS NOT NULL) AS has_reason_code
FROM `rcm-project-501818.claims.claims`
GROUP BY outcome;

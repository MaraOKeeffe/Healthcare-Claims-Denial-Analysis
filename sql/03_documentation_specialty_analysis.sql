During analysis, I checked if medical specialty played a role in denied claims when documentation completeness is controlled for. Across 13 specialties, claims with low documentation were denied at nearly 100% while claims with high documentation were denied at nearly 0%. Claims in the medium band clustered between 37% - 39%. This query reinforces that no specialty  Based on this query, every specialty sat within the same moderate range of denials, allowing me to conclude that no one specialty contributes most to denials. Rather, documentation completeness is the main determining factor.
  WITH banded AS (
  SELECT
    provider_specialty,
    outcome,
    CASE
      WHEN documentation_completeness < 0.5 THEN 'low'
      WHEN documentation_completeness < 0.8 THEN 'medium'
      ELSE 'high'
    END AS doc_band
  FROM `rcm-project-501818.claims.claims`
  WHERE outcome != 'pending'
)


SELECT
  provider_specialty,
  ROUND(
    COUNTIF(outcome = 'denied' AND doc_band = 'low')
    / NULLIF(COUNTIF(doc_band = 'low'), 0),
    4
  ) AS denial_rate_low,
  ROUND(
    COUNTIF(outcome = 'denied' AND doc_band = 'medium')
    / NULLIF(COUNTIF(doc_band = 'medium'), 0),
    4
  ) AS denial_rate_medium,
  ROUND(
    COUNTIF(outcome = 'denied' AND doc_band = 'high')
    / NULLIF(COUNTIF(doc_band = 'high'), 0),
    4
  ) AS denial_rate_high
FROM banded
GROUP BY provider_specialty
ORDER BY provider_specialty;

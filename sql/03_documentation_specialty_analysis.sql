During analysis, I examined whether provider specialty was associated with denial rates when documentation completeness was grouped into three bands: low, medium, and high. Across 13 specialties, claims with low documentation completeness were denied at nearly 100%, while claims with high documentation completeness were denied at nearly 0%. Denial rates across all specialties in the medium-completeness band fell between 37% and 39%, suggesting that documentation completeness has a stronger association with claim denial than provider specialty in this dataset.
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

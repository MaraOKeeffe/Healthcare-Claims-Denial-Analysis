I grouped documentation completeness into three bands when calculating denial rates by payer type. The bands are the same as those used in the query examining provider specialty and documentation completeness. Pending claims were excluded from the calculation. Payers consistently denied claims with low documentation completeness at nearly 100%, while claims with high documentation completeness were denied at almost 0%. Denial rates in the medium band ranged from 36.5% to 38.2% across payers, suggesting that documentation completeness has a stronger association with claim denial than payer type in this dataset.
  SELECT
    payer_type,
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
  payer_type,
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
GROUP BY payer_type
ORDER BY payer_type;

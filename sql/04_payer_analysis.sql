Similar to Query 5, I controlled for documentation completeness when calculating denied claims based on payer type. The results are strikingly similar to Query 5. Payers consistently denied low documentation completeness at nearly 100% and denied high documentation completeness at almost 0%. Denial rates in the medium band sit in the 36.5% to 38.2% range, further confirming that documentation completeness, and not payer type, is the main driving force in claims denials.
  WITH banded AS (
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

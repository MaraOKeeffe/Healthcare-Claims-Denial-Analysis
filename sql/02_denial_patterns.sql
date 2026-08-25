Documentation completeness may play a role in claims denials. I ran a query comparing the highest and lowest levels of documentation completion and compared to denial rate. For documentation completeness of 0.73 and above, there is a 0% denial rate. At 0.49 documentation completeness and below, there is a 100% denial rate. There is also a range beginning at 0.5 where claims may only be partially paid.
  SELECT
  documentation_completeness,
  COUNT(*) AS total_claims,
  COUNT(denial_reason_code) AS total_denials,
  ROUND(COUNT(denial_reason_code) / COUNT(*), 4) AS denial_rate
FROM `rcm-project-501818.claims.claims`
GROUP BY documentation_completeness
ORDER BY documentation_completeness DESC;

/* Documentation completeness may be associated with claim denials. I calculated the denial rate at each documentation completeness level to examine how denial frequency changed as documentation completeness increased. Claims with documentation completeness of 0.49 and below had a 100% denial rate, while claims with documentation completeness of 0.73 and above had a 0% denial rate.*/
  SELECT
  documentation_completeness,
  COUNT(*) AS total_claims,
  COUNT(denial_reason_code) AS total_denials,
  ROUND(COUNT(denial_reason_code) / COUNT(*), 4) AS denial_rate
FROM `rcm-project-501818.claims.claims`
GROUP BY documentation_completeness
ORDER BY documentation_completeness DESC;

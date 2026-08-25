# Power BI DAX Measures

The following DAX measures were used to calculate key metrics in the
Power BI dashboard.

### Total Claims

Counts all claims in the dataset.
```DAX
Total Claims =
COUNTROWS('claims_main - claims_main csv (1)')
```

### Denied Claims

Counts claims with a "denied" outcome  
```DAX
Total Denied Claim Value = 
CALCULATE(
    SUM('claims_main - claims_main csv (1)'[claim_amount_usd]),
    'claims_main - claims_main csv (1)'[outcome] = "denied"
)
```
### Adjudicated Claims

Counts claims with a resolved outcome including claims considered paid, denied, and partial-pay  
```DAX
Adjudicated Claims = 
CALCULATE(
    COUNTROWS('claims_main - claims_main csv (1)'),
    'claims_main - claims_main csv (1)'[outcome] <> "pending"
)
```
### Denial Rate

Calculates denied claims as a percentage of adjudicated claims. Pending claims are excluded from the denominator  
```DAX
Denial Rate = 
DIVIDE([Denied Claims], [Adjudicated Claims])
```
### Total Denied Claim Value

Calculates total claim value associated with claims that received a "denied" outcome  
```DAX
Total Denied Claim Value = 
CALCULATE(
    SUM('claims_main - claims_main csv (1)'[claim_amount_usd]),
    'claims_main - claims_main csv (1)'[outcome] = "denied"
)
```

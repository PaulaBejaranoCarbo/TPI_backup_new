# Referee Report: "Public investment and supply"
**For:** Top-5 Journal Submission  
**Date:** June 30, 2026  
**Status:** MAJOR REVISIONS REQUIRED

---

## CRITICAL ISSUES

### 1. **MAJOR DISCREPANCY: Model Estimation Results**
**Severity: CRITICAL**

The log file shows **θ (thetaG) = 0.002** (posterior mean, 90% HPD: 0.0000–0.0042), but the paper reports **θ = 0.112**. This is a 56-fold difference and completely undermines the paper's main finding.

- **Paper (Table 3, line 284):** θ posterior mean = 0.111789
- **Log file (line 450):** thetaG post. mean = 0.0020, 90% HPD interval: 0.0000–0.0042

**Action needed:** Clarify which estimation results are being used. If the log file is the final run, the paper's conclusions are invalid and must be rewritten. If there's a different specification being reported, clearly justify why and provide the matching log file.

### 2. **Severe Weak Identification of the Key Parameter**
**Severity: CRITICAL**

The paper admits (Section "Is θ well identified?", lines 300–365) that:
- θ is **NOT locally identified at the prior** (contrary to Ercolani & Valle e Azevedo)
- θ shows **near-unit correlation (0.96) with σ_ig** (government investment shock volatility)
- The posterior is tight only relative to the prior, not because data strongly pins down the parameter

This near-unit collinearity is **extremely concerning** and invalidates policy simulations that rest on θ. The paper's acknowledgment is insufficient—this is a fundamental problem that should either:
- Invalidate the main results, or  
- Require substantial alternative identification strategies

The paper states (line 364): "While we feel that these estimation results are sufficient for our purposes, it is clear that further progress on estimating the output elasticity of public capital is needed..." This is an admission that the identification is inadequate. A top-5 journal will not accept this hand-waving.

### 3. **Abstract Contains Unfilled Placeholders**
**Severity: HIGH**

Lines 62, 62 of the abstract:
> "...would translate into a long-run output increase between X.X and X.X per cent..."  
> "...the welfare-maximising share of public investment in output is between X.X and X.X per cent."

These must be filled in with actual numbers before submission. If results depend on θ = 0.112 (which differs from the log's θ = 0.002), all these numbers are wrong.

---

## MAJOR CONCEPTUAL & METHODOLOGICAL ISSUES

### 4. **Inconsistency Between Stated Model and Estimation**
**Severity: HIGH**

- The paper claims to estimate **4 shocks** (productivity, MEI, government consumption, government investment)
- The model in equations includes all 4, but the estimation appears to have **different parameter names** in the log (e.g., thetaG, rhoX, rhoG, rhoIgs)
- **Mapping is unclear:** Is `rhoA` = productivity persistence? Is `thetaG` the public capital elasticity or the government investment shock?

The log file abbreviations don't cleanly map to the paper's notation. This should be transparently documented.

### 5. **Time-to-Build Lags Not Estimated, Borrowed from OBR**
**Severity: MEDIUM-HIGH**

Lines 184–190 introduce time-to-build delays on public investment as a key feature. However, line 236 states:
> "the ωₜ₊ₙ parameters...follow from Suresh et al. (2024)"

These are **not estimated from UK data** but borrowed from the OBR report. This is problematic because:
- The time-to-build profile is critical for quantitative results
- Different time-to-build assumptions would substantially change the welfare-maximization results
- No sensitivity analysis is provided

**Action needed:** Either estimate the time-to-build weights from UK-specific data, or conduct extensive robustness checks varying the time-to-build profile and clearly communicate that results depend on this assumption.

### 6. **Weak Prior on θ Doesn't Justify the Posterior**
**Severity: MEDIUM-HIGH**

The prior is set to β(0.075, 0.02), with mean 0.075 and SD 0.02. The posterior (if it's truly 0.112 as claimed) is only slightly higher than the prior mean. This raises the question:

**To what extent is the posterior estimate driven by the data versus the prior?**

The paper should conduct:
- Posterior sensitivity to different priors
- A direct analysis of likelihood surface (not just posterior)
- Comparison with empirical/reduced-form estimates to validate the Bayesian approach

### 7. **Model Not Locally Identified at Prior, Only at Posterior**
**Severity: MEDIUM**

Section "Is θ well identified?" (line 300) states:
> "We first test this prior to estimation and find that the model is not locally identified at the prior calibration...After conditioning on the UK data, however, the identification tests evaluated at the posterior mean find that the Jacobian is of full column rank across all four criteria."

This is **backwards from desirable.** Ideally:
- Model should be identified at the prior (structural model is data-generating process)
- Adding data should tighten identification, not create it

This suggests the data is **overidentifying some parameters while leaving others unidentified**. The paper doesn't explore which parameters benefit from data and which don't.

### 8. **HP-Filtering Without Justification**
**Severity: MEDIUM**

Line 252: "We HP-filtered each of these series with the smoothing parameter, λ, set at its usual value of 1,600."

- Why 1,600 (quarterly)? Standard for quarterly data, but was it tested?
- HP-filtering introduces well-known distortions (Cogley & Nason, 1995; Hamilton, 2018)
- No alternative detrending method (e.g., first-differencing, local linear trend) is tested
- Detrending choice directly affects identified shocks and elasticities

**Action needed:** Show robustness to HP-filtering alternatives.

---

## SIGNIFICANT ISSUES WITH RESULTS & CLAIMS

### 9. **Welfare-Maximization Results Hinge Entirely on Weak θ**
**Severity: HIGH**

The key result is Figure 1 / Section "Laffer curves" (lines 418–436):
- Optimal s_g: 5.9–6.1% (vs. observed 3.5%)
- Long-run output gain: 12.2–13.1%

These rest on θ = 0.112. Given the 0.96 correlation with σ_ig:

**θ and σ_ig are nearly observationally equivalent.** Higher σ_ig can mimic any value of θ. The welfare results are unreliable.

The paper should:
- Conduct a direct sensitivity analysis: what happens to optimal s_g if θ = 0.05? θ = 0? θ = 0.20?
- Show that results are robust across the confidence interval (which, if the log is correct, is essentially 0.00–0.004)
- Acknowledge that policy recommendations are tentative

### 10. **Comparative Statics Appendix Missing**
**Severity: MEDIUM**

Section 3.2 titled "Comparative statics" (line 371) is mislabeled. Comparative statics would be:
- What happens to optimal s_g as θ varies?
- How sensitive are results to β, α, depreciation rates?

Instead, Section 3.2 just solves for welfare-maximizing s_g under baseline parameters. This is a steady-state normative exercise, not comparative statics.

**Action needed:** Rename section or conduct actual comparative statics across key parameters.

### 11. **No Dynamic Simulations or Impulse Responses**
**Severity: MEDIUM**

The paper estimates a DSGE model with 4 shocks but provides **zero impulse response functions (IRFs).** This is a major omission:
- How does output respond to a public investment shock in the short/medium/long run?
- What is the multiplier on impact vs. 1 year vs. 5 years?
- How do different shocks interact (e.g., productivity + public investment)?

These are bread-and-butter DSGE results and should be included. They also provide a sanity check on whether θ makes sense economically.

---

## SPECIFIC TECHNICAL ISSUES

### 12. **Investment Adjustment Cost Parameter Anomaly**
**Severity: MEDIUM**

Line 269–270: The paper notes:
> "...the investment adjustment cost and labour Frisch elasticites are above that in Burgess et al..."

- Prior: κ ~ N(4, 1.5)
- Posterior: κ = 6.89 (Table 3)

But the **log file shows κ = 3.21** (line 451), roughly inline with Burgess et al. (2013). This is another unexplained discrepancy between the paper's Table 3 and the estimation log.

### 13. **Inverse Frisch Elasticity Prior Derivation Is Circular**
**Severity: LOW-MEDIUM**

Line 265:
> "We set our prior for the inverse Frisch elasticity of labour by...feeding in UK data for consumption...This implies an inverse Frisch elasticity of 0.3, slightly below the 0.5 used in Smets and Wouters."

But the prior then set is N(0.3, 0.03) (Table 3 footnote). The posterior is 0.320. This suggests:
- The prior is **very tight** (SD = 0.03)
- The data barely moves the posterior from the prior
- Labor supply elasticity is essentially fixed, not estimated

This is fine but should be transparent: if η is essentially calibrated, don't present it as "estimated."

### 14. **Steady-State Utility Equation Not Provided**
**Severity: MEDIUM**

Lines 412–415 state:
> "Using equations [3 equations]...we can express steady-state utility as a function of the parameters and the share of public investment..."

But the explicit formula for U*(s_g) is **never given.** Readers cannot verify the welfare-maximization calculation or conduct their own sensitivity analysis.

**Action needed:** Provide the closed-form steady-state utility in the appendix.

### 15. **Distortionary Taxes Are Calibrated, Not Estimated**
**Severity: MEDIUM**

Lines 207 & 225:
- τ_c = 0.157 (average VAT)
- τ_k = 0.231 (average corporate tax)
- τ_n = 0.219 (average income tax)

These are **average historical rates, not current policy rates.** The 2024 UK economy has different taxes:
- Corporation tax: raised to 25% (from 19%)
- National Insurance contributions: changed
- VAT: flat 20%

The welfare results will differ substantially under current tax rates. This should be highlighted and tested.

### 16. **Government Consumption Exogenously Determined, But Why?**
**Severity: LOW-MEDIUM**

Equation on line 561:
> G_{c,t} = C_t * (1-γ)/γ * G_t

This assumes government consumption tracks private consumption. Why? This is:
- Counterfactual (UK government consumption has its own dynamics)
- Unlikely to be optimal
- Could mask feedback effects

The paper should justify or test alternative assumptions (e.g., government consumption is independent, or responds to debt ratios).

### 17. **Public Capital Constant Returns Assumption**
**Severity: LOW-MEDIUM**

The production function (Eq. 1, line 153):
> Y_t = A_t * K_{g,t}^θ * K̃_{p,t}^α * N_t^{1-α}

Does **not** exhibit constant returns to scale in all factors—only in private factors. With θ + α + (1-α) = θ + 1, returns scale by θ.

This is fine (public goods often have increasing returns), but **the steady-state implications are not discussed.** With θ > 0, the model has increasing returns, which:
- Can generate indeterminacy or multiple equilibria
- May require additional mechanisms (monopolistic competition, fixed costs) to rationalize
- Affects long-run growth properties

Is the model balanced growth path well-defined?

---

## WRITING & PRESENTATION ISSUES

### 18. **Typos & Grammatical Issues**

- **Line 101:** "There is a wide empirical literature...are best divided..." – subject-verb disagreement (should be "is")
- **Line 82:** "...the public investment multiplier - is an open question" – em-dash should not precede the verb
- **Line 106:** "try to estimate the state-dependency..." – hyphenation of "state-dependency" is inconsistent (sometimes "state dependency" appears)
- **Line 175:** "In our model, this friction appears in equation...via the effective depreciation rate on **public** capital" – but the sentence is about private capital. This is confusing.
- **Line 252:** "We take observable data from the ONS for GDP, business investment, government consumption, government investment, and private consumption" – repetitive phrasing

### 19. **Notation Inconsistencies**

- K̃_p vs. K̃_{p,t}: sometimes tilde, sometimes not
- U_{k,t} vs. U_k: inconsistent subscripting
- The paper switches between bold and non-bold for vectors without explanation

### 20. **Missing or Unclear References**

- Line 205: "Precise details of which data series we used, including the relevant ONS codes, available on request." – This should be provided in the paper or appendix, not hidden. Transparency requires data specificity.
- Line 236 refers to "Suresh et al. (2024)" as "\cite{Suresh24}" – check that bibliography entry is properly formatted

### 21. **Figure 1 Quality**

Line 424–429: The only figure (Laffer curves) is presented but:
- No error bars or confidence bands in the figure itself (only mentioned in text)
- Figure caption is sparse
- No explanation of how the grey shaded area was computed (Monte Carlo? Confidence intervals on s_g?
)

---

## MISSING ANALYSES / QUICK WINS

### 22. **Impulse Response Functions to Public Investment Shock**
**Recommendation: HIGH PRIORITY, can be done this afternoon**

Show:
- Peak multiplier on impact
- Cumulative 1-year, 5-year multipliers
- Effect on private investment (crowding in/out)
- Effect on wages, hours worked

This is standard DSGE output and validates whether θ = 0.112 makes sense economically.

### 23. **Historical Decomposition**
**Recommendation: MEDIUM PRIORITY**

Decompose historical UK output variance into shocks:
- Productivity shocks
- Public investment shocks
- Other shocks

How much of UK's "lost decade" (post-2008) is explained by each? This contextualizes public investment's role.

### 24. **Robustness to Time-to-Build Profile**
**Recommendation: MEDIUM PRIORITY, can be done this afternoon**

Show optimal s_g under alternative ω_n profiles:
- Faster buildout (more weight at t+1, t+2)
- Slower buildout (more weight at t+5, t+6)

How sensitive are welfare conclusions?

### 25. **Sectoral Analysis**
**Recommendation: MEDIUM PRIORITY**

UK public investment is heterogeneous:
- Infrastructure (transport, energy, water)
- Social capital (schools, hospitals)
- Digital/broadband
- Productive vs. non-productive

Different elasticities for different types would be more policy-relevant. A simple extension: estimate θ separately by sector, or provide literature guidance.

### 26. **Comparison to OBR Estimates**
**Recommendation: QUICK WIN, can be done today**

The paper references Suresh et al. (2024) OBR report repeatedly. Directly compare:
- OBR's estimated multiplier for 1% GDP public investment increase
- This paper's implied multiplier from θ = 0.112
- Are they consistent? If not, why?

This provides external validation.

### 27. **State-Dependency Analysis**
**Recommendation: MEDIUM-LONG TERM**

The paper is positioned as a "medium and long-run" analysis, but doesn't address:
- Is public investment more effective in recessions (spare capacity)?
- How do results change near the zero lower bound?

A brief discussion or pointer to extensions would strengthen the policy narrative.

---

## POLICY RECOMMENDATIONS IN PAPER

### 28. **Policy Conclusions Are Overstated Given Identification Concerns**

Lines 441–442:
> "Taken together, these findings suggest that the United Kingdom has scope to benefit from a sustained increase in productive public investment."

Given the weak identification of θ and the near-unit correlation with σ_ig, this conclusion is **tentative at best**. The paper should:
- Acknowledge uncertainty more explicitly
- Provide a range of welfare estimates under different assumptions about θ
- Recommend targeted empirical/quasi-experimental evidence before major policy shifts

---

## SUMMARY OF REQUIRED ACTIONS

### **Before Resubmission:**

1. **RESOLVE THE DISCREPANCY** between θ = 0.112 (paper) and θ = 0.002 (log file). This is non-negotiable.

2. **Fill in abstract placeholders** (X.X values in lines 62).

3. **Reframe the θ identification problem:**
   - The near-unit correlation (0.96) with σ_ig is not acceptable as-is
   - Either find an alternative identification strategy or substantially weaken policy conclusions
   - Consider instrumental variable or structural break approaches

4. **Add IRFs to public investment shock** (essential for DSGE credibility).

5. **Provide steady-state utility function** explicitly in appendix.

6. **Clarify parameter mapping** between paper notation and log file.

7. **Estimate time-to-build weights from UK data** rather than borrowing from OBR, or conduct extensive robustness checks.

8. **Fix typos and grammatical issues** throughout.

### **Quick Wins (This Afternoon):**

- IRF to public investment shock
- Sensitivity of optimal s_g to θ across confidence interval
- Robustness to time-to-build profile variations
- Comparison to OBR multiplier estimates

### **Longer Term / Accept for Revision:**

- Sectoral analysis of different public investment types
- State-dependency of multipliers
- Quasi-experimental validation of estimated elasticity

---

## OVERALL ASSESSMENT

**Current Status:** NOT READY FOR PUBLICATION at top-5 journal

**Reasons:**
1. Critical discrepancy between reported and estimated parameter values
2. Near-unit identification failure of the key parameter (θ)
3. Missing standard DSGE outputs (IRFs)
4. Overstated policy conclusions given identification weakness
5. Incomplete abstract and unfilled values

**Verdict:** The paper addresses an important question (UK public investment multiplier) with a reasonable methodology (estimated DSGE), but the execution has fundamental issues that must be resolved. With the corrections above, this could become a solid contribution.

**Recommendation:** MAJOR REVISIONS – address point 1 (parameter discrepancy) urgently, as it may invalidate the entire analysis.


# Miniproject Feedback and Assessment

## Report

**"Guidelines" below refers to the MQB report [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) [here](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html) (which were provided to the students in advance).**


**Title:** “Observing Microbial Population Growth across temperature gradients: A Comparison of the performance of phenomenological and mechanistic mathematical growth models”

- **Introduction (15%)**  
  - **Score:** 11/15  
  - Focuses on microbial growth phases and temperature's impact, less on a clear research question. [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) recommends more explicit aims.

- **Methods (15%)**  
  - **Score:** 12/15  
  - 305 experiments aggregated, multi-start NLS. Additional detail on iteration or param constraints is recommended.

- **Results (20%)**  
  - **Score:** 14/20  
  - Gompertz outperforms logistic/cubic, with some mention of temperature. Could present numeric breakdown or more direct references to data.

- **Tables/Figures (10%)**  
  - **Score:** 6/10  
  - Mentions temperature-based comparisons, but not fully integrated with text. [MQB Miniproject report guidelines](https://mulquabio.github.io/MQB/notebooks/Appendix-MiniProj.html#the-report) recommends specific referencing.

- **Discussion (20%)**  
  - **Score:** 15/20  
  - Mechanistic vs. polynomial differences explained. Would be stronger with more data-limitations or next-step reflections.

- **Style/Structure (20%)**  
  - **Score:** 14/20  
  - Good structure. Could be more explicit in linking numeric results to discussion commentary.

**Summary:** Good analysis of how temperature affects growth model performance. Further numeric detail in results and more thorough referencing would polish it.

**Report Score:** 72

---

## Computing
### Project Structure & Workflow

**Strengths**

* Clear end-to-end pipeline.
* Responsibilities are split across three R scripts
* Use of `parallel::mclapply()` in model fitting accelerated processing.
* The `output/` folder in README lists all summary CSVs and figures, reflecting end-user deliverables.

**Suggestions**

1. `run-miniproject.sh`:

   * Use `#!/usr/bin/env bash` plus `set -euo pipefail` to abort on errors and undefined variables.
   * Prepend `cd "$(dirname "$0")"` so relative paths in scripts resolve correctly regardless of invocation location.
   * Currently only runs `model-validation-plotting.R`; consider invoking `data-preparation.R` and `model-fitting.R` explicitly or sourcing them in sequence to ensure reproducibility without manual steps.
   * Redirect stdout/stderr into a timestamped log file under `results/` for auditing and debugging; e.g.,:

     ```bash
     bash run-miniproject.sh 2>&1 | tee "results/pipeline_$(date +'%Y%m%d_%H%M').log"
     ```

2. **Reproducible Environments:**

   * Instead of relying on user-installed packages, initialize **renv** in the repo root and call `renv::restore()` at the top of each R script or in shell driver. Commit `renv.lock` so collaborators share the same versions.

---

### README File

**Strengths**

* Clearly describes project aim, scripts, models, and output files.
* Provides mathematical context for cubic, logistic, and Gompertz models.
* Shows how to run the pipeline via `bash run-miniproject.sh`.

**Suggestions**

1. Add explicit environment setup steps:

   ```bash
   # Clone and enter project
   git clone <repo_url>
   cd MiniProject
   # Restore R environment
   Rscript -e "renv::restore()"
   # Run the analysis
   bash run-miniproject.sh
   ```
2. Embed a tree diagram clarifying where to drop raw data (`data/LogisticGrowthData.csv`) and where output appears (`results/`).
3. Include a `LICENSE` file and cite the source of the raw dataset under a “Data” section, with bibliographic reference.
4. Under “code/”, briefly annotate each script’s inputs, outputs, and core functionality for quick orientation.
5. Ensure code block fences match actual filenames (e.g. `run-miniproject.sh` vs `run_miniproject.sh`).

---

## Script-Level Feedback

####  `data-preparation.R`

* Remove or guard `rm(list = ls())`; instead, assume clean R sessions are launched by the shell driver.
* Use `here::here('data', 'LogisticGrowthData.csv')` for reads and `here::here('results', 'cleaned_data.csv')` for writes, reducing fragile relative paths.
* The `cumsum()` trick works but is hard to parse. Suggestion: 

  ```r
  data <- data %>%
    arrange(Temp, Species, Medium, Rep, Citation, Time) %>%
    mutate(group_id = group_indices(., Temp, Species, Medium, Rep, Citation))
  ```
* After each filter step, print counts of retained vs dropped rows or IDs (e.g., `glimpse()` or custom summary) to document data loss.

####  `model-fitting.R`

* Extract repeated fitting logic into `fit_model(df, type)`, returning a tidy tibble of coefficients and metrics. This would reduce near-duplicate loops for cubic, logistic, and Gompertz.
* Streamline with `nls.multstart::nls_multstart()` to handle multiple starting points, bounds, and parallel sampling rather than custom loops and `set.seed()` inside each.
* For `nlsLM()`, supply explicit `lower` and `upper` vectors for all models (including cubic via `lm()`?—use `lm()` for polynomial but set no bounds).
* In each `tryCatch`, capture error messages into a structured list or CSV (e.g., `errors.csv`) so failures can be diagnosed post-run.
* Pre-allocate lists for each model, then use `dplyr::bind_rows()` once at the end, which is more efficient than repeated `rbind()`.

#### `model-validation-plotting.R`

* *Don’t Repeat Yourself (DRY) summarization:* The `analyze_temperature_range()` function is well-structured but could be generalized further by accepting any metric function or range list. Consider generating a list of range specs and mapping over them.
* After printing summaries, explicitly write each summary table to `results/` for downstream consumption (e.g., CSV or RDS).
* Combine the vioplots and grid-arranged curves using `patchwork` instead of `gridExtra`, offering more concise syntax and consistent theming.
* Avoid hard-coding color names (`"blue","red","green"`); define a single named palette applied across all plots or use `scale_fill_brewer()` for cohesive visuals.

---

### NLLS Fitting Approach

**Strengths**

* Thorough comparison of four model types (including cubic polynomial) via AICc, BIC, and R² metrics.
* Robust multi-start loop strategy with two-phase acceptance (initial R²-driven then AICc-driven) for logistic and Gompertz.
* Temperature-stratified analysis quantifies model performance across biologically relevant ranges.

**Suggestions**

1. Replace custom loops with **nls.multstart** or **nlsBootstrap** to streamline parameter sampling, bounds enforcement, and convergence reporting.
2. Tighten starting distributions using domain knowledge (e.g., plausible ranges for `r_max`, `K`, `t_lag`), and flag fits that hit bounds as potential outliers.
3. Record and summarize convergence codes (`model$convInfo`) and residual standard errors to detect systematic fitting issues.
4. Rather than jittered violin plots alone, consider ridge plots (`ggridges`) or faceted density plots to compare weights distributions more directly.
5. Implement leave-one-timepoint-out or k-fold Cross-Validation to evaluate predictive performance, complementing in-sample AICc/BIC metrics.

---

### Summary

Your pipeline is functionally complete and well-documented. Prioritizing reproducibility (via `renv`), path robustness (`here`), modularization of fitting logic, and leveraging specialized multi-start fitting packages would elevate maintainability and analytical rigor for future coursework or publication. great job!

### **Score: 76**

---

## Overall Score: (72 + 76)/2 = 74
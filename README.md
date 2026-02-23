# EBS Pollock Assessment Scaffold

This repository is a clean assessment workspace scaffold for yearly EBS pollock updates.

## Layout

- `2025/runs/data/`: shared annual input files (update once, reuse across scenarios).
- `2025/runs/<scenario>/`: scenario-specific run directories with `pm.dat`, `control.dat`, and `Makefile`.
- `R/`: yearly analysis driver scripts and comparison utilities.
- `scripts/`: workflow helpers (new year setup, run-order execution).
- `doc/`: report templates and annual notes.

## Recommended workflow

1. Update annual shared data in `YEAR/runs/data`.
2. Keep scenario assumptions isolated in each scenario `control.dat` and `README.md`.
3. Run base first, then alternatives.
4. Load all results with `ebswp::get_results()` and write a model-comparison table.
5. Render docs after model set is finalized.

## Quick start

```bash
# Run base then alternatives for 2025
bash scripts/run_scenarios.sh 2025

# Load and summarize models in R
Rscript R/pm25.R
```

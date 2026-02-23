#!/usr/bin/env Rscript

rm(list = ls())

suppressPackageStartupMessages({
  library(ebswp)
  library(here)
  library(tidyverse)
})

assessment_year <- as.integer(Sys.getenv("ASSESSMENT_YEAR", unset = "2025"))
thisyr <<- assessment_year
lastyr <<- assessment_year - 1
nextyr <<- assessment_year + 1

# Update these two vectors each year.
mod_names <- c("Base", "Drop CPUE", "SST")
mod_dir <- c("base", "alt_drop_cpue", "alt_sst")
thismod <- 1

rundir <- here::here(as.character(assessment_year), "runs")
modlst <- ebswp::get_results(rundir = rundir)

n_use <- min(length(modlst), length(mod_names))
if (n_use == 0) {
  stop(sprintf("No model outputs found under %s", rundir))
}
names(modlst)[seq_len(n_use)] <- mod_names[seq_len(n_use)]

M <<- modlst[[thismod]]
.MODELDIR <<- file.path(rundir, mod_dir, "")

scalar_or_na <- function(x, nm) {
  val <- tryCatch(x[[nm]], error = function(e) NULL)
  if (is.null(val)) return(NA_real_)
  as.numeric(val[1])
}

terminal_ssb <- function(x) {
  s <- tryCatch(x$SSB, error = function(e) NULL)
  if (is.null(s) || nrow(s) == 0) return(NA_real_)
  as.numeric(s[nrow(s), 2])
}

overview <- tibble(
  model = names(modlst)[seq_len(n_use)],
  nll = map_dbl(modlst[seq_len(n_use)], scalar_or_na, nm = "nloglike"),
  terminal_ssb = map_dbl(modlst[seq_len(n_use)], terminal_ssb)
)

out_dir <- here::here("doc", "data")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
out_csv <- file.path(out_dir, sprintf("model_overview_%s.csv", assessment_year))
readr::write_csv(overview, out_csv)

message(sprintf("Loaded %d model(s) from %s", n_use, rundir))
message(sprintf("Wrote %s", out_csv))

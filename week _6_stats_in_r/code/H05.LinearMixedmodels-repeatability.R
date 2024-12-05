#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

#############Linear mixed models - Repeatability####################################

rm(list=ls())

# Aim: Analyze repeatability in unicorn body mass with repeated measurements on individuals.
# Approach: Use MCMCglmm package, with UnicornID as a random factor, to understand random effects in repeated measures.
# Goal: Gain deeper insight into repeatability and interpretation of random effects; familiarize with MCMCglmm's flexible random effects structure.

# Repeatability: Measures consistency of traits (e.g., wing length) within individuals, showing less variation within an individual than between individuals.
# Known as the "intraclass correlation coefficient" (r), repeatability is calculated from between-individual variance.
# Importance: Describes biological traits and assesses method quality (e.g., observer repeatability).
# Calculation: Can be calculated using ANOVA (SS and MS).
# Key reference: "Unrepeatable repeatabilities: a common mistake" (Lessells & Boag 1987), foundational for correct repeatability analysis in biology.

# Repeatability (r) calculation: r = among-group variance (sA^2) / (within-group variance (sW^2) + among-group variance (sA^2)).
# Interpretation: r represents the fraction of total variance explained by among-group differences.
# Importance: Reflects the % of variance due to among-group differences over the total variance.
# Note: ANOVA describes variance partitions, but requires weighting for unbalanced groups to ensure accurate results.
# Key reference: Lessells & Boag (1987) paper addresses complexities in calculating among-group variance, especially for unbalanced groups.

# Variance Calculation: MS (Mean Squares) must be adjusted for group sample sizes; cannot ignore n0.
# n0 (effective sample size): Used when groups are unbalanced; calculated with a complex formula to account for uneven sample sizes.
# Context: Balanced data would have equal sample sizes across groups, but ecological datasets are often unbalanced.
# Simplified Approach: Use linear mixed models to estimate between-group variance, then divide by total variance for repeatability (R).
# Key Formula: R = VB / (VB + VW), where VB = between-group variance, VW = within-group variance.
# Reference: Lessells & Boag emphasize correct variance calculation to avoid errors with unbalanced data.

# Repeatability (R): Represents % of total variance explained by a random factor, often interpreted as within-individual or observer repeatability.
# Concept: Important for understanding variance in repeated measures; calculates the ratio of among-group vs within-group variance.
# Approach: Initially, use a linear mixed model to estimate repeatability, then express R as a percentage.
# Course Note: Repeatability will be revisited using different methods, including Bayesian models, to deepen understanding.
# Practical Application: Start by estimating repeatability for morphological measures in unicorns, with repeated measures for each individual.

rm(list=ls())
d<-read.table("../data/DataForMMs.txt", header=T)
str(d)

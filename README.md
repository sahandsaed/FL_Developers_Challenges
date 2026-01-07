# Replication Package for
Developer Challenges on Federated Learning:  
An Empirical Study of Stack Overflow Posts and GitHub Issues

---

## Data Description and Availability

All **processed datasets** used for the analyses are included in this repository.  
Large CSV files are tracked using **Git Large File Storage (Git LFS)**.  
No sensitive credentials, private keys, or personal data are included.

If raw data cannot be redistributed due to licensing or platform restrictions,
instructions for obtaining the data are provided in the corresponding
subdirectories.

---

## Repository Overview

This repository contains all code and data used or generated to address the
three research questions (RQs) investigated in the paper.  
Below, we describe the workflow for each research question in detail.

---

## Research Question 1 (RQ1)  
**What are the main developer challenges in Federated Learning discussed on
Stack Overflow and GitHub?**

### GitHub Data

For GitHub data, we collected issues and pull requests from Federated Learning
(FL) projects by following the criteria described in the *GitHub Data
Extraction* section of the paper.

For each selected project, the repository name and owner were identified.
Issues and pull requests were then downloaded using a personal access token
via the notebook:

- `Download_Issues_From_GitHub.ipynb`

All downloaded issues were combined into a single CSV file.  
The data were subsequently cleaned and preprocessed using:

- `data_preprocessing.py`

Topic modeling was then applied using BERTopic via:

- `Topic_Modeling_GH.ipynb`

After topic generation, each topic was manually labeled by inspecting
randomly selected samples, representative keywords, and example issues.
Topic labels were validated following the procedure described in the paper.

---

### Stack Overflow Data

For Stack Overflow, a similar process was followed. First, Federated Learning
related tags were identified. Posts associated with these tags were retrieved
using the SQL query:

- `SO_Data_Collection.sql`

To identify tags strongly related to Federated Learning, the following queries
were used:

- `Relevance.sql`
- `Significance.sql`

Tags were selected based on their TRT and TST values, ensuring conceptual
relevance to Federated Learning.

The collected data were then combined and preprocessed using:

- `SO-Data-Cleaning.ipynb`

Topic modeling was applied using:

- `BertopicModelingSOData.ipynb`

As with GitHub data, topics were manually labeled and validated by examining
sample posts and topic keywords.

---

## Research Question 2 (RQ2)  
**What types of questions do developers ask about Federated Learning?**

This research question focuses on identifying the *type* of questions asked by
developers. Each post or issue is categorized into one of four types:

- *How*
- *What*
- *Why*
- *Other*

For both Stack Overflow and GitHub data, the same procedure was applied using:

- `Questions_Type_Code.ipynb`

This notebook loads the labeled topic data, applies rule-based classification
criteria, assigns a question type to each sample, and reports the distribution
of question types across topics.

---

## Research Question 3 (RQ3)  
**Which Federated Learning topics are more difficult for developers?**

This research question examines the difficulty of topics based on developer
support dynamics.

### GitHub

For GitHub data, difficulty was assessed using:

- `GitHub_Difficulty.ipynb`

This analysis extracts:
- the number of unresolved issues per topic, and
- the median response time for issues within each topic.

Topics with a higher number of unresolved issues and longer response times are
considered more difficult.

---

### Stack Overflow

For Stack Overflow data, two SQL queries were used:

- `median.sql` — to compute the median time to receive an accepted answer
- `Withoutanswer.sql` — to identify posts without accepted answers

These metrics were combined to assess the relative difficulty of each topic in
the Stack Overflow context.

---

## Notes

All scripts use relative paths and can be executed from the repository root.
Cloud-based services are not required to reproduce the results.

---


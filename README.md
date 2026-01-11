### Econometric Analysis: Transit Infrastructure Spending and U.S. Unemployment

This repository contains the R code used for my ECON 435: Econometric Methods term paper at Simon Fraser University. The project investigates how public transit infrastructure spending relates to changes in the U.S. unemployment rate, using time‑series econometric techniques.

### Methods and Tools

The analysis incorporates:

-   Static time‑series regression models

-   Augmented Dickey--Fuller tests for stationarity

-   Breusch--Pagan tests for heteroskedasticity

-   The tidyverse ecosystem for data wrangling and visualization

### Project Structure

-   All empirical results in the paper come from RDS objects and PNG figures produced by the scripts in `scripts/`.

-   The final term paper is included in the project root in `.pdf` format for reference.

-   All statistical tests, model outputs, and generated figures are saved in the `results/` directory in `.qmd` and `.pdf` formats.

-   All data used in the analysis is located in the `data/` directory which contains data in raw, intermediate, and processed forms.

-   Graphs generated from scripts are located in the `graphs/` directory and saved in the `.png` format.

-   Model objects generated from scripts are located in the `models/` directory and saved in the `.rds` format.

-   Statistical test objects generated from scripts are located in the `stats_tests/` directory and saved in the `.rds` format.

### Reproducibility

All empirical results in the paper are generated from RDS objects and PNG figures produced by the scripts in the `scripts/` directory. To reproduce the workflow, run the R scripts in sequence to clean and transform the data, estimate models, conduct diagnostic tests, and generate visualizations.

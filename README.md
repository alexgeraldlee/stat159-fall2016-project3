#Project 3

##Alexander Lee, Xinyu Zhang, Youngshin Kim, Austin Carango

This project is a consulting project for the following client:

* A group of administrators trying to make their school more competitive, wanting to compare themselves to similar schools in demographics and population centers, in terms of diversity, and graduation rates.

Project structure is as follows:

* `data/` contains `final.csv`, the cleaned, mean-centered and standardized data. Also contains `eda.txt` as well as `.RData` files for each regression.

* `images/` contains pdfs for diagnostic/validation plots for each regression as well as `boxplots/` and `histograms/` which are self explanatory, containing graphics created by the eda script.

* `report/` contains `report.Rnw` the raw sweave file for the report and `report.pdf`, the final report itself, in addition to `sections/` which contains child documents for the sections of the report.

* `scripts/` contains `.R` files for eda, data-cleaning, and each regression.

* `Shiny/` contains two copied folder (data&images) as well as server.r and ui.r

* Files contained in the root directory include the Makefile, gitignore, license, and session info.

To reproduce this project simply run the command `make all` from the root directory.

Phony targets for the makefile include:

* `all` which runs all phony targets
* `eda` which runs the eda script
* `regression` which runs all regression scripts
* `report`which creates `report.pdf`
* `clean` which deletes `report.pdf`
* `ols` which runs the ols regression script
* `plsr` which runs the plsr script
* `lasso` which runs the lasso regression script
* `randomforest` which runs the random forest regression script
* `preproc` which runs the data-cleaning/centering/standardizing script

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>. 

All code is licenced under MIT. See `license.Rmd` for details.
All media is licensed under CC Atribution 4.0 International. All code is licenced under MIT. See `license.Rmd` for details.

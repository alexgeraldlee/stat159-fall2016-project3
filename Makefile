.PHONY: all eda regression report clean 

# all	
all: eda regression report preproc ols plsr lasso randomforest 

# Runs data prprocessing script
preproc: scripts
	Rscript -e 'source("scripts/data_cleaning.R")'

ols:
	Rscript -e 'source("scripts/ols-regression.R")'

plsr: 
	Rscript -e 'source("code/scripts/plsr.R")'

lasso:
	Rscript -e 'source("code/scripts/lasso.R")'

randomforest:
	Rscript -e 'source("scripts/randomforest.R")'

eda:
	Rscript -e 'source("scripts/eda.R")'

regression:
	make ols
	make randomforest
	make lasso
	make plsr

report: report/report.Rnw
	R CMD Sweave --pdf report/report.Rnw; rm report/report.aux report/report.log report/report.tex report/report.out report/report-concordance.tex

slides: slides/slides.Rmd
	Rscript -e 'rmarkdown::render("slides/slides.Rmd")'

clean:
	rm -f report/report.pdf

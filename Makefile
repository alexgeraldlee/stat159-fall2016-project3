.PHONY: all eda regression report clean ols plsr lasso randomforest preproc

# all	
all: preproc eda regression report

# Runs data prprocessing script
preproc: scripts
	Rscript -e 'source("scripts/data_cleaning.R")'

ols:
	Rscript -e 'source("scripts/ols.R")'

plsr: 
	Rscript -e 'source("scripts/plsr.R")'

lasso:
	Rscript -e 'source("scripts/lasso.R")'

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
	R CMD Sweave --pdf report/report.Rnw;
	rm report.aux report.log report.tex report.out report-concordance.tex;
	mv report.pdf report/

slide:
	Rscript -e "library(rmarkdown); library("xtable"); render('slides/slides.Rmd', 'ioslides_presentation')"

shinyapp:
	cp data/* shiny/stat159-project3/data/
	cp images/*.png shiny/stat159-project3/www/ 
	Rscript -e "library(methods); shiny::runApp(appDir='shiny/stat159-project3', launch.browser=TRUE)"

clean:
	rm -f report/report.pdf

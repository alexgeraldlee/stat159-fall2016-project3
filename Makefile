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
	

slides: slides/slides.Rmd
	Rscript -e 'rmarkdown::render("slides/slides.Rmd")'

shinyapp:
	cp data/* shiny/stat159-project3/data/
	cp image/* shiny/stat159-project3/image/ 
	Rscript -e "library(methods); shiny::runApp("shinyApp/app.R", launch.browser=TRUE)"

clean:
	rm -f report/report.pdf

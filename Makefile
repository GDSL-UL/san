.PHONY: all html pdf epub

all:
	Rscript -e "bookdown::render_book('index.Rmd', c('bookdown::gitbook', 'bookdown::pdf_book', 'bookdown::epub_book'))"
	rm spatial_analysis_notes.log

html:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
	rm spatial_analysis_notes.log

pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
	rm spatial_analysis_notes.log
	
epub:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"
	rm spatial_analysis_notes.log

server:
	docker run -d -e USERID=$$(id -u) -e ROOT=true -e PASSWORD=test123 -p 8787:8787 -v ${PWD}:/home/rstudio/work darribas/gdsr:1.0alpha

# make chapter no=04-points
chapter:
	Rscript -e "rmarkdown::render('$(no).Rmd')"

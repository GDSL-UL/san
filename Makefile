.PHONY: all website

all:
	Rscript -e "bookdown::render_book('index.Rmd', \
																		c('bookdown::gitbook', \
																		  'bookdown::pdf_book', \
																		  'bookdown::epub_book') \
																		)"
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

.PHONY: all website

all:
	Rscript -e "bookdown::render_book('index.Rmd', \
																		c('bookdown::gitbook', \
																		  'bookdown::pdf_book', \
																		  'bookdown::epub_book') \
																		)"

html:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
	
epub:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"
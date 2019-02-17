
all:
	pdflatex -interaction=nonstopmode main.tex
	pdflatex -interaction=nonstopmode main.tex
	bibtex chapter_1
	bibtex chapter_2
	pdflatex -interaction=nonstopmode main.tex
	pdflatex -interaction=nonstopmode main.tex

clean:
	rm *.aux *.bbl *.log *.out *.pdf *.toc *.blg *.fls *.fdb_latexmk

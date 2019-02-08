
all:
	pdflatex -interaction=nonstopmode example.tex
	pdflatex -interaction=nonstopmode example.tex
	bibtex example_chapter1
	bibtex example_chapter2
	pdflatex -interaction=nonstopmode example.tex
	pdflatex -interaction=nonstopmode example.tex

clean:
	rm *.aux *.bbl *.log *.out *.pdf *.toc *.blg *.fls *.fdb_latexmk

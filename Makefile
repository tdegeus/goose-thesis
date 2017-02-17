
all:
	xelatex -interaction=nonstopmode example.tex
	xelatex -interaction=nonstopmode example.tex
	bibtex example_chapter1
	bibtex example_chapter2
	xelatex -interaction=nonstopmode example.tex
	xelatex -interaction=nonstopmode example.tex

clean:
	rm *.aux *.bbl *.log *.out *.pdf *.toc *.blg *.fls *.fdb_latexmk

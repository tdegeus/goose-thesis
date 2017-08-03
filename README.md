# goose-thesis

A customized book class for LaTeX.

## Contents

<!-- MarkdownTOC -->

- [Usage](#usage)
- [Options](#options)
- [Input files](#input-files)
- [Citations](#citations)

<!-- /MarkdownTOC -->

## Usage

`goose-thesis` is a customized class designed to compile a thesis from several chapters, which are usually stored as separate input-files. These chapters also have some requirements on the structure, see: *[Input files](#input-files)*. The main document (e.g. `main.tex`) has the following structure:

```latex
%!TEX program = xelatex
\documentclass[...]{goose-thesis}

% The title and author.
\title{...}
\author{...}
\hypersetup{pdfauthor={...}}

% %%%%%%%%%%%%%%
\begin{document}
% %%%%%%%%%%%%%%

\maketitle

\setcounter{tocdepth}{0}
\tableofcontents

\cleardoublepage
\include{chapterX.tex}

\cleardoublepage
\include{chapterY.tex}

\bibliography{...}

% %%%%%%%%%%%%
\end{document}
% %%%%%%%%%%%%
```

By default most of the standard LaTeX-packages are loaded. Any of these packages can be re-loaded, with other defaults, without problems. In addition, the title and the author should be specified.

>   Note that the first line `%!TEX program = xelatex` is only needed if a non-LaTeX-standard font is selected. In fact, only when an editor is used which supports compiler selection this way. For those unfamiliar, XeLaTeX is similar to `pdflatex` but is allows for the usage of TrueType-fonts.

## Options

*   `garamond`, `times`, `verdana`

    Choose a font. The default computer-modern font is used if no font is specified.

*   `narrow`

    Widen the margins of the page, useful during the review process.

*   `doublespacing`

    Set the line-spacing to double, useful during the review process.

*   `namecite`

    Use names instead of numbers to cite to references.

*   `eqreflocal`

    Number the equations without a chapter number, but still starting from one in each chapter.

*   `sectionbib`

    Include the bibliography at the end of each chapter. If this option is used, the `\bibliography{...}` command should be removed from the main TeX-file. Instead, each of the chapters should include this command at the end of the chapter. Compiling in this case warrants some attention. First compile the main TeX-file using `pdflatex` or `xelatex` (depending on the selected font). Then run `bibtex` on each of the chapters. Finally recompile the main TeX-file. This corresponds to the following series of commands:

    ```bash 
    xelatex -interaction=nonstopmode main.tex
    xelatex -interaction=nonstopmode main.tex
    bibtex chapterX
    bibtex chapterY
    xelatex -interaction=nonstopmode main.tex
    xelatex -interaction=nonstopmode main.tex
    ```

    (see also the [Makefile](https://github.com/tdegeus/GooseLaTeX/blob/master/goose-thesis/Makefile) of the example).

## Input files

Each of these input-files follow the same structure (e.g. `chapterX.tex`). It begins with the title of the chapter: `\chapter{...}`. The chapter name and its number are printed on the front-page on this chapter. In addition, a number of fields can be included on the front-page between between `\begin{frontmatter} ... \end{frontmatter}`. 

```latex
% Title of the chapter (shown of title page)
\chapter{...}

\begin{frontmatter}

% Abstract of the chapter (shown of title page)
\begin{abstract}
...
\end{abstract}

% Keywords of the chapter (shown of title page)
\keywords{...}

% Special remarks for the chapter (shown of title page)
% (use for example to include bibliographical information)
\begin{remark}
...
\end{remark}

\end{frontmatter}

...

\appendix

...
```

The following fields can be included on the front-page between between `\begin{frontmatter} ... \end{frontmatter}`:

*   `\begin{abstract} ... \end{abstract}`

    An abstract to the chapter.

*   `\keywords{...}`

    Keywords of the chapter.

*   `\begin{remarks} ... \end{remarks}`

    Any remarks to the chapter, for example a reference from which the chapter is reproduced, or the author(s) of the chapter.

## Citations

Citations and references are handled using [natbib](http://ctan.org/pkg/natbib). In this class, the `unsrtnat` layout is used. Thereby, the extended `unsrtnat.bst` is available that includes output for the `eprint` field. The `goose-article` class creates commands to convert the `doi` and `eprint` fields to links (to `doi.org` and `arxiv.org` respectively).

Following standard natbib, one can use `\cite{...}` or `\citep{...}` for normal citations and `\citet{...}` to include the name. [See also this cheat-sheet](http://merkel.texture.rocks/Latex/natbib.php).

Note that the outputted reference-list depends largely on the content of the included `bib`-file. A simple command-line tool, [bibparse](https://github.com/tdegeus/bibparse), is available to clean-up arbitrary `bib`-files.

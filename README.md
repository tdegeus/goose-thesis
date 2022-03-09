[![ci](https://github.com/tdegeus/goose-thesis/workflows/CI/badge.svg)](https://github.com/tdegeus/goose-thesis/actions)
[![pre-commit](https://github.com/tdegeus/goose-thesis/workflows/pre-commit/badge.svg)](https://github.com/tdegeus/goose-thesis/actions)

# goose-thesis

A customised book class for LaTeX.

>   This library is free to use.
>   Any additions are very much appreciated, in terms of suggested functionality, code,
>   documentation, testimonials, word-of-mouth advertisement, ....
>   As always, the code comes with no guarantee.
>   None of the developers can be held responsible for possible mistakes or misuse.
>
>   Bug reports or feature requests can be filed on GitHub.
>
>   (c - MIT) T.W.J. de Geus (Tom) | tom@geus.me | www.geus.me |
>   [github.com/tdegeus/goose-thesis](http://github.com/tdegeus/goose-thesis)

## Contents

<!-- MarkdownTOC -->

- [Usage](#usage)
- [Options](#options)
- [Input files](#input-files)
- [Citations](#citations)
- [Examples](#examples)

<!-- /MarkdownTOC -->

## Usage

`goose-thesis` is a customised class designed to compile a thesis from several chapters,
which are usually stored as separate input files.
These chapters also have some requirements on the structure, see: *[Input files](#input-files)*.
To get started, copy the files from [src/](src/) to to main directory of your project
(always copy [goose-thesis.cls](src/goose-thesis.cls) and
copy to your need [unsrtnat.bst](src/unsrtnat.bst) or [apalike.bst](src/apalike.bst)).

By default, most of the standard LaTeX packages are loaded.
Any of these packages can be reloaded without problems (possibly using other options).
In addition, the title and the author should be specified.

Consequently, the main document (e.g. `main.tex`) has the following structure:

```latex
\documentclass[...]{goose-thesis}

% The title (also used as PDF-title) and author.
\title{...}
\author{...}

% The author to put in the PDF information.
\hypersetup{pdfauthor={...}}

% =============================

\begin{document}

\maketitle

\setcounter{tocdepth}{0}
\tableofcontents

\cleardoublepage
\input{chapterX.tex}

\cleardoublepage
\input{chapterY.tex}

\bibliographystyle{unsrtnat}
\bibliography{...}

\end{document}
```

Compile as usual, but (strictly) on the main file, for example:
```bash
latexmk main.tex
```

## Options

*   `garamond`, `times`, `verdana`

    Choose a font.
    The default computer-modern font is used if no font is specified.
    If you select one of these fonts, switch in compilation from using `pdflatex` to `xelatex`.

*   `narrow`, `wide`, `wwide`

    Change the page margins (from largest to smallest margins: `narrow`, (normal), `wide`, `wwide`).

*   `doublespacing`

    Set the line spacing to double, useful during the review process.

*   `fleqn`

    Use left-aligned (instead of centered) equations.

*   `empty`

    Do not use any header (does not even show the page number).

*   `twocolumnbib`

    Use a two-column bibliography.

*   `namecite`

    Use name citations instead of numbers.
    Often combined with `\bibliographystyle{apalike}` (see below).

*   `eqreflocal`

    Number the equations without a chapter number, but still starting from one in each chapter.

*   `chapterbib`

    Include the bibliography at the end of each chapter.
    If this option is used, the `\bibliographystyle{...}` and `\bibliography{...}` should
    not appear in the main TeX file.
    Instead, each of the chapters should include these commands at the end of the chapter.
    Also, the chapters should be included using `\include{...}` instead of `\input{...}`.
    See also the [chapterbib example](examples/chapterbib/).

*   `bibunits`

    Similar to the `chapterbib` option, but with the benefit that
    `\bibliographystyle{...}` and `\bibliography{...}` can be defined globally.
    In this case the main document with be
    ```latex
    \documentclass[bibunits]{goose-thesis}
    \defaultbibliographystyle{...}
    \defaultbibliography{...}

    \begin{document}
    ...
    \end{document}
    ```
    whereas in the chapters, you just have to put `\putbib` where you want the bibliography.
    See also the [bibunits example](examples/bibunits/).

*   `showlinks`

    Highlight links in the displayed (i.e. not the printed one) PDF.

*   `colorlinks`

    Show links using a blue color.

*   Other book options. For example `12pt`.

## Input files

Each of these input files follows the same structure (e.g. `chapterX.tex`).
It begins with the title of the chapter: `\chapter{...}`.
The chapter name and its number are printed on the front page on this chapter.
In addition, a number of fields can be included on the front page between
`\begin{frontmatter} ... \end{frontmatter}`.

```latex
% Title of the chapter (shown on the title page)
\chapter{...}

\begin{frontmatter}

% Abstract of the chapter (shown on the title page)
\begin{abstract}
...
\end{abstract}

% Special remarks for the chapter (shown on the title page)
% (use for example to include bibliographical information)
\begin{remark}
...
\end{remark}

\end{frontmatter}

...

\appendix

...
```

The following fields can be included on the front page between
`\begin{frontmatter} ... \end{frontmatter}`:

*   `\begin{abstract} ... \end{abstract}`

    An abstract to the chapter.

*   `\begin{remarks} ... \end{remarks}`

    Any remarks to the chapter, for example a reference from which the chapter is reproduced,
    or the author(s) of the chapter.

## Citations

Citations and references are handled using [natbib](http://ctan.org/pkg/natbib).
In this class, the `unsrtnat` layout is used.
Thereby, the extended `unsrtnat.bst` is available that includes output for the `arxivid` field.
The `goose-thesis` class creates commands to convert the `doi` and `arxivid` fields to links
(to `doi.org` and `arxiv.org` respectively).
Similarly a customised `apalike` style is available.

Following standard natbib, one can use `\cite{...}` or `\citep{...}` for normal citations
and `\citet{...}` to include the name.
[See also this cheat sheet](http://merkel.texture.rocks/Latex/natbib.php).

Note that the outputted reference list depends largely on the content of the included `bib`-file.
A simple command-line tool, [GooseBib](https://github.com/tdegeus/GooseBib),
is available to clean up arbitrary `bib`-files.

## Examples

* [Basic example](examples/basic/example.tex)
* [Bibliography per chapter](examples/sectionbib/example.tex)

% ------------------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "goose-thesis.cls",
%     version         = "0.3",
%     date            = "16 November 2016",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, goose-thesis",
%     supported       = "http://tdegeus.github.io/GooseLaTeX",
%     docstring       = "A customized book-class."
% ------------------------------------------------------------------------------

% ==============================================================================
% Basic settings
% ==============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{goose-thesis}[2016/11/16 v0.3 customized book class]

% load default article class
\LoadClass[a4paper,fleqn,twoside]{book}

% ==============================================================================
% Options
% ==============================================================================

% bibliography [namecite,sectionbib]
% ----------------------------------

\newif\if@namecite
\let\if@namecite\iffalse
\DeclareOption{namecite}{\let\if@namecite\iftrue}

\newif\if@sectionbib
\let\if@sectionbib\iffalse
\DeclareOption{sectionbib}{\let\if@sectionbib\iftrue}

% Review: [narrow,doublespacing]
% ------------------------------

\newif\if@narrow
\let\if@narrow\iffalse
\DeclareOption{narrow}{\let\if@narrow\iftrue}

\newif\if@doublespacing
\let\if@doublespacing\iffalse
\DeclareOption{doublespacing}{\let\if@doublespacing\iftrue}

% Font: [times,garamond,verdana]
% ------------------------------

\newif\if@font
\let\if@font\iffalse

\newif\if@times
\let\if@times\iffalse
\DeclareOption{times}{\let\if@times\iftrue\let\if@font\iftrue}

\newif\if@garamond
\let\if@garamond\iffalse
\DeclareOption{garamond}{\let\if@garamond\iftrue\let\if@font\iftrue}

\newif\if@verdana
\let\if@verdana\iffalse
\DeclareOption{verdana}{\let\if@verdana\iftrue\let\if@font\iftrue}

% Process options
% ---------------

\ProcessOptions\relax

% ==============================================================================
% Packages
% ==============================================================================

\RequirePackage[left=25mm,right=25mm,top=30mm,bottom=30mm]{geometry}
\if@narrow
  \newgeometry{left=40mm,right=40mm,top=30mm,bottom=30mm}
\fi

\RequirePackage{graphicx}
\RequirePackage{amssymb,amsfonts,bm,cancel}
\RequirePackage{enumerate,enumitem}
\RequirePackage[fleqn]{amsmath}
\RequirePackage{chapterbib}
\RequirePackage[font={small},labelfont=bf,labelsep=period]{caption}
\RequirePackage[bf]{titlesec}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{etoolbox}
\RequirePackage{hyperref}

% ==============================================================================
% Citation style
% ==============================================================================

\if@namecite
  \RequirePackage{natbib}
  \let\oldbibliography\bibliography
  \renewcommand{\bibliography}[1]{%
    \bibliographystyle{apalike}
    \setlength{\bibsep}{3pt plus 0.3ex}
    \def\bibfont{\scriptsize}
    \renewcommand{\bibname}{References}
    \oldbibliography{#1}
  }
\else
  \RequirePackage[square,sort&compress,numbers,comma]{natbib}
  \let\oldbibliography\bibliography
  \renewcommand{\bibliography}[1]{%
    \bibliographystyle{unsrtnat}
    \setlength{\bibsep}{3pt plus 0.3ex}
    \def\bibfont{\scriptsize}
    \renewcommand{\bibname}{References}
    \oldbibliography{#1}
  }
\fi

% define DOI command
\newcommand*{\doi}[1]{\sloppy\href{http://dx.doi.org/#1}{doi:~#1}}
\newcommand*{\eprint}[1]{\sloppy\href{http://arxiv.org/abs/#1}{arXiv:~#1}}

% change to section instead of chapter
\if@namecite
  \AtBeginDocument{%
    \makeatletter
    \renewcommand\bibsection{%
      \section*{{\normalfont\large\bfseries\bibname}\@mkboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}}%
    }%
    \makeatother
  }
\fi

% ==============================================================================
% Font
% ==============================================================================

\if@font
  \RequirePackage{mathspec}
  \RequirePackage{fontspec}
\fi

\if@garamond
  \AtBeginDocument{%
    \setmathfont(Digits)[Numbers=OldStyle]{Garamond}%
    \setromanfont[%
      BoldFont={Garamond Bold},%
      ItalicFont={Garamond Italic},%
      Mapping=tex-text%
    ]{Garamond}%
  }%
\fi

\if@verdana
  \AtBeginDocument{%
    \defaultfontfeatures{Mapping=tex-text}
    \setmainfont[Mapping=tex-text]{Verdana}
    \setsansfont{Verdana}
    \renewcommand*{\familydefault}{\sfdefault}
    \setmathfont(Greek,Digits,Latin){Verdana}
    \setmathrm{Verdana}
  }%
\fi

\if@times
  \AtBeginDocument{%
    \setmathfont(Digits)[Numbers=OldStyle]{Times New Roman}%
    \setromanfont[%
      BoldFont={Times New Roman Bold},%
      ItalicFont={Times New Roman Italic},%
      Mapping=tex-text%
    ]{Times New Roman}%
  }%
\fi

% ==============================================================================
% Spacing
% ==============================================================================

\if@doublespacing
  \AtBeginDocument{%
    \usepackage{setspace}
    \doublespacing
  }%
\fi

% ==============================================================================
% Hyperref
% ==============================================================================

\AtBeginDocument{%
  \hypersetup{%
    pdftitle=\@title,
    citecolor=Blue,
    filecolor=black,
    linkcolor=Blue,
    urlcolor=Blue,
    breaklinks,
    hidelinks,
    bookmarksopen=true,
  }%
}

% ==============================================================================
% Headers
% ==============================================================================

% {command}{format}{label}{sep}{before-code}{after-code}
% - chapters
\titleformat
  {\chapter}
  [display]
  {\bfseries\Large}
  {\hfill CHAPTER\ \thechapter}
  {0.5ex}
  {} % before-code
  [\vspace{-0.5ex}\rule{\textwidth}{0.3pt}]
% - section
\titleformat
  {\section}
  {\normalfont\large\bfseries}
  {\thesection}
  {1em}
  {}
  {}
% - subsection
\titleformat
  {\subsection}
  {\normalfont\normalsize\bfseries}
  {\thesubsection}
  {1em}
  {}
  {}
% - paragraph
\titleformat
  {\paragraph}
  {\normalfont\normalsize\bfseries}
  {}
  {}
  {\vspace*{-0.6em}}

% spacing {left}{top}{bottom}, of:
% - section
\titlespacing{\section}
  {0pt}{1eM}{0.8em}
% - subsection
\titlespacing{\subsection}
  {0pt}{0.8em}{0.4em}

% no paragraph indent after header
\AtBeginDocument{%
  \makeatletter
  \let\orig@afterheading\@afterheading
  \def\@afterheading{%
     \@afterindentfalse
    \orig@afterheading}
  \makeatother
}

% ==============================================================================
% Numbering
% ==============================================================================

% equations: per chapter (without chapter number)
% -----------------------------------------------

\renewcommand\theequation{\arabic{equation}}

% appendix: per chapter
% ---------------------

\pretocmd{\chapter}{\renewcommand\thesection{\thechapter.\arabic{section}}}{}{}

\newcommand\appsection{%
  \setcounter{section}{0}%
  \renewcommand\thesection{\thechapter.\Alph{section}}}

\renewcommand{\appendix}{\appsection}

% ==============================================================================
% Header and footer
% ==============================================================================

\RequirePackage{fancyhdr}

\fancypagestyle{fancychapter}{\fancyhead{}\fancyfoot[C]{\scriptsize \thepage}}

\assignpagestyle{\chapter}{fancychapter}


\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhead[RO,LE]{\scriptsize \thepage}
\newcommand{\header}[1]{\fancyhead[LO,RE]{\scriptsize\itshape#1}}

% ==============================================================================
% Abstract, keywords and reference information
% ==============================================================================


\newcommand{\keywords}[1]{\vspace*{0.5eM}\noindent\textbf{Keywords: }#1}

\newenvironment{abstract}{\section*{Abstract}\noindent\ignorespaces}{\ignorespacesafterend}

\newenvironment{remark}{\vfill\noindent\itshape\ignorespaces}{\normalfont\ignorespacesafterend}

\renewenvironment{frontmatter}{\noindent\vfill\ignorespaces}{\normalfont\ignorespacesafterend\clearpage}



% ------------------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "goose-thesis.cls",
%     version         = "0.5.0",
%     date            = "February 2022",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, goose-thesis",
%     supported       = "https://github.com/tdegeus/goose-thesis",
%     docstring       = "A customized book-class."
% ------------------------------------------------------------------------------

% ==============================================================================
% Basic settings
% ==============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{goose-thesis}[2022/02/25 v0.5.0 customized book class]

% ==============================================================================
% Options
% ==============================================================================

% Bibliography [namecite, twocolumnbib, sectionbib]
% -------------------------------------------------

\newif\if@namecite
\let\if@namecite\iffalse
\DeclareOption{namecite}{\let\if@namecite\iftrue}

\newif\if@twocolumnbib
\let\if@twocolumnbib\iffalse
\DeclareOption{twocolumnbib}{\let\if@twocolumnbib\iftrue}

\newif\if@sectionbib
\let\if@sectionbib\iffalse
\DeclareOption{sectionbib}{\let\if@sectionbib\iftrue}

% Layout [narrow, doublespacing]
% ------------------------------

\newif\if@narrow
\let\if@narrow\iffalse
\DeclareOption{narrow}{\let\if@narrow\iftrue}

\newif\if@wwide
\let\if@wwide\iffalse
\DeclareOption{wwide}{\let\if@wwide\iftrue}

\newif\if@wide
\let\if@wide\iffalse
\DeclareOption{wide}{\let\if@wide\iftrue}

\newif\if@doublespacing
\let\if@doublespacing\iffalse
\DeclareOption{doublespacing}{\let\if@doublespacing\iftrue}

% Header [empty]
% --------------

\newif\if@empty
\let\if@empty\iffalse
\DeclareOption{empty}{\let\if@empty\iftrue}

% Math [fleqn]
% ------------

\newif\if@fleqn
\let\if@fleqn\iffalse
\DeclareOption{fleqn}{\let\if@fleqn\iftrue}

% Font [times, garamond, verdana]
% -------------------------------

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

% Numbering
% ---------

\newif\if@eqreflocal
\let\if@eqreflocal\iffalse
\DeclareOption{eqreflocal}{\let\if@eqreflocal\iftrue}

% Hyperref [showlinks, colorlinks]
% --------------------------------

\newif\if@showlinks
\let\if@showlinks\iffalse
\DeclareOption{showlinks}{\let\if@showlinks\iftrue}

\newif\if@colorlinks
\let\if@colorlinks\iffalse
\DeclareOption{colorlinks}{\let\if@colorlinks\iftrue}

% Process options
% ---------------

\ProcessOptions\relax

% ==============================================================================
% Packages
% ==============================================================================

\if@fleqn
    \LoadClass[a4paper, fleqn, twoside]{book}
\else
    \LoadClass[a4paper, twoside]{book}
\fi

\if@narrow
    \RequirePackage[left=40mm, right=40mm, top=30mm, bottom=30mm]{geometry}
\else
    \if@wwide
        \RequirePackage[left=10mm, right=10mm, top=20mm, bottom=20mm]{geometry}
    \else
        \if@wide
            \RequirePackage[left=15mm, right=15mm, top=20mm, bottom=20mm]{geometry}
        \else
            \RequirePackage[left=25mm, right=25mm, top=30mm, bottom=30mm]{geometry}
        \fi
    \fi
\fi

\RequirePackage{fix-cm}
\RequirePackage{graphicx}
\RequirePackage{subfig}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{bm}
\RequirePackage{enumerate}
\if@fleqn
    \RequirePackage[fleqn]{amsmath}
\else
    \RequirePackage{amsmath}
\fi
\RequirePackage[font={small},labelfont=bf,labelsep=period]{caption}
\RequirePackage[bf]{titlesec}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{etoolbox}
\RequirePackage{ragged2e}
\RequirePackage{hyperref}
\RequirePackage[capitalise]{cleveref}

% ==============================================================================
% Citation style
% ==============================================================================

\if@namecite
    \RequirePackage{natbib}
    \let\oldbibliography\bibliography
    \renewcommand{\bibliography}[1]{%
        \setlength{\bibsep}{3pt plus 0.3ex}
        \def\bibfont{\scriptsize}
        \renewcommand{\bibname}{References}
        \if@twocolumnbib
            \begin{multicols}{2}\raggedright\oldbibliography{#1}\justifying\end{multicols}
        \else
            \raggedright\oldbibliography{#1}\justifying
        \fi
    }
\else
    \RequirePackage[square,sort&compress,numbers,comma]{natbib}
    \let\oldbibliography\bibliography
    \renewcommand{\bibliography}[1]{%
        \setlength{\bibsep}{3pt plus 0.3ex}
        \def\bibfont{\scriptsize}
        \renewcommand{\bibname}{References}
        \if@twocolumnbib
            \begin{multicols}{2}\raggedright\oldbibliography{#1}\justifying\end{multicols}
        \else
            \raggedright\oldbibliography{#1}\justifying
        \fi
    }
\fi

\if@sectionbib
    \RequirePackage[sectionbib]{bibunits}
\fi

% define DOI command
\newcommand*{\doi}[1]{\sloppy\href{http://dx.doi.org/#1}{doi:~#1}}
\newcommand*{\arxivid}[1]{\sloppy\href{http://arxiv.org/abs/#1}{arXiv:~#1}}

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

\if@showlinks
    \AtBeginDocument{%
        \hypersetup{%
            pdftitle=\@title,
            citecolor=NavyBlue,
            filecolor=NavyBlue,
            linkcolor=NavyBlue,
            urlcolor=NavyBlue,
            breaklinks,
            bookmarksopen=true,
        }%
    }
\else
    \if@colorlinks
        \AtBeginDocument{%
            \hypersetup{%
                pdftitle=\@title,
                citecolor=NavyBlue,
                filecolor=NavyBlue,
                linkcolor=NavyBlue,
                urlcolor=NavyBlue,
                breaklinks,
                bookmarksopen=true,
            }%
        }
    \else
        \AtBeginDocument{%
            \hypersetup{%
                pdftitle=\@title,
                citecolor=NavyBlue,
                filecolor=NavyBlue,
                linkcolor=NavyBlue,
                urlcolor=NavyBlue,
                breaklinks,
                hidelinks,
                bookmarksopen=true,
            }%
        }
    \fi
\fi

% ==============================================================================
% Headers
% ==============================================================================

% \titleformat{command}[shape]{format}{label}{sep}{before}[after]
\titleformat{\chapter}[display]{\bfseries\Large}{\hfill CHAPTER\ \thechapter}{0.5ex}{} % before-code[\vspace{-0.5ex}\rule{\textwidth}{0.3pt}]
\titleformat{\section}{\normalfont\large\bfseries}{\thesection}{1em}{}{}
\titleformat{\subsection}{\normalfont\normalsize\bfseries}{\thesubsection}{1em}{}{}
\titleformat{\paragraph}[runin]{\normalfont\normalsize\bfseries}{}{}{}[.]

% spacing {left}{top}{bottom}, of:
\titlespacing{\section}{0pt}{1eM}{0.8em}
\titlespacing{\subsection}{0pt}{0.8em}{0.4em}
\titlespacing{\paragraph}{0pt}{0.8em}{1em}

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

% sub-figures

\renewcommand\thesubfigure{(\alph{subfigure})}

% equations: per chapter (without chapter number)

\if@eqreflocal
    \renewcommand\theequation{\arabic{equation}}
\fi

% appendix: per chapter

\pretocmd{\chapter}{\renewcommand\thesection{\thechapter.
        \arabic{section}}}{}{}

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
% Abstract and reference information
% ==============================================================================

\newenvironment{abstract}{\section*{Abstract}\noindent\ignorespaces}{\ignorespacesafterend}
\newenvironment{remark}{\vfill\noindent\itshape\ignorespaces}{\normalfont\ignorespacesafterend}
\renewenvironment{frontmatter}{\noindent\vfill\ignorespaces}{\normalfont\ignorespacesafterend\clearpage}

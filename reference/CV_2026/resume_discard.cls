\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2014/08/16 Resume class]

\LoadClass[12pt,a4paper]{article}

% Font: times or biolinum
% \usepackage{times}
\RequirePackage[sfdefault,lf]{libertine}
\renewcommand{\familydefault}{\sfdefault}

\usepackage{enumitem}
\usepackage[top=0.63cm,bottom=0.63cm,right=1.1cm,left=1.1cm]{geometry}

\setlength{\parindent}{0em}
\setlist{nosep,left=0em,labelindent=5pt,labelwidth=1.25em}

\newcommand{\@name}[1]{Your Name}
\newcommand{\name}[1]{\renewcommand{\@name}{#1}}
\def \makename {\huge\textbf\@name}

\newcommand*\@contacts{}
\newcommand*\contact[1]{
    \ifx\features\empty {\def\features{\par#1}}
    \else {\g@addto@macro\@contacts{\par#1}} % append \contact to \@contacts
    \fi
}
\def \makecontact{\llap{\parbox{\textwidth}{\footnotesize\raggedleft\@contacts}}}

\def \makeheader {\makebox[\textwidth]{\hfill\makename\hfill\makecontact}}

\newenvironment{ResumeSection}[1]{
    \MakeUppercase{\bf #1}
    \smallskip\hrule\medskip
}{
    \bigskip
}

% \define@key{subsection}{org}{\def\subsection@org{#1}}
% \define@key{subsection}{location}{\def\subsection@location{#1}}
% \define@key{subsection}{position}{\def\subsection@position{#1}}
% \define@key{subsection}{duration}{\def\subsection@duration{#1}}
% \newenvironment{ResumeSubsection}[1]{
%     \setkeys{subsection}{org=,location=,position=,duration=}
%     \setkeys{subsection}{#1}
%     \smallskip
%     \par\textbf\subsection@org\hfill\subsection@location
%     \ifx\subsection@position\empty {}
%     \else {\par{\em\subsection@position}\hfill{\em\subsection@duration}}
%     \fi
% }{
%     \bigskip
% }

\define@key{subsection}{org}{\def\subsection@org{#1}}
\define@key{subsection}{location}{\def\subsection@location{#1}}
\define@key{subsection}{position}{\def\subsection@position{#1}}
\define@key{subsection}{duration}{\def\subsection@duration{#1}}
\newenvironment{ResumeSubsection}[1]{
    \setkeys{subsection}{org=,location=,position=,duration=}
    \setkeys{subsection}{#1}
    \smallskip
    % CHANGED: add \noindent and end the line with \par so \hfill flushes right
    \par\noindent\textbf\subsection@org\hfill\subsection@location\par
    \ifx\subsection@position\empty {}
    \else
      % CHANGED: same here — add \noindent and end the line with \par
      {\par\noindent{\em\subsection@position}\hfill{\em\subsection@duration}\par}
    \fi
}{
    \bigskip
}









% % ==== Publications module ====
% % Usage in your .tex:
% % \begin{ResumePublications}  % or \begin{ResumePublications}[Publications]
% %   \publication{Paper Title}{Author A, Author B}{Venue / Press}{2025}
% %   \publication{Another Title}{Author A}{Journal of X}{2024}
% % \end{ResumePublications}

% % Optional numbering: call \numberpublications in the preamble to show [1], [2], ...
% \newcounter{pubctr}
% \newif\ifpubnumbered
% \pubnumberedfalse
% \newcommand{\numberpublications}{\pubnumberedtrue}

% % Convenience section wrapper (defaults to "Publications")
% \newenvironment{ResumePublications}[1][Publications]{%
%   \begin{ResumeSection}{#1}%
%   \setlength{\parskip}{2pt}%
% }{%
%   \end{ResumeSection}%
% }

% % Core entry macro:
% %   #1 = Title
% %   #2 = Author(s)
% %   #3 = Press / Venue
% %   #4 = Year (shown at right end of title line)
% \newcommand{\publication}[4]{%
%   \par\noindent
%   \ifpubnumbered
%     \stepcounter{pubctr}%
%     \makebox[0pt][l]{[\arabic{pubctr}]\quad}%
%   \fi
%   % Title with year right-aligned
%   \makebox[\textwidth][s]{\textbf{#1}\hfill{\footnotesize #4}}%
%   \par
%   % Authors and press line
%   {\em #2}%
%   \begingroup
%     \edef\@press{#3}%
%     \if\relax\detokenize{\@press}\relax
%       % empty press, do nothing
%     \else
%       \,---\,{\small #3}%
%     \fi
%   \endgroup
%   \par\smallskip
% }
% % ==== End publications module ====


% % ==== Publications Module (left-aligned text, year at right end) ====
% % Usage:
% % \begin{ResumePublications}
% %   \publication{Paper Title}{Author A, Author B}{Journal / Press}{2025}
% % \end{ResumePublications}

% \newenvironment{ResumePublications}[1][Publications]{%
%   \begin{ResumeSection}{#1}%
%   \setlength{\parskip}{4pt}%
% }{%
%   \end{ResumeSection}%
% }

% % Publication entry: Title, Author, Press (all left) and Year (right)
% \newcommand{\publication}[4]{%
%   % Title and year
%   \noindent\makebox[\textwidth][s]{\textbf{#1}\hfill{\small #4}}\\[-1pt]
%   % Author and press, all left-aligned
%   {\em #2}\\[-2pt]
%   {\small #3}\par
% }
% % ==== End Publications Module ====


% ==== Publications (aligned with original style) ====
% Usage in .tex:
% \begin{ResumePublications}           % or \begin{ResumePublications}[Selected Publications]
%   \publication{Title}{Author A, Author B}{Press / Journal}{2025}
%   \publication{Another Title}{Author A}{Venue}{2024}
% \end{ResumePublications}

% Section wrapper: identical look to other sections
\newenvironment{ResumePublications}[1][Publications]{%
    \begin{ResumeSection}{#1}%
    % keep original paragraph and line spacing style (no parskip changes)
}{%
    \end{ResumeSection}%
}

% Single publication entry:
%   #1 Title      (left)   ………   #4 Year (right)
%   #2 Authors    (left, italic like ResumeSubsection position line)
%   #3 Press/Venue(left)
\newcommand{\publication}[4]{%
    % Title + year line (bold title, year flushed right)
    \vspace{3pt}
    \par {#1}\hfill #4%
    % Authors line (italic, like original subsection's style)
    \par{\em #2}%
    % Press / venue line (normal text)
    \par #3%
    \medskip % light vertical rhythm between entries (uses your class's skip tokens)
}
% ==== End Publications ====

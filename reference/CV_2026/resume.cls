\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2014/08/16 Resume class]

\LoadClass[12pt,a4paper]{article}

\usepackage{xparse}
\usepackage{enumitem}
\usepackage[top=0.63cm,bottom=0.63cm,right=1.1cm,left=1.1cm]{geometry}


% Font: times or biolinum
% \usepackage{times}
\RequirePackage[sfdefault,lf]{libertine}
\renewcommand{\familydefault}{\sfdefault}
% --- Font operators: Biolinum (default) ↔ Libertine (serif) ---
% Inline switch to Linux Libertine for its argument
\newcommand{\Libertine}[1]{{\libertine\rmfamily #1}}
% (Optional) inline switch back to Linux Biolinum for its argument
\newcommand{\Biolinum}[1]{{\biolinum\sffamily #1}}
% (Optional) environment for a whole block in Libertine
\newenvironment{LibertineEnv}{\begingroup\libertine\rmfamily}{\endgroup}

% This is in Biolinum by default, but \Libertine{this part is Linux Libertine}.
% \begin{LibertineEnv}
% This whole paragraph is Linux Libertine.
% \end{LibertineEnv}

% --- Force itemize text to use Linux Libertine (serif) ---
% \let\olditemize\itemize
% \let\endolditemize\enditemize
% \renewenvironment{itemize}
%   {\olditemize\libertine\rmfamily}  % switch to serif inside
%   {\endolditemize}
  
% \begin{itemize}
%   \item This will be in Linux Libertine
% \end{itemize}
% \begin{itemize}
%   \sffamily % back to Biolinum
%   \item This one uses Biolinum again
% \end{itemize}

% End font

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
% \newcommand{\publication}[4]{%
%     % Title + year line (bold title, year flushed right)
%     \vspace{3pt}
%     \par {#1}\hfill #4%
%     % Authors line (italic, like original subsection's style)
%     \par{\em #2}%
%     % Press / venue line (normal text)
%     \par #3%
%     \medskip % light vertical rhythm between entries (uses your class's skip tokens)
% }
\NewDocumentCommand{\publication}{mmmm o}{%
    \vspace{3pt}
    \par #1 \hfill #4%
    \par{\em #2}%
    \par #3%
    
    % optional note
    \IfValueT{#5}{%
        \par{\small #5}%
    }
    
    \medskip
}
% ==== End Publications ====

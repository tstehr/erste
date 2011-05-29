%%
%% Dokumentenklasse f�r das Standard-Layout der n-ten
%%
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{n-te}[2003/04/16 Standard-Layout n-te]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[a4paper,twoside]{article}

%% parskip.sty erzeugt "deutsche" Absatzform - keine Einr�ckung, daf�r Abstand
%% Abstand nochmal nachjustieren
%%
\RequirePackage{parskip}
\setlength\parskip{1.5ex plus1ex minus.2ex}

%% Seiteneinrichtung mit geometry.sty
%%
\RequirePackage{geometry}
\geometry{a4paper,left=20mm,right=20mm,top=25mm,bottom=20mm}

%% Weitere Packages
%% Palatino als Standard-Serifenschrift einbinden
%% Neue deutsche Rechtschreibung (Silbentrennung) als Package einbinden
%% Makro-Package einbinden (darf erst *nach* ngerman.sty eingebunden werden!)
%%
\RequirePackage{mathpazo,ngerman,n-te}

%% Abstand zwischen Spalten auf 8mm setzen
%%
\setlength\columnsep{8mm}

%% Z�hler setzen
%%
%% Gliederungen numerieren bis 0 (auch nicht section)
%% Gliederungen in Inhaltsverzeichnis bis 1 (nur section)
%%
\setcounter{secnumdepth}{0}
\setcounter{tocdepth}{2}

%% Befehl �berschreiben: section
%% 
%% Formatierung: Zentriert, Gr��er (Large), Fett
%%
\renewcommand\section{%
	\@startsection{section}{1}%         Gliederungsebene und �berschriftstext
		{0pt}%                          Einr�ckung der �berschrift
		{-1.5ex plus-1ex minus-.2ex}%   Abstand vor �berschrift
		{2.3ex plus.2ex}%               Abstand nach �berschrift
		{\LARGE\bfseries\centering}%    Formatierung �berschrift
	%\setcounter\footnote{0}%            Fu�note in jedem Abschnitt mit 1 beginnen
}

%% Befehl �berschreiben: subsection
%%
%% Formatierung: Gro� (large), Fett
%%
\renewcommand\subsection{%
	\@startsection{subsection}{1}%
		{15pt}%                         Einr�ckung der �berschrift
		{-1ex plus-1ex minus-0.2ex}%    Abstand vor �berschrift
		{1ex plus0.2ex}%                Abstand nach �berschrift
		{\large\bfseries}%              Formatierung �berschrift
}

%% Befehl �berschreiben: subsubsection
%%
%% Formatierung: Fett
%%
\renewcommand\subsubsection{%
	\@startsection{subsubsection}{1}%
		{0pt}                           %%
		{0ex plus-0.5ex minus-0.1ex}    %% Abstand vor = 0 bedeutet Standardabstand
		{0.05ex plus0.2ex}              %% Abstand nach �berschrift darf nicht 0 sein!
		{\bfseries}                     %%
}

%% Seitenstil setzen: myheadings
%%
%% Schreibt Seitenzahlen an die Au�en- und die Kopfzeilentexte an die Innenkante
%% Kopfzeilentext setzen mit ntecount oder manuell mit markboth
%%
\pagestyle{myheadings}

%% Neue Umgebung: nimpressum
%%
%%
%%
\newenvironment{nimpressum}{%
	%% sehr unsch�n, aber zum Ausgleich gegen�ber tableofcontents notwendig
	\raisebox{-1mm}{%
		\Large\bfseries\nimpressumname
	}
	\vspace{2.1ex plus.2ex}%            Abstand nach �berschrift einf�gen
	\list{}{%
		\labelwidth\nimpressumsep%
		\leftmargin\labelwidth%
		\labelsep\z@%
		\itemindent\z@%
		\let\makelabel\nimpressumlabel}%
	}%
	{\endlist}
\newlength\nimpressumsep
\setlength\nimpressumsep{40mm}
\newcommand\nimpressumname{Impressum}
\newcommand*\nimpressumlabel[1]{\normalfont\bfseries #1}

%% Neue Umgebung: neditorial
%%
%% �berschreibt die Umgebung mit Editorial und setzt den Text zentriert
%% in einer Spalte.
%%
%% 1 [optional] Breite des einspaltigen Textes
%%
\newenvironment{neditorial}[1][100mm]%
	{\onecolumn\centering\begin{minipage}{#1}%
	%% normale Absatzabst�nde herstellen - macht LaTeX nicht automatisch :-(
		\setlength\parskip{1.5ex plus1ex minus.2ex}%
		\section{\neditorialname}}%
	{\end{minipage}\twocolumn}
\newcommand\neditorialname{Editorial}

\endinput
%%
%% end of file `n-te.cls'

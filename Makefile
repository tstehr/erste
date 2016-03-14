# make Datei fuer LaTeX
# Time-stamp: <2009-02-14 11:57:27 ewi>
# Aufruf: make macht das, was hinter all: steht, bei Bedarf anpassen.
#         make psA5 macht eine ps-Ausgabe in Din A5 Format.
#         make clean loescht alles, was neu erzeugt werden kann.
#         make view zeigt die dvi-Version auf dem Monitor an.
# ganz wichtig: die Befehlszeilen muessen mit einem TAB beginnen!!!


LATEXVIEW = xdvi
PDFVIEW = xpdf
LATEX = pdflatex --synctex=1
#open "/Volumes/Mac OS X/Applications/Preview.app" 

all: 1te

1te: 1-te.pdf
	$(LATEX) 1-te.tex

1-te.pdf: 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
#	$(PDFVIEW) ${MAINFILE}.pdf

clean: distclean
	rm -f 1-te.{dvi,ps,pdf}	

distclean:
	rm -f *.{aux,log,toc,out}
	rm -f *~

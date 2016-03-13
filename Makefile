# make Datei fuer LaTeX
# Time-stamp: <2009-02-14 11:57:27 ewi>
# Aufruf: make macht das, was hinter all: steht, bei Bedarf anpassen.
#         make psA5 macht eine ps-Ausgabe in Din A5 Format.
#         make clean loescht alles, was neu erzeugt werden kann.
#         make view zeigt die dvi-Version auf dem Monitor an.
# ganz wichtig: die Befehlszeilen muessen mit einem TAB beginnen!!!


LATEXVIEW = xdvi
PDFVIEW = xpdf
#open "/Volumes/Mac OS X/Applications/Preview.app" 

all: ws ss

ws: 1-te_ws.pdf
	pdflatex 1-te_ws.tex

1-te_ws.pdf: 1-te_ws.tex
	pdflatex 1-te_ws.tex
	#bibtex 1-te_ws.aux
	pdflatex 1-te_ws.tex
#	$(PDFVIEW) ${MAINFILE}.pdf

ss: 1-te_ss.pdf
	pdflatex 1-te_ss.tex
	#bibtex 1-te_ss.aux
	pdflatex 1-te_ss.tex

1-te_ss.pdf: 1-te_ss.tex
	pdflatex 1-te_ss.tex

cleanss: distclean
	rm -f 1-te_ss.{dvi,ps,pdf}	

cleanws: distclean
	rm -f 1-te_ws.{dvi,ps,pdf}	

distclean:
	rm -f *.{aux,log,toc,out}
	rm -f *~

# make Datei fuer LaTeX
# Time-stamp: <2009-02-14 11:57:27 ewi>
# Aufruf: make macht das, was hinter all: steht, bei Bedarf anpassen.
#         make psA5 macht eine ps-Ausgabe in Din A5 Format.
#         make clean loescht alles, was neu erzeugt werden kann.
#         make view zeigt die dvi-Version auf dem Monitor an.
# ganz wichtig: die Befehlszeilen muessen mit einem TAB beginnen!!!

MAINFILE = 1-te_v2
LATEXVIEW = xdvi
PDFVIEW = xpdf
#open "/Volumes/Mac OS X/Applications/Preview.app" 

all: ${MAINFILE}.pdf
#	pdflatex ${MAINFILE}.tex
#	bibtex ${MAINFILE}.aux
#	pdflatex ${MAINFILE}.tex
	$(PDFVIEW) ${MAINFILE}.pdf


pdf: ${MAINFILE}.tex
	pdflatex ${MAINFILE}.tex
#	bibtex ${MAINFILE}.aux
	pdflatex ${MAINFILE}.tex

psA5: ${MAINFILE}.dvi
	dvips -o ${MAINFILE}.ps ${MAINFILE}.dvi
	psnup -2 ${MAINFILE}.ps > ${MAINFILE}A5.ps
	rm ${MAINFILE}.ps

view: ${MAINFILE}.dvi
	${LATEXVIEW} ${MAINFILE}.dvi

tgz: distclean
	cd ..; tgz ${MAINFILE}.tgz ${MAINFILE}; \
        mv ${MAINFILE}.tgz ${MAINFILE}

dvi: ${MAINFILE}.tex 
	latex ${MAINFILE}.tex
	latex ${MAINFILE}.tex

clean: distclean
	rm -f $(MAINFILE).{dvi,ps,pdf}	
distclean:
	rm -f *.{aux,log,toc,out}
	rm -f *~

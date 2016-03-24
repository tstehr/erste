# make Datei fuer LaTeX
# Time-stamp: <2009-02-14 11:57:27 ewi>
# Aufruf: make macht das, was hinter all: steht, bei Bedarf anpassen.
#         make all Erzeugt das blanke pdf aus den tex-files
#         make release Erzeugt pdfs mit cover fertig für druck/online-release
#         make clean loescht alles, was neu erzeugt werden kann.
# ganz wichtig: die Befehlszeilen muessen mit einem TAB beginnen!!!


LATEXVIEW = xdvi
PDFVIEW = xpdf
LATEX = pdflatex --synctex=1
#open "/Volumes/Mac OS X/Applications/Preview.app" 

all: clean 1-te.pdf

release: clean 1-te.pdf 1-te_online.pdf 1-te_booklet.pdf

1-te_online.pdf: 1-te.pdf
	pdfjam --outfile 1-te_online.pdf bilder/Erste_Cover/vorne.pdf 1-te.pdf bilder/Erste_Cover/hinten.pdf

1-te_booklet.pdf: 1-te.pdf
	pdfbook --outfile 1-te_booklet_coverless.pdf 1-te.pdf
	pdfjam --outfile 1-te_booklet.pdf bilder/Erste_Cover/cover.pdf 1-te_booklet_coverless.pdf

1-te.pdf: 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
#	$(PDFVIEW) ${MAINFILE}.pdf


clean: distclean
	rm -f 1-te*.{dvi,ps,pdf}	

distclean:
	rm -f *.{aux,log,toc,out}
	rm -f *~

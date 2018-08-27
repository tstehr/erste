# make Datei fuer LaTeX
# Time-stamp: <2009-02-14 11:57:27 ewi>
# Aufruf: make macht das, was hinter all: steht, bei Bedarf anpassen.
#         make all Erzeugt das blanke pdf aus den tex-files
#         make release Erzeugt pdfs mit cover fertig für druck/online-release
#         make clean loescht alles, was neu erzeugt werden kann.
# ganz wichtig: die Befehlszeilen muessen mit einem TAB beginnen!!!


LATEX = pdflatex --synctex=1

# Find all dependencies (this is overly broad but works)
IMAGES = $(shell find bilder | sed 's/ /\\ /g')
HEADER = $(shell find header -type f -name '*.tex' | sed 's/ /\\ /g')
TEXTE = $(shell find texte -type f -name '*.tex' | sed 's/ /\\ /g')
GENERATED_LATEX = texte/nuetzliches/lernraeume_iz.tex texte/nuetzliches/lernraeume_andere.tex

# default: 1-te.pdf
default: infofoo.pdf

all: release infofoo.pdf

release: 1-te.pdf 1-te_booklet.pdf

1-te_booklet.pdf: 1-te-release
	pdfbook --outfile 1-te_booklet.pdf 1-te.pdf

1-te-release: 1-te.pdf
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex

1-te.pdf: $(IMAGES) $(HEADER) $(TEXTE) $(GENERATED_LATEX) 1-te.tex
	$(LATEX) 1-te.tex

infofoo.pdf: $(HEADER) texte/stundenplan.tex infofoo.tex
	$(LATEX) infofoo.tex

%.tex: %.dokuwiki
	scripts/dokuwiki_table_to_tex.sh $^ $@

clean: distclean
	rm -f 1-te.{dvi,ps,pdf}

distclean:
	rm -rf build
	rm -f *.{aux,log,toc,out,tdo,synctex.gz}
	rm -f *~
	rm -f $(GENERATED_LATEX)

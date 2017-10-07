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
DEPS = $(shell find header texte -type f -name '*.tex' | sed 's/ /\\ /g') 1-te.tex
GENERATED_LATEX = texte/nuetzliches/lernraeume_iz.tex texte/nuetzliches/lernraeume_andere.tex

all: 1-te.pdf

release: 1-te.pdf 1-te_online.pdf 1-te_booklet.pdf

1-te_online.pdf: 1-te.pdf
	pdfjam --outfile 1-te_online.pdf bilder/Erste_Cover/vorne.pdf 1-te.pdf bilder/Erste_Cover/hinten.pdf

1-te_booklet.pdf: 1-te.pdf build/cover_rotated.pdf build
	pdfjam --outfile build/1-te_pad.pdf 1-te.pdf '{},-,{}'
	pdfbook --outfile build/1-te_booklet_emptycover.pdf build/1-te_pad.pdf
	pdfjam --landscape --outfile 1-te_booklet.pdf build/cover_rotated.pdf '-' build/1-te_booklet_emptycover.pdf '2-last'

1-te.pdf: $(IMAGES) $(DEPS) $(GENERATED_LATEX) 
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex

build/cover_rotated.pdf: build bilder/Erste_Cover/cover.pdf
	pdf180 --outfile $@ bilder/Erste_Cover/cover.pdf

build:
	mkdir build

%.tex: %.dokuwiki
	scripts/dokuwiki_table_to_tex.sh $^ $@

clean: distclean
	rm -f 1-te.{dvi,ps,pdf}

distclean:
	rm -rf build
	rm -f *.{aux,log,toc,out,tdo,synctex.gz}
	rm -f *~
	rm -f $(GENERATED_LATEX)

LATEX = pdflatex --synctex=1 -interaction=nonstopmode -halt-on-error

# Find all dependencies (this is overly broad but works)
IMAGES = $(shell find bilder | sed 's/ /\\ /g')
HEADER = $(shell find header -type f -name '*.tex' | sed 's/ /\\ /g')
TEXTE = $(shell find texte -type f -name '*.tex' | sed 's/ /\\ /g')
STUNDENPLAN = $(shell find texte/stundenplan | sed 's/ /\\ /g')

GENERATED_LATEX = texte/nuetzliches/lernraeume_iz.tex texte/nuetzliches/lernraeume_andere.tex

default: infofoo.pdf 1-te.pdf stundenplan1.png stundenplan2.png

release: default 1-te_booklet.pdf infofoo-release

1-te_booklet.pdf: 1-te-release
	pdfbook --outfile 1-te_booklet.pdf 1-te.pdf

# runs latex multiple times, to be sure all indexes are up to date
1-te-release: 1-te.pdf
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex
	$(LATEX) 1-te.tex

1-te.pdf: $(IMAGES) $(HEADER) $(TEXTE) $(GENERATED_LATEX) 1-te.tex
	$(LATEX) 1-te.tex

# runs latex multiple times, to be sure all indexes are up to date
infofoo-release: infofoo.pdf
	$(LATEX) infofoo.tex	
	$(LATEX) infofoo.tex

infofoo.pdf: $(HEADER) bilder/fg-logo/fg-logo.pdf $(STUNDENPLAN) infofoo.tex
	$(LATEX) infofoo.tex

stundenplan%.png: $(HEADER) stundenplan.tex texte/stundenplan/woche%.tex
	$(LATEX) -jobname=stundenplan$* "\newcommand{\woche}{$*} \input{stundenplan.tex}"
	convert -density 300 stundenplan$*.pdf stundenplan$*.png

%.tex: %.dokuwiki
	scripts/dokuwiki_table_to_tex.sh $^ $@

clean:
	git clean -fdX

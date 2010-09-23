TEXTE_ERSTETAGE=texte/erstetage/sonstiges.tex texte/erstetage/index.tex texte/erstetage/termine.tex texte/erstetage/ersticheckliste.tex texte/erstetage/tutoren.tex

TEXTE_COMPUTER=texte/computer/links.tex texte/computer/index.tex texte/computer/msdnaa.tex texte/computer/linux.tex texte/computer/gitz.tex texte/computer/computer.tex

TEXTE_POLITIK=texte/politik/index.tex texte/politik/gremien.tex texte/politik/gremien2.tex texte/politik/unpolitisch.tex texte/politik/fachgruppe.tex texte/politik/studiengebuehren.tex

TEXTE_STUDIENPLAN=texte/studienplan/index.tex texte/studienplan/begriffe.tex texte/studienplan/bpo.tex

TEXTE_MASTER=texte/master/index.tex

TEXTE_MENSCHEN=texte/menschen/computersuechtig.tex texte/menschen/index.tex texte/menschen/interview.tex

TEXTE_FREIZEIT=texte/freizeit/index.tex texte/freizeit/tagebuch.tex texte/freizeit/locations.tex 

TEXTE_BACHELOR=texte/bachelor/index.tex texte/bachelor/stundenplan.tex texte/bachelor/studienplan.tex texte/bachelor/profs.tex

TEXTE_NUETZLICHES=texte/nuetzliches/index.tex texte/nuetzliches/semesterticket.tex

TEXTE=texte/impressum.tex texte/titelblatt.tex texte/vorwort.tex ${TEXTE_ERSTETAGE} ${TEXTE_COMPUTER} ${TEXTE_POLITIK} ${TEXTE_STUDIENPLAN} ${TEXTE_MASTER} ${TEXTE_MENSCHEN} ${TEXTE_FREIZEIT} ${TEXTE_BACHELOR} ${TEXTE_NUETZLICHES}

BILDER=bilder/gremienkunde2.png

MINI=mini.tex

ALL: 1-te.pdf mini.pdf

bilder/gremienkunde2.svg: bilder/gremienkunde2.dia
	dia -t svg -e bilder/gremienkunde2.svg bilder/gremienkunde2.dia

bilder/gremienkunde2.png: bilder/gremienkunde2.svg
	convert bilder/gremienkunde2.svg bilder/gremienkunde2.png

mini.pdf:  ${MINI}
	pdflatex mini.tex
	pdflatex mini.tex > /dev/null
	pdflatex mini.tex >/dev/null


1-te.pdf: 1-te.tex ${TEXTE} ${BILDER}
	pdflatex 1-te.tex
	pdflatex 1-te.tex > /dev/null
	pdflatex 1-te.tex > /dev/null

1-te.dvi: 1-te.tex ${TEXTE} ${BILDER}
	latex 1-te.tex
	latex 1-te.tex > /dev/null
	latex 1-te.tex > /dev/null

1-te_A4.pdf: 1-te.pdf
	pdftops -level3 1-te.pdf -paper A4
	psresize -pa5 1-te.ps 1-te_A5.ps
	psbook 1-te_A5.ps 1-te_Reordered_A5.ps
	psnup -2 -s1 -Pa5 -pa4 1-te_Reordered_A5.ps 1-te_A4.ps
	ps2pdf 1-te_A4.ps

clean: 
	rm -f 1-te.pdf
	rm -f 1-te.dvi
	rm -f 1-te.aux
	rm -f 1-te.out
	rm -f 1-te.log
	rm -f 1-te.toc
	rm -rf texte/*aux
	rm -rf texte/*/*aux
	rm -f *.html
	rm -rf mini.aux
	rm -rf mini.pdf
	rm -rf mini.log
	rm -rf mini.out

TEXTE=texte/termine.tex texte/gruppen.tex texte/studienplan.tex texte/menschen.tex texte/erstitodo.tex texte/computer.tex texte/freizeit.tex texte/nuetzliches.tex ${TEXTE_GRUPPEN} ${TEXTE_COMPUTER} ${TEXTE_MENSCHEN}

TEXTE_GRUPPEN=texte/gruppen/gremien2.tex texte/gruppen/fachgruppe.tex texte/gruppen/tutoren.tex

TEXTE_COMPUTER=texte/computer/links.tex texte/computer/computer.tex

TEXTE_MENSCHEN=texte/menschen/profs.tex texte/menschen/interview.tex

BILDER=bilder/gremienkunde2.png

ALL: 1-te.pdf

bilder/gremienkunde2.svg: bilder/gremienkunde2.dia
	dia -t svg -e bilder/gremienkunde2.svg bilder/gremienkunde2.dia

bilder/gremienkunde2.png: bilder/gremienkunde2.svg
	convert bilder/gremienkunde2.svg bilder/gremienkunde2.png

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
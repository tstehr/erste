rm -r htmlout
mkdir -p htmlout/bilder

# We need to have converted jpg's in our input before we can convert it
for i in `find bilder -iname "*.pdf"`; do convert -density 150 "$i" ${i%.pdf}.png; done
# The script also needs an EPS version, god knows why
for i in `find bilder -iname "*.pdf"`; do convert -density 150 "$i" ${i%.pdf}.eps; done

# or: for i in *.pdfjpg; do mv $i ${i%.pdfjpg}.jpg; done


# The htlatex script is some nasty garbage, so we need to work arround some limitations
htlatex 1-te.tex "xhtml,2" "" "-dhtmlout/"

# The above script puts some images into the directory root, so we delete them
rm -f *.html
rm -f htmlout/*.png
rm -f htmlout/*.jp*g
rm -f htmlout/*.pdf
rm -f htmlout/*.dia
rm -f htmlout/*.svg
rm -f htmlout/*.xcf
rm -f htmlout/*.tif*

# Next we copy the images to where they really belong, but remove those that we do not want
cp -r bilder htmlout/

find ./htmlout/ -depth -name "*.pdf" -or -name "*.dia" -or -name "*.svg" -or -name "*.xcf" -or -name "*.tif*"  -or -name "*.eps" | xargs rm -f

# We can assume that there is some stupid file that contains "</td></tr></table>" even though it should not. Filter that.
# (and only one month later, I have no idea of what was the original problem with that...)
sed -e 's/<\/td><\/tr><\/table>//' htmlout/1-teli1.html > htmlout/1-teli1.html.tmp
mv htmlout/1-teli1.html.tmp htmlout/1-teli1.html

# Now apply an XSLT-Transformation to the file to strip away unwanted parts. This also converts ISO to UTF-8 on the fly.

for file in $( find htmlout/ -name '*.html' )
do
  echo $file
  # xsltproc insists on printing the xml-declatation even when it is disabled, it also insists on converting to UTF-8 without being asked to AND to write into the output that the encoding is ISO-8859-1, so we may conclude that xsltproc SUCKS
  # echo xsltproc --html --novalid -o $file.trans scrap.xslt $file
  # xsltproc --html --novalid -o $file.trans scrap.xslt $file

  # xmlstarlet does not suck as hard, but it does suck. But we can take away the xml-declaration rather easily:
  xmlstarlet tr --html scrap.xslt $file | sed -e 's/<?/<!--/' -e 's/?>/-->/' > $file.trans
  mv $file.trans $file

  #if there were any utf-8 problems, this might solve them, but for some reason the XSLT already does it
  #iconv -f ISO-8859-1 -t UTF-8 -o $file $file.trans
done

# Now scale down all pictures for html display. The pics for the pdf might have widhts up to 650 or even 1400 pixels, for the web page, we need to stay below 520 pixels.

for file in $( find ./htmlout/bilder/ -name '*.png' -or -name '*.jp*g' )
do
  convert "$file" -resize "520>" "$file"
done

# Now delete the svn meta data in the htmlout directory

find ./htmlout/ -depth -name ".svn" | xargs rm -r

# Now we should have a valid webpage in the htmlout directory, so we zip it

rm -f erste.zip

zip -r erste.zip htmlout

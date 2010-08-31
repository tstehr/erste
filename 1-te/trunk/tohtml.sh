mkdir htmlout
mkdir htmlout/bilder

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

find ./htmlout/ -depth -name "*.pdf" -or -name "*.dia" -or -name "*.svg" -or -name "*.xcf" -or -name "*.tif*" | xargs rm -f

# Now change the encoding from ISO to UTF-8

for file in $( find htmlout/ -name '*.html' )
do
  echo $file
  echo xsltproc --html --novalid -o $file.trans scrap.xslt $file
  xsltproc --html --novalid -o $file.trans scrap.xslt $file
  mv $file.trans $file

  #if there were any utf-8 problems, this might solve them
  #iconv -f ISO-8859-1 -t UTF-8 -o $file $file.trans
done

# Now scale down all pictures for html display. The pics for the pdf might have widhts up to 650 or even 1400 pixels, for the web page, we need to stay below 520 pixels.

for file in $( find ./htmlout/bilder/ -name '*.png' -or -name '*.jpg' )
do
  convert "$file" -resize "520>" "$file"
done

# Now delete the svn meta data in the htmlout directory

find ./htmlout/ -depth -name ".svn" | xargs rm -r

# Now we should have a valid webpage in the htmlout directory, so we zip it

zip -r erste.zip htmlout


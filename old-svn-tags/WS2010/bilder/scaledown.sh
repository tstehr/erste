# resize SOME pictures to max. 650 pixels width. Then resize ALL that are larger than 1400 pixels.

for file in $( find ./dozenten/ -name '*.png' -or -name '*.jpg' )
do
  convert "$file" -resize "650>" "$file"
done

for file in $( find ./tutoren/ -name '*.png' -or -name '*.jpg' )
do
  convert "$file" -resize "650>" "$file"
done

for file in $( find . -name '*.png' -or -name '*.jpg' )
do
  convert "$file" -resize "1400>" "$file"
done

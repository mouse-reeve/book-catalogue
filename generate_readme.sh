echo "book-catalogue
==============

A list of the books I own.

The \`librarything\` JSON is an export from my [LibraryThing](https://www.librarything.com/catalog/tripofmice) catalogue, which represents the canonical list of books I own.

The \`goodreads\` CSV is an export of my GoodReads data, which stores the date I started a book and the date I finished it.

This data can be merged, along with with [scraped LibraryThing data](https://github.com/mouse-reeve/book-scraper), in the [book-merger](https://github.com/mouse-reeve/book-merger) repository.

## Stats

### Books read so far this year:
$( tail -n +2 goodreads.csv | grep ',read,' | grep ",`date +'%Y'`" | wc -l )

### Books owned:
$(jq '. | length' librarything.json)

### Sum weight of books (incomplete):
$( jq '.[].weight | select (.)' librarything.json | sed -E 's/[^0-9]*([0-9.]+).*/\1/' | paste -sd+ - | bc ) pounds

### Total pages:
$( jq '.[].pages | select (.)' librarything.json | sed -E 's/[^0-9]*([0-9]+).*/\1/' | paste -sd+ - | bc | sed -E 's/([0-9]{3})([0-9]{3})/\1,\2/' )
" > README.md

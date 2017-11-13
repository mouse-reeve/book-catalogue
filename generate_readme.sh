echo "book-catalogue
==============

A list of the books I own.

The \`librarything\` JSON is an export from my [LibraryThing](https://www.librarything.com/catalog/tripofmice) catalogue, which now represents the canonical list of books I own (taking over from the now defunct \`canonical.csv\`).

The \`goodreads\` CSV is an export of my GoodReads data, which is the only place that stores the date I started a book and the date I finished it.

This data is merged, along with with [scraped LibraryThing data](https://github.com/mouse-reeve/book-scraper), in the [book-merger](https://github.com/mouse-reeve/book-merger) repository.

## Stats
### Number of books:
$(jq '. | length' librarything.json)

### Genres:
$(jq '.[].genre | select(.) | .[]' librarything.json | sort | uniq -c | sort -r | while read line; do
    echo "- $line"
done )

### Subject:
$(jq '.[].subject' librarything.json | tr '[:upper:]' '[:lower:]' | grep '^\s*"[a-z\s]*"$' | sort | uniq -c | sort -r | head -15 | while read line; do
    echo "- $line"
done )

### Original language:
$( jq '.[].originallanguage | select(.) | .[]' librarything.json | sort | uniq -c | sort -r | while read line; do
    echo "- $line"
done )

### Author:
$( jq '.[].primaryauthor' librarything.json | sort | uniq -c | sort -r | head -10 | while read line; do
    echo "- $line"
done )

### Books read so far this year:
$( tail -n +2 goodreads.csv | cut -d , -f 17 | grep ^`date +'%Y'` | wc -l )


### Average Goodreads rating for books read:
$( cat goodreads.csv | sed 's/.*\([0-9]\.[0-9]\{2\}\).*/\1/g' | tail -n +2 | jq -s 'add/length' | sed 's/\([0-9]\.[0-9]\{2\}\).*/\1/g' ) / 5.00

### Sum weight of books (incomplete):
$( jq '.[].weight | select (.)' librarything.json | sed -E 's/[^0-9]*([0-9.]+).*/\1/' | paste -sd+ - | bc ) pounds

### Total pages:
$( jq '.[].pages | select (.)' librarything.json | sed -E 's/[^0-9]*([0-9]+).*/\1/' | paste -sd+ - | bc | sed -E 's/([0-9]{3})([0-9]{3})/\1,\2/' )
" > README.md

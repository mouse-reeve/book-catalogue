echo "book-catalogue
==============

A list of the books I own.

The \`librarything\` JSON is an export from my [LibraryThing](https://www.librarything.com/catalog/tripofmice) catalogue, which now represents the canonical list of books I own (taking over from the now defunct \`canonical.csv\`).

The \`goodreads\` CSV is an export of my GoodReads data, which is the only place that stores the date I started a book and the date I finished it.

This data is merged, along with with [scraped LibraryThing data](https://github.com/mouse-reeve/book-scraper), in the [book-merger](https://github.com/mouse-reeve/book-merger) repository.

## Stats
### LibraryThing grenres:
$(jq '.[].genre | select(.) | .[]' librarything.json | sort | uniq -c | sort -r | while read line; do
    echo "- $line"
done )

### Tagged types:
$(jq '.[].tags | select(.) | .[]' librarything.json | grep TYPE | sed 's/TYPE://g' | sort | uniq -c | sort -r | while read line; do
    echo "- $line"
done )

### Content tags:
$(jq '.[].tags | select(.) | .[]' librarything.json | grep -v : | sort | uniq -c | sort -r | head -20 | sort -r | while read line; do
    echo "- $line"
done )

### Original language:
$( jq '.[].originallanguage | select(.) | .[]' librarything.json | sort | uniq -c | sort -r | while read line; do
    echo "- $line"
done )

### Author:
$( jq '.[].primaryauthor' librarything.json | sort | uniq -c | sort -r | head -20 | while read line; do
    echo "- $line"
done )

### Books read so far this year:
$( tail -n +2 goodreads.csv | cut -d , -f 17 | grep ^`date +'%Y'` | wc -l )

" > README.md

echo "book-catalogue
==============

A list of the books I own.

The \`canonical\` CSV is an export from my catalogue on the android app [Book Catalogue](https://play.google.com/store/apps/details?id=com.eleybourn.bookcatalogue&hl=en)

The \`librarything\` JSON is an export from my [LibraryThing](https://www.librarything.com/catalog/tripofmice) catalogue, which stores (in theory) the same books as \`canonical\`, but with LT's data and the tags I've added through the site.

The \`goodreads\` CSV is an export of my GoodReads data, which is the only place that stores the date I started a book and the date I finished it.

This data is merged, along with with [scraped LibraryThing data](https://github.com/mouse-reeve/book-scraper), in the [book-merger](https://github.com/mouse-reeve/book-merger) repository.

## Stats
### Librarything grenres:
$(jq '.[].genre | select(.) | .[]' librarything.json | sort | uniq -c | sort -r | while read line; do
    echo "- $line"
done )
" > README.md

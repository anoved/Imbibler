Imbibler
========

This Ruby script reads the index of a Bible from [Bible Gateway](http://www.biblegateway.com/) and generates a comma-separated value (CSV) table of the Bible content in `Book,Chapter,Verse,Text` form. The name is a play on the idea that the script "imbibes" the Bible (and then, um, regurgitates it in tabular form).

This script is intended for personal reading and research purposes only. Its output should not be distributed, as doing so may constitute [copyright violation](http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/#copy).

Usage
-----

	imbibler.rb OUTPUT [INDEX]

The script expects one or two command-line arguments. The first, `OUTPUT`, will be used as the filename for the output CSV table. The second, `INDEX`, is the index URL of a Bible Gateway Bible, such as [http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/](http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/), which is the default. (In general, URLs should be quoted on the command line to avoid misinterpretation of any punctuation characters they may contain.) Links to all Bible version indices are [available here](http://www.biblegateway.com/versions/).

The script also dumps the text of each chapter to text files in the current working directory. Verse text files are titled in the pattern `BB BOOK CCC.txt`, where `BB` is the book number, `BOOK` is the book title, and `CCC` is the chapter number.

Note that the character encoding of output files is UTF-8. If given the option, select this encoding when importing output into other applications to ensure that punctuation marks and accented characters are represented correctly.

Prerequisites
-------------

Imbibler relies on [Nokogiri](http://nokogiri.org/) for easy HTML parsing. Nokogiri is not part of the Ruby standard library, but is easily installed with:

	sudo gem install nokogiri

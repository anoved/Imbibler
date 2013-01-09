Imbibler
========

This Ruby script reads the index of a Bible from [Bible Gateway](http://www.biblegateway.com/) and generates a comma-separated value (CSV) table of the Bible content in `Book,Chapter,Verse,Text` form. The name is a play on the idea that the script "imbibes" the Bible (and then, um, regurgitates it in tabular form).

This script is intended for personal reading and research purposes only. Its output should not be distributed, as doing so may constitute [copyright violation](http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/#copy).

Usage
-----

	imbibler.rb OUTPUT [INDEX]

The script expects one or two command-line arguments. The first, `OUTPUT`, will be used as the filename for the output CSV table. The second, `INDEX`, is the index URL of a Bible Gateway Bible, such as [http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/](http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/), which is the default. (In general, URLs should be quoted on the command line to avoid misinterpretation of any punctuation characters they may contain.) Links to all Bible version indices are [available here](http://www.biblegateway.com/versions/).

The script also dumps the text of each chapter to text files in the current working directory. Verse text files are titled in the pattern `BB BOOK CCC.txt`, where `BB` is the book number, `BOOK` is the book title, and `CCC` is the chapter number.

Note that the character encoding of output files is UTF-8. If given the option, select this encoding when importing Imbibler's output into other applications to ensure that punctuation marks and accented characters are represented correctly.

Prerequisites
-------------

Imbibler is a Ruby script that is run from the command line. For Mac OS X or Linux users, this means opening a Terminal window, typing `cd /path/to/script/folder` to go to the directory containing the script, and entering the commands below. Windows users can execute command line scripts using [Cygwin](http://cygwin.com), but this has not been tested (nor can I provide any help with it).

Imbibler relies on [Nokogiri](http://nokogiri.org/) for easy HTML parsing. Nokogiri is not part of the Ruby standard library, but is easily installed on Mac OS X or Linux with:

	sudo gem install nokogiri

Examples
--------

Imbibler retrieves Bible text from Bible Gateway, which provides many different versions of the Bible. By default, Imbibler retrieves the [New International Version](http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/). Here is an example command line in which the Ruby interpreter is used to run the script; we specify `niv.csv` as the name of the `OUTPUT` file. Because no Bible index URL is provided, the script will default to the New International Version.

	ruby imbibler.rb niv.csv

To retrieve a different version of the Bible, simply append the URL of the desired Bible index page to the command line. [Links to all Bible index pages are available under the *Versions* column here.](http://www.biblegateway.com/versions/) Here is an example in which the King James Version of the Bible is retrieved:

	ruby imbibler.rb kjv.csv "http://www.biblegateway.com/versions/King-James-Version-KJV-Bible/"

Note that in both cases the script also outputs the text of each chapter into plain text files as described above under **Usage**. These files will be overwritten by subsequent invocations of the script, so it is up to the user to rename them or move them to another folder before re-running the script.

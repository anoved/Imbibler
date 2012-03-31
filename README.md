Imbibler
========

This Ruby script reads the index of a Bible from [Bible Gateway](http://www.biblegateway.com/) and generates a comma-separated value (CSV) table of the Bible content in `Book,Chapter,Verse,Text` form. The name is a play on the idea that the script "imbibes" the Bible (and then, um, pukes it back up in tabular form).

Note that this script is intended for personal reading and research purposes. Its output should not be distributed, as doing so may constitute [copyright violation](http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/#copy). (Wait, wait - are these God's words, or some publisher's? Hmm?)

Usage
-----

	imbibler.rb OUTPUTFILE INDEXURL

The script expects two command-line arguments. The first, `OUTPUTFILE`, will be used as the filename for the output CSV table. The second, `INDEXURL`, is the index URL of a Bible Gateway Bible, such as [http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/](http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/). (In general, URLs should be quoted on the command line to avoid misinterpretation of any punctuation characters they may contain.) Links to all Bible version indices are [available here](http://www.biblegateway.com/versions/).

Note that the character encoding of the output file is UTF-8. If given the option, select this encoding when importing the CSV table into other applications to ensure that punctuation and accented characters are represented accurately.

Prerequisites
-------------

Imbibler relies on [Nokogiri](http://nokogiri.org/) for easy HTML parsing. Nokogiri is not part of the Ruby standard library, but is easily installed with:

	sudo gem install nokogiri

To-do
-----

- Error handling!
- Annotation handling. Footnotes and cross-references are currently discarded. Conceivably it might be desirable to embed these in the associated verse text or alternatively to save them to a separate file.
- Caching. Pages could be saved when downloaded so that subsequent runs could utilize local copies for much faster processing.
- Configurable throttle. Currently Imbibler pauses 1 second between page downloads to avoid any rate limits that may interfere with site scraping. Bible Gateway may not apply any such restraints, in which case the pause could be reduced or removed for faster processing.
- Easier interface. Imbibler currently expects the URL of a Bible Gateway Bible index page as one of its arguments. The list of indices could easily be stored within the script, allowing the user to simply specify the name, abbreviation, or some unique substring of either.

Credits
-------

Thanks to Geoffrey Dagley's [bible_gateway](https://github.com/gdagley/bible_gateway) verse-lookup code for an example of reading Bible Gateway with Ruby and Nokogiri.

#!/usr/bin/env ruby

#
# Nokogiri provides convenient HTML parsing abilities.
# install with "sudo gem install nokogiri"
# http://nokogiri.org
#
require 'nokogiri'
require 'open-uri'
require 'csv'


def ConvertChapter(book, chapter, url, csv)

	# Download and parse the chapter page
	page = Nokogiri::HTML(open(URI.escape(url)))
	
	# Find the part of the page that contains the actual bible text
	text = page.at('div.result-text-style-normal')
	
	# Look for the start of each verse in the text
	text.search('sup.versenum').each do |verse|
		
		# The content of the sup.versnum node is simply the verse number
		verseNumber = verse.content
		
		# Assemble the verse text from all the following nodes up until we run
		# into the next verse number; ignore things like footnotes and headers.
		verseText = ""		
		verseNode = verse.next_sibling
		while verseNode != nil
			if verseNode.text?
				# This node is text; just append its contents to verse text
				verseText += verseNode.content
			elsif verseNode.elem?
				# This node is some sort of tag. Is it friend or foe?
				if verseNode.name() == "sup"
					if verseNode.get_attribute("class") == "versenum"
						# Aha - next verse starts here. Stop assembling this one.
						break
					end
				elsif verseNode.name() == "p"
					# We represent paragraph tags as two newlines
					verseText += "\n\n"
				elsif verseNode.name() == "br"
					# We represent linebreak tags as one newline
					verseText += "\n"
				end
			end
			verseNode = verseNode.next_sibling			
		end
		
		# Nokogiri auto-converts &nbsp; to pesky non-breaking space characters.
		# Convert them to regular spaces. First quoted space is Unicode nbsp.
		verseText.gsub!(" ", " ")
		
		# Trim leading and trailing whitespace.
		verseText.strip!
		
		# Output this record to the CSV table.
		csv << [book, chapter, verseNumber, verseText]
		
	end
	
end

def ConvertIndex(url, csv)
	
	# Download and parse the index page
	index = Nokogiri::HTML(open(URI.escape(url)))
	
	# Find the part of the page containing the table of chapter links
	table = index.at('table.infotable')
	
	# Look for chapter link "a" tag in the table
	table.search('a').each do |link|
		
		# Read the href attribute of the link tag to the chapter page address
		path = link.get_attribute('href')
		url = 'http://www.biblegateway.com' + path
		
		# Read the title attribute and split on the last space to get the book and chapter
		title = link.get_attribute('title')
		split = title.rindex(' ')
		book = title[0..split-1]
		chapter = title[split+1..-1]
		
		# Go go gadget read this chapter
		puts "Reading " + title + "..."
		ConvertChapter(book, chapter, url, csv)
		
		# Let's be polite and pause a bit between pulling down each page
		sleep 1
		
	end
	
end


if ARGV.size != 2
	STDERR.puts "usage: imbibler.rb OUTPUTFILE INDEXURL"
	STDERR.puts "       (NIV Bible index URL: http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/)"
	exit 1
end

outputFile = ARGV[0]
indexURL = ARGV[1]

csv = CSV.open(outputFile, 'w')
ConvertIndex(indexURL, csv)
csv.close

exit 0

class Poem < ApplicationRecord
	def self.import_from_file
		is_header = true
		author = ""
		title = ""
		hanji = ""
		hongim = ""
		tailo = ""

		File.open("hanji.txt", "r").each_line do |line|
  			if is_header
  				author_and_title = line.split("．")
  				author = author_and_title[0].squish!
  				title = author_and_title[1].squish!
  				is_header = false
  			else
  				hanji += line
  			end
		end

		is_header = true
		File.open("hongim.txt", "r").each_line do |line|
  			if is_header
  				is_header = false
  			else
  				hongim += line
  			end
		end

		is_header = true
		File.open("tailo.txt", "r").each_line do |line|
  			if is_header
  				is_header = false
  			else
  				tailo += line
  			end
		end

		puts "author = " + author
		puts "title = " + title
		puts "hanji = " + hanji
		puts "hongim = " + hongim
		puts "tailo = " + tailo

		author = Author.where(name: author).take!

		puts author.inspect
		Poem.create!(:author_id => author.id, :title => title, :hanji => hanji, :hongim => hongim, :stailo => tailo)
	end


end
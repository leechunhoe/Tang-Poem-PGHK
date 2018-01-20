class Poem < ApplicationRecord
	has_one :author
	def author
		return Author.find_by(:id => self.author_id)
	end

	def hanji_with_hongim
		punctuations = ["。","「","」","，","？","．"]
		tone_marks = [" ","ˋ","˪","ㆴ˙","ㆵ˙","ㆶ˙","ㆷ˙","ㆴ","ㆵ","ㆶ","ㆷ","ˊ","˫"]
		special_tone_marks = ["ㆴ","ㆵ","ㆶ","ㆷ"]

		result = []
		hanji_array = self.hanji.split("\n")
		hongim_array = self.hongim.split("\n")
		for index in (0...hanji_array.length)
			hanjis = hanji_array[index]
			hongims = hongim_array[index]
			sentence = ""
			for j in (0...hanjis.length)
				if punctuations.include?(hongims[0])
					sentence += "<ruby>" + hanjis[j] + "</ruby>"
					hongims.slice! hongims[0]
				else
					hongim_combo = ""

					if hongims == nil or hongims.length == 0
						sentence += "<ruby>" + hanjis[j] + "</ruby>"
					else
						while hongims != nil and !tone_marks.include?(hongims[0])
							if hongims == nil or hongims[0] == nil
								break
							else
								hongim_combo += hongims[0]
								hongims.slice! hongims[0]
							end
						end

						if hongims != nil
							if hongims.length > 1
								candidate_tone = hongims[0]
								if special_tone_marks.include?(candidate_tone)
									# When end with p, t, k, which might include dot after it
									candidate_tone_2 = hongims[0] + hongims[1]
									if tone_marks.include?(candidate_tone_2)
										# Is p, t, k with dot
										hongim_combo += candidate_tone_2
										hongims.slice! hongims[0]
										hongims.slice! hongims[0]
									else
										# Is p, t, k without dot
										hongim_combo += hongims[0]
										hongims.slice! hongims[0]
									end
								else
									if tone_marks.include?(hongims[0])
										hongim_combo += hongims[0]
										hongims.slice! hongims[0]
									end
								end
							elsif hongims.length > 0
								if tone_marks.include?(hongims[0])
									hongim_combo += hongims[0]
									hongims.slice! hongims[0]
								end
							end
						end
						sentence += "<ruby>" + hanjis[j] + "<rt>" + hongim_combo + "</rt></ruby>"
					end
				end
			end
			result << sentence
			result << "\n"
		end
		return result
	end

	def hanji_with_stailo
		result = []
		hanji_array = self.hanji.split("\n")
		stailo_array = self.stailo.split("\n")
		for index in (0...hanji_array.length)
			result << stailo_array[index]
			result << hanji_array[index]
			result << "\n"
		end
		return result
	end

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
		Poem.where(:title => title, :author_id => author.id).destroy_all
		Poem.create!(:author_id => author.id, :title => title, :hanji => hanji, :hongim => hongim, :stailo => tailo)
	end


end
#!/usr/bin/env ruby
require 'csv'

class Author < ApplicationRecord
	def self.import_from_file
		Author.delete_all
		artists = CSV.read("artists.csv", { :col_sep => "\t", :headers => true})
		artists.each do |artist|
			# puts artist.inspect
			Author.create!(artist.to_hash)
		end
	end
end
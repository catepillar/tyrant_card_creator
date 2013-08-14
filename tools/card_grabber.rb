#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

# chdir allows this to work from anywhere.
Dir.chdir(File.dirname(__FILE__))

n = Nokogiri::XML.parse(open("http://dev.tyrantonline.com/assets/cards.xml"))
folder = "../html/images/cards"

Dir.mkdir(folder) unless Dir.exists? folder

count = 0

n.xpath("/root/unit[picture != 'loading.jpg']/picture").each do |i|
	if(File.exists?("#{folder}/#{i.text}"))
		#puts "      Already have #{i.text}"
	else
		puts "#{"%4d." % [count+1]} Downloading #{i.text}."
		begin
			open("http://cdn.tyrantonline.com/warhawk/images/#{URI.encode(i.text)}") do |input|
				count += 1
				file = "#{folder}/#{i.text}"
				open(file,"wb") { |output| output.write(input.read) }
			end
		rescue Exception => e	# this prevents and exception on one card from stopping the downloading.
			puts "Exception on #{i.text}"
			puts e.message
		end
	end
end

puts "No new cards to download" if count == 0

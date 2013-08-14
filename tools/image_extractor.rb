require 'nokogiri'
require 'open-uri'

# chdir allows this to work from anywhere.
Dir.chdir(File.dirname(__FILE__))

# might need to be changed by other users.
image_directory = "../html/images"
Dir.mkdir(image_directory) unless Dir.exists? image_directory

# get the newest cards xml file.
n = Nokogiri::XML.parse(open("http://dev.tyrantonline.com/assets/cards.xml"))

# get the assets version. download if not already on server.
print "Assets version (include '_'): "
version = gets.chomp

unless File.exists?("Assets_#{version}.swf")
	open("http://cdn.tyrantonline.com/tyrant/images/Assets_#{version}.swf") do |assets|
		open("Assets_#{version}.swf","wb") { |file| file.write assets.read }
	end
end

# get the files from images
files = Dir.entries(image_directory) - ["..",".","cards"] 

# The basic files needed to build a card are included here by default
needs = ["ClockIcon","AttackIcon","HealthIcon", "AssaultLegendaryIcon","CommanderGoldIcon","StructureRegIcon","ActionGoldIcon","AssaultGoldIcon","CommanderRegIcon","StructureSilverIcon","ActionRegIcon","AssaultRegIcon","CommanderSilverIcon","StructureGoldIcon","ActionSilverIcon","AssaultSilverIcon","StructureLegendaryIcon","ActionLegendaryIcon"]

n.xpath("/root/unitType").each	{ |x| needs << x.at("image").text unless x.at("image").nil? or files.include?(x.at("image").text) }
n.xpath("/root/skillType").each	{ |x| needs << x.at("icon").text unless x.at("icon").nil? }
n.xpath("/root/cardSet").each	{ |x| needs << x.at("icon").text unless x.at("icon").nil? }

dump = `swfdump Assets_#{version}.swf`.split("\n").collect { |s| s.strip }

needs.each do |item|
	x = dump.find { |d| d.match(/^exports \d+ as \"#{item}\"/) }
	if x.nil?
		puts "cannot get #{item}"
		next
	end
	num = x.match(/^exports (\d+) as \"#{item}\"/)[1].to_i
	ending = "png"
	unless File.exists?("#{image_directory}/#{item}.png")
		puts "Extracting #{num} as #{item}.png"
		exec = "swfextract -p #{num} Assets_#{version}.swf -o #{image_directory}/#{item}.png 2>&1"
		r = `#{exec}`
		puts r
		unless(r.match(/is not a PNG/).nil?)
			puts "Failed to extract #{num} as #{item}.png. Trying .jpg"
			exec = "swfextract -j #{num} Assets_#{version}.swf -o #{image_directory}/#{item}.jpg"
			`#{exec}`
			puts
			ending = "jpg"
		end
	else
		#puts "#{item}.png already exists. Skipping."
	end
end


100.times do |n|
	Category.create! name: "#{RandomWord.nouns.next}"
end
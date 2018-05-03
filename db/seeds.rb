100.times do |n|
	Category.create! name: "#{RandomWord.adjs.next.split('_').map(&:capitalize).join(' ')}"
end
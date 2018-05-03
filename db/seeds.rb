100.times do |n|
	Category.create! name: "#{(0...50).map { ('a'..'z').to_a[rand(26)] }.join}"
end
user = User.create name: 'Tester', email: 'test@example.com', password: '123456'

100.times do |n|
	Category.create! name: "Category #{n}"
end

Item.create title: 'item 1', description: 'The Best Query Language', category: Category.first, user: user
Item.create title: 'item 2', description: 'The Best Query Language ever', category: Category.last, user: user
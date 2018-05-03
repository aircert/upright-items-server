require 'test_helper'

class Resolvers::CreateItemTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateItem.new.call(nil, args, {})
  end

  test 'creating new item' do
    category = Category.create!(name: 'Category 1')
    item = perform(
      title: 'Item 1',
      description: 'description',
      category: category
    )

    assert item.persisted?
    assert_equal item.title, 'Item 1'
    assert_equal item.description, 'description'
    assert_equal item.category.name, 'Category 1'
  end
end
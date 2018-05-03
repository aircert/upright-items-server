require 'search_object/plugin/graphql'

class Resolvers::ItemsSearch
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Item.all }

  # return type
  type !types[Types::ItemType]

  # inline input type definition for the advance filter
  ItemFilter = GraphQL::InputObjectType.define do
    name 'ItemFilter'

    argument :OR, -> { types[ItemFilter] }
    argument :description_contains, types.String
    argument :title_contains, types.String
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: ItemFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip
  option :orderBy, type: types.String, with: :apply_order

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def apply_order(scope, value)
    scope.order("value")
  end

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    # normalize filters from nested OR structure, to flat scope list
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    # add like SQL conditions
    scope = Item.all
    scope = scope.where('lower(title) LIKE ?', "%#{value['title_contains'].downcase}%") if value['title_contains']
    scope = scope.where('lower(description) LIKE ?', "%#{value['description_contains'].downcase}%") if value['description_contains']

    branches << scope

    # continue to normalize down
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end
end
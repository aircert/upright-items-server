Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  
  field :allItems, function: Resolvers::ItemsSearch
  # queries are just represented as fields
  field :allCategories, !types[Types::CategoryType] do
    # resolve would be called in order to fetch data for that field
    resolve -> (obj, args, ctx) { Category.all }
  end
end

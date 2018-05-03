Types::CategoryType = GraphQL::ObjectType.define do
  name 'Category'

  field :id, types.ID
  field :name, !types.String
  field :item, -> { Types::ItemType }
end
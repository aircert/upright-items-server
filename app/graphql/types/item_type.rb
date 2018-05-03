# defines a new GraphQL type
Types::ItemType = GraphQL::ObjectType.define do
  # this type is named `Item`
  name 'Item'

  # it has the following fields
  field :id, !types.ID
  field :title, !types.String
  field :description, !types.String
  
  field :created_at, !Types::DateTimeType
  field :updated_at, !Types::DateTimeType
  # add postedBy field to Item type
  # - "-> { }": helps against loading issues between types
  # - "property": remaps field to an attribute of Item model
  field :postedBy, -> { Types::UserType }, property: :user
  field :category, -> { !Types::CategoryType }
end
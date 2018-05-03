Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createItem, function: Resolvers::CreateItem.new
  field :createUser, function: Resolvers::CreateUser.new
  field :signinUser, function: Resolvers::SignInUser.new
end
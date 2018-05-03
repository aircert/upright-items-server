class Resolvers::CreateItem < GraphQL::Function

  # arguments passed as "args"
  argument :title, !types.String
  argument :description, !types.String
  argument :category_id, !types.Int
  
  # return type from the mutation
  type Types::ItemType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context
  def call(_obj, args, ctx)
    Item.create!(
      title: args[:title],
      description: args[:description],
      category_id: args[:category_id],
      user: User.first # Hack for now see below comment
      # user: ctx[:current_user] there is a bug with ctx and sessions in graphql_controller.rb
    )
  rescue ActiveRecord::RecordInvalid => e
    # this would catch all validation errors and translate them to GraphQL::ExecutionError
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
Rails.application.routes.draw do
  post "/", to: "graphql#execute"
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/"
  end
end

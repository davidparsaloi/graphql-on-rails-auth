# frozen_string_literal: true

class GraphqlOnRailsSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST
  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections
  use GraphQL::Execution::Errors
  # Turn off introspection entry points __schema && __type
  disable_introspection_entry_points if Rails.env.production?

  rescue_from(ActiveRecord::RecordNotFound) do |err, obj, args, ctx, field|
    raise GraphQL::ExecutionError, err
  end
   
  rescue_from(ActiveRecord::RecordInvalid) do |err, obj, args, ctx, field|
    raise GraphQL::ExecutionError, err
  end

  rescue_from(ActionPolicy::Unauthorized) do |err|
    raise GraphQL::ExecutionError.new(err.result.message)
  end

  rescue_from(ActionPolicy::AuthorizationContextMissing) do
    raise GraphQL::ExecutionError.new('Please login to access this resource')
  end
end

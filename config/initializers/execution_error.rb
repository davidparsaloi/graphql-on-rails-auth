# frozen_string_literal: true
# https://www.abhaynikam.me/posts/error-handling-in-graphql-ruby/

class GraphQL::ExecutionError < GraphQL::Error
  attr_accessor :error, :record

  def initialize(error)
    @error = error
    @record = error.try(:record)
  end

  def to_h
    if record.present?
      record.errors.messages
    else
      error
    end
  end
end

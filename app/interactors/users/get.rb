# frozen_string_literal: true

module Users
  class Get < BaseInteractor
    delegate :id, to: :context
    
    def call
      context.user = User.find(id)
    end
  end
end

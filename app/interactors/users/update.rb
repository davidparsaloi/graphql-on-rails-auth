# frozen_string_literal: true

module Users
  class Update < BaseInteractor
    delegate :user, :attributes, to: :context

    def call
      user.update! attributes
      context.user = user
      context.message = 'User updated successfully'
    end
  end
end

# frozen_string_literal: true

module Users
  class Delete < BaseInteractor
    delegate :user, to: :context

    def call
      user.destroy!
      context.message = 'You have successfully deleted your account'
    end
  end
end

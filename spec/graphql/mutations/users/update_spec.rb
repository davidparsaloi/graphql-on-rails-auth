# frozen_string_literal: true

RSpec.describe Mutations::Users::Update, type: :request do
  subject(:execute) do
    post graphql_path, params: { query: query_string, variables: variables }
  end

  let(:user) { create(:user) }
   
  describe '.resolve' do
    context 'valid params' do
      let(:variables) {{ userId: user.id, email: 'arianna@email.com' }}

      it 'updates the user' do
         
        execute 
        
        json = JSON.parse(response.body)
        user = json.dig('data', 'updateUser', 'user')

        expect(user).to include({ "email"=>"arianna@email.com" })
      end
    end
  end

  def query_string
    <<~GRAPHQL
      mutation($userId: ID!, $email: String!) {
        updateUser(input: { userId: $userId, email: $email }) {
          user {
            firstName
            lastName
            email
          },
          errors
        }
      }
    GRAPHQL
  end
end

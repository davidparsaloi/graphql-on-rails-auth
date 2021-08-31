# frozen_string_literal: true

module Users
  RSpec.describe Delete, type: :interactor do
    subject(:context) { described_class.call(user: user) }

    let(:user) { create(:user) }

    describe '.call' do
      context 'when successful' do
        it 'passes' do
          expect(context).to be_a_success
        end

        it 'deletes the user record' do
          context

          expect(user.destroyed?).to eq true
        end

        it 'returns a success message' do
          context

          expect(context.message).to eq 'You have successfully deleted your account'
        end
      end

      context 'when it fails' do
        let(:error_message) { 'Record Not Destroyed' }

        before do
          allow(user).to receive(:destroy!).and_raise ActiveRecord::RecordNotDestroyed.new error_message
        end

        it 'fails' do
          expect { context }.to raise_error(ActiveRecord::RecordNotDestroyed, 'Record Not Destroyed')
        end
      end
    end
  end
end

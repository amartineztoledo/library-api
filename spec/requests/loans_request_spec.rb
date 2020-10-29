# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Loans', type: :request do
  let(:valid_attributes) do
    {
      user_id: User.create(name: 'New user').id,
      books: [
        {
          id: Book.create(title: 'New title', autor: 'New autor', stock: 10).id,
          quantity: 1
        }
      ]
    }
  end

  let(:invalid_attributes) do
    {
      user_id: User.create(name: 'New user').id,
      books: [
        id: Book.create(title: 'New title', autor: 'New autor', stock: 10).id,
        quantity: 100
      ]
    }
  end

  let(:valid_headers) do
    {}
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Loan' do
        expect do
          post loans_url,
               params: { loan: valid_attributes }, headers: valid_headers,
               as: :json
        end.to change(Loan, :count).by(1)
      end

      it 'renders a JSON response with the new loan' do
        post loans_url,
             params: { loan: valid_attributes }, headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Loan' do
        expect do
          post loans_url,
               params: { loan: invalid_attributes }, as: :json
        end.to change(Loan, :count).by(0)
      end

      it 'renders a JSON response with errors for the new Loan' do
        post loans_url,
             params: { loan: invalid_attributes }, headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end

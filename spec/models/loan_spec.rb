# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:expiration_date) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end
end

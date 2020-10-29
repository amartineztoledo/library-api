# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:autor) }
    it { should validate_presence_of(:stock) }
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
  end

  describe 'Relationships' do
    it { should have_many(:loans) }
  end
end

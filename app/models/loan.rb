# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :expiration_date, presence: true
end

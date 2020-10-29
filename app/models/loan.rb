# frozen_string_literal: true

class Loan < ApplicationRecord
  EXPIRATION_DAYS = 30

  belongs_to :user
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :expiration_date, presence: true
  validate :avaible_stock

  after_create :reduce_from_stock
  before_destroy :add_to_stock

  private

  def avaible_stock
    return unless book.present?

    errors.add(:quantity, 'No stock') if (book.stock - quantity).negative?
  end

  def reduce_from_stock
    book.stock -= quantity
    book.save
  end

  def add_to_stock
    book.stock += quantity
    book.save
  end
end

# frozen_string_literal: true

class Loan < ApplicationRecord
  EXPIRATION_DAYS = 30

  belongs_to :user
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :expiration_date, presence: true
  validate :avaible_stock
  validate :already_loaned, on: :create

  after_create :reduce_from_stock
  after_update :destroy_if_returned
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

  def destroy_if_returned
    destroy if quantity.zero?
  end

  def add_to_stock
    book.stock += quantity
    book.save
  end

  def already_loaned
    return unless Loan.find_by(user_id: user_id, book_id: book_id).present?

    errors.add(:id, 'Already loaned')
  end
end

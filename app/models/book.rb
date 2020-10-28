# frozen_string_literal: true

class Book < ApplicationRecord
  validates :autor, presence: true
  validates :title, presence: true
  validates :stock, presence: true, numericality: { greater_than: 0 }
end

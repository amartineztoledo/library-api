# frozen_string_literal: true

# User model
class User < ApplicationRecord
  validates :name, presence: true

  has_many :loans
end

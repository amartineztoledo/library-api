# frozen_string_literal: true

class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :autor, :stock
end

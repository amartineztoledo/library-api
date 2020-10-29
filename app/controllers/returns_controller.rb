# frozen_string_literal: true

class ReturnsController < ApplicationController
  def create
    result = UserReturnsBooks.call(return_params)

    if result.success?
      render json: result.loans, status: :created
    else
      render json: result.message, status: :unprocessable_entity
    end
  end

  private

  def return_params
    params.require(:return).permit(:user_id, books: %i[id quantity])
  end
end

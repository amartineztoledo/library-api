# frozen_string_literal: true

class LoansController < ApplicationController
  def create
    result = UserReceivesBooks.call(loan_params)

    if result.success?
      render json: result.loans, status: :created
    else
      render json: result.message, status: :unprocessable_entity
    end
  end

  private

  def loan_params
    params.require(:loan).permit(:user_id, books: %i[id quantity])
  end
end

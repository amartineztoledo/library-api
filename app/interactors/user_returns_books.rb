# frozen_string_literal: true

class UserReturnsBooks
  include Interactor

  def call
    context.user = User.find(context.user_id)
    context.loans = []

    context.books.each do |book|
      loan = Loan.find_by(book_id: book[:id], user: context.user)
      if loan.present?
        loan.quantity -= book[:quantity].to_i
        context.loans << loan
      end
    end

    all_valid = context.loans.map(&:valid?).all?
    if all_valid
      context.loans.each(&:save)
    else
      context.fail!(message: 'UserReceivesBooks.failure')
    end
  end
end

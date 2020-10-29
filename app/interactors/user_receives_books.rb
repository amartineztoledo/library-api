# frozen_string_literal: true

class UserReceivesBooks
  include Interactor

  def call
    context.user = User.find(context.user_id)
    context.loans = []

    context.books.each do |book|
      data = {
        user: context.user,
        book: Book.find(book[:id]),
        quantity: book[:quantity],
        expiration_date: Date.today + Loan::EXPIRATION_DAYS
      }

      context.loans << Loan.new(data)
    end

    all_valid = context.loans.map(&:valid?).all?
    if all_valid
      context.loans.each(&:save)
    else
      context.fail!(message: 'UserReceivesBooks.failure')
    end
  end
end

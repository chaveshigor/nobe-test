module TransactionServices
  class TransactionBaseService
    def error_response(error_message)
      { success: false, message: error_message }
    end

    def success_response(transaction)
      { success: true, transaction: transaction }
    end
  end
end

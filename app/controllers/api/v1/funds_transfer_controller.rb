module Api
  module V1
    class FundsTransferController < ApplicationController

      # post api/v1/funds_transfer
      def create
        if params[:source_account].present? && params[:destination_account].present? && params[:amount_cents].to_i >= 0
          result = transfer_funds_from_source_account_to_destination
          if result[:success] == true
            render json: { message: "Funds has been transferred successfully" , status: 204 }
          else
            render json: { message: "Funds Transfer unsuccessful: #{result[:error]}" , status: 500 }
          end

        else
          render json: { message: "Invalid Params" , status: 400 }
        end
      end

      private

      def transfer_funds_from_source_account_to_destination
          TransferFunds.new(
              source_account: params[:source_account],
              destination_account: params[:destination_account],
              amount_cents: params[:amount_cents],
              transaction_type: Transaction.transaction_types[:transfer]
          ).call
        end
    end
  end
end

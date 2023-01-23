module Api
  module V1
    class AccountsController < ApplicationController
      before_action :set_account, only: %i[ show ]

      # GET /accounts or /accounts.json
      def index
        @accounts = Account.all
        render json: { accounts: @accounts.to_json, status: 200 }
      end

      # GET api/v1/accounts/1
      def show
        if @account.present?
          account_balance = find_account_balance
          transactions = find_last_n_transactions(10)
          render json: { account_balance: account_balance, transactions: transactions.to_json, status: 200 }
        else
          render json: { message: "Account not found" , status: 404 }
        end
      end

      # GET api/v1/accounts/new
      def new
        @account = Account.new
      end

      # POST accounts.json
      def create
        @account = Account.new(name: params[:name].to_s, account_number: create_account_number)
          if @account.save
            result = deposit_account_opening_balance
            if result[:success] == true
              render json: { message: "Account has been created successfully with initial deposit" , status: 204 }
            else
              render json: { message: "Account has been created but initial deposit failed. Error: #{result[:message]}" , status: 500 }
            end
          else
            render json: { message: "Unable to create Account" , status: 400 }
          end
      end

      private

        def set_account
          @account = Account.where(id: params[:id].to_i).last
        end

        def account_params
          params.fetch(:account, {}).permit(:name, :balance_cents, :currency)
        end

        def find_account_balance
          # @account.postings.sum(:amount_cents) can be used as well but it might be slow to calculate at runtime So,
          # Considering efficiency of the system, pulling data directly from account instead calculating at runtime,
          # it's the choice and can be other way around based on the requirements
           Account.find_by(id: @account.id).balance.format # @account.postings.sum(:amount_cents)
        end

        def find_last_n_transactions(number_of_transactions)
          Transaction.where("destination_account_id = ? OR source_account_id = ?", @account.id, @account.id).last(number_of_transactions)
        end

        def create_account_number
          SecureRandom.random_number(10**8).to_s.rjust(8, "0")
        end

        def deposit_account_opening_balance

          # Instead of directly adding balance to account, doing via Transfer fund service So, we have transaction record for that
          # also journal entry postings would be recorded for that which can help later during trial balance

          source_account =  Account.where(name: 'CashBook').last  # Every new account deposit would be from CashBook
          if source_account.present?
            TransferFunds.new(source_account: source_account.id,
                destination_account: @account.reload.id,
                amount_cents: params[:balance_cents].to_i,
                transaction_type: Transaction.transaction_types[:deposit]

            ).call
          else
            result = {}
            result[:message] = "Please seed data"
            result[:status] = 500
            result[:success] = false
            return result
          end
        end
    end
  end
end


class Customer::CustomerController < ApplicationController
    def show
    end

    def edit
    end

    def update
    end

    def unsubscribe
    end

    def withdraw
        current_customer.update(is_deleted: true)
        reset_session
        redirect_to root_path
    end
end

class Admin::OrdersController < ApplicationController
    before_action :check_admin, only: [:index, :show]

    def index
        @orders = Order.all
    end

    def show
        @order = Order.find(params[:id])
        @order_details = OrderDetail.where(order_id: @order.id)
    end

    def update
        @order = Order.find(params[:id])
        if params[:order][:status] == 'comfirm'
            @order.update(status: (Order.statuses[params[:order][:status].to_sym]).to_i)
            order_details = OrderDetail.where(order_id: @order.id)
            order_details.each do |order_detail|
                order_detail.update(making_status: 1)
            end
            redirect_to admin_path
        else
            @order.update(status: params[:order][:status].to_i)
            redirect_to admin_path
        end
    end

    private

    def check_admin
        unless admin_signed_in?
            redirect_to root_path
        end
    end

    def order_params
        params.require(:order).permit(:id, :status)
    end
end

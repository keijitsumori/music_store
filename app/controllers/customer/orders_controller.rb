class Customer::OrdersController < ApplicationController
    before_action :comfirm_order_items, only: [:new]

    def new
        @order = Order.new
    end

    def comfirm
        @order_new = Order.new
        @order = Order.new
        @order.payment_method = params[:order][:payment_method].to_i
        @order.customer_id = current_customer.id
        @order.shipping_cost = 800
        @cart_items = CartItem.where(customer_id: current_customer.id)
        if  params[:order][:address_option] == "0"
            @order.postal_code = current_customer.postal_code
            @order.address = current_customer.address
            @order.name = current_customer.last_name + current_customer.first_name
            render :comfirm
        elsif params[:order][:address_option] == "1"
            address = Address.find(params[:order][:address_id])
            @order.postal_code = address.postal_code
            @order.address = address.address
            @order.name = address.name
            render :comfirm
        elsif params[:order][:address_option] == "2"
            @order.postal_code = params[:order][:postal_code]
            @order.address = params[:order][:address]
            @order.name = params[:order][:name]
            render :comfirm
        end
    end

    def complete
    end

    def create
        @order = Order.new(order_params)
        @order.save
        cart_items = CartItem.where(customer_id: current_customer.id)
        cart_items.each do |cart_item, order_detail|
            order_detail  = OrderDetail.new
            order_detail.order_id = @order.id
            order_detail.item_id = cart_item.item_id
            order_detail.price = cart_item.item.price
            order_detail.amount = cart_item.amount
            order_detail.save
        end
        @cart_items = CartItem.where(customer_id: current_customer.id)
        @cart_items.destroy_all
        redirect_to orders_complete_path
    end

    def index
    end

    def show
    end

    private

    def comfirm_order_items
        if current_customer.cart_items.exists?
        else
            redirect_to items_path
        end
    end

    def order_params
        params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :payment_method, :total_payment)
    end
end

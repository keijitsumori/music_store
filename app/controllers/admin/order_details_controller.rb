class Admin::OrderDetailsController < ApplicationController
    def update
        order_detail = OrderDetail.find(params[:id])
        if params[:order_detail][:making_status] == 'in_production'
            order_detail.update(making_status: 2)
            order = Order.find_by(id: order_detail.order_id)
            order.update(status: 2)
            redirect_to admin_path
        elsif params[:order_detail][:making_status] == 'completed'
            order_detail.update(making_status: 3)
            order_details = OrderDetail.where(order_id: order_detail.order_id)
            a = 0
            order_details.each do |order_detail|
                unless order_detail.making_status != 'completed'
                    a += 1
                end
            end
            if a == order_details.size
                order = Order.find_by(id: order_detail.order_id)
                order.update(status: 3)
                redirect_to admin_path
            else
                redirect_to admin_path
            end
        else
            order_detail.update(making_status: (OrderDetail.making_statuses[params[:order_detail][:making_status].to_sym]).to_i)
            redirect_to admin_path
        end
    end

    private

    def order_detail_params
        params.require(:order_detail).permit(:making_status)
    end
end

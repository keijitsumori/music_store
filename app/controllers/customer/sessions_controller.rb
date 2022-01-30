# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  before_action :configure_is_deleted?,  only: [:create]
  # before_action :configure_sign_in_params, only: [:create]
  
  def after_sign_in_path_for(resource)
    customers_my_page_path # ログイン後に遷移するpathを設定
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  protected

  def configure_is_deleted?
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true))
        redirect_to new_customer_registration_path, notice: "退会済みです。"
      end
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

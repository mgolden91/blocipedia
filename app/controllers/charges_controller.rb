class ChargesController < ApplicationController

  @@amount = 1500 #amount in pennies

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: @@amount
    }
  end

  def create

    @user = current_user

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )


    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @@amount,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    @user.role = "premium"
    if @user.save!
      flash[:notice] = "Successfully Upgraded account"
    else
      flash[:error] = "Error please try again."
    end
    redirect_to user_path(current_user)
  end

  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to charges_path
  end


class ChargesController < ApplicationController
  include ChargesHelper
  after_action :upgrade_account, only: :create
  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end
  def create
    # Creates a Stripe Customer object, for associating
    # with a charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: Amount.default,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This rescue block catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def downgrade
    current_user.update_attribute(:role, 'free')
    flash[:notice] = "You have been downgraded, #{current_user.email}"
    redirect_to root_path
  end

  private

  def upgrade_account
    current_user.update_attribute(:role, 'vip')
  end
end

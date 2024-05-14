class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
    @group = Group.find_by(token: params[:token])
    @members = Member.where(group_id: @group.group_id)
  end

  def create
    @payment = Payment.new(payment_params)
    @group = Group.find_by(group_id: @payment.group_id)
    if @payment.save
      redirect_to group_show_path(token: @group.token)
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
  def payment_params
      params.require(:payment).permit(:creditor_member_id, :debtor_member_id, :group_id, :amount, :payment_date, :description)
  end
end

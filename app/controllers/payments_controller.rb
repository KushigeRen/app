class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
    @group = Group.find_by(token: params[:token])
    @members = Member.where(group_id: @group.group_id)
  end

  def create
    @payment = Payment.new(payment_params)
    @group = Group.find_by(group_id: @payment.group_id)
    @members = Member.where(group_id: @group.group_id)
    if @payment.save
      flash[:notice] = "支払い明細を作成しました"
      redirect_to group_show_path(token: @group.token)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @payment = Payment.find(params[:id])
    @group = Group.find(@payment.group_id)
    @members = Member.where(group_id: @group.group_id)
    @creditor_member = Member.find_by(member_id: @payment.creditor_member_id)
    @debtor_member =Member.find_by(member_id: @payment.debtor_member_id)
  end

  def update
    @payment = Payment.find(params[:id])
    @group = Group.find_by(group_id: @payment.group_id)
    @members = Member.where(group_id: @group.group_id)
    @creditor_member = Member.find_by(member_id: @payment.creditor_member_id)
    @debtor_member =Member.find_by(member_id: @payment.debtor_member_id)
    if @payment.update(payment_params)
      flash[:notice] = "支払い明細を更新しました"
      redirect_to group_show_path(token: @group.token)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @group = Group.find_by(group_id: @payment.group_id)
    if @payment.destroy
      flash[:notice] = "支払いが完了しました"
      redirect_to group_show_path(token: @group.token)
    end
  end

  private
  def payment_params
      params.require(:payment).permit(:creditor_member_id, :debtor_member_id, :group_id, :amount, :payment_date, :description)
  end
end

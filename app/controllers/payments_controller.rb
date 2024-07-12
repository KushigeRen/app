class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
    @group = Group.find_by(token: params[:token])
    @members = Member.where(group_id: @group.group_id)
    @creditor_member = Member.new
    @debtor_member =Member.new
  end

  def create
    @payment = Payment.new(payment_params)
    @group = Group.find_by(group_id: @payment.group_id)
    @members = Member.where(group_id: @group.group_id)
    @creditor_member = Member.new
    @debtor_member =Member.new
    if @payment.save
      flash.now.notice = "支払い明細を作成しました"
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
      flash.now.notice =  "支払い明細を更新しました"
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @group = Group.find_by(group_id: @payment.group_id)
    if @payment.destroy
      flash.now.notice =  "支払いが完了しました"
    end
  end

  private
  def payment_params
      params.require(:payment).permit(:creditor_member_id, :debtor_member_id, :group_id, :amount, :payment_date, :description)
  end
end

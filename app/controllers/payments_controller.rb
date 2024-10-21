class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
    @group = Group.find_by(token: params[:token])
    @members = Member.where(group_id: @group.group_id)
    @creditor_member = Member.new
    @debtor_member = Member.new
  end

  def create
    @payment = Payment.new(payment_params)
    @group = Group.find(@payment.group_id)
    @members = Member.where(group_id: @group.group_id)
    @payments = Payment.where(group_id: @group.group_id)
    if @payment.save
      flash.now.notice = "支払い明細を作成しました"
      @search = @payments.ransack(params[:q])
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @payment = Payment.find(params[:id])
    @group = Group.find(@payment.group_id)
    @members = Member.where(group_id: @group.group_id)
    @creditor_member = Member.find_by(member_id: @payment.creditor_member_id)
    @debtor_member = Member.find_by(member_id: @payment.debtor_member_id)

    # GoogleCalendarAPI用の環境変数取得
    @client_id = Google::Auth::ClientId.from_file(ENV.fetch('GOOGLE_CALENDAR_SECRET_PATH')).id
    @redirect_url = ENV.fetch('GOOGLE_CALENDAR_REDIRECT_URI')
    @scope = Google::Apis::CalendarV3::AUTH_CALENDAR
  end

  def update
    @payment = Payment.find(params[:id])
    @group = Group.find_by(group_id: @payment.group_id)
    @members = Member.where(group_id: @group.group_id)
    @creditor_member = Member.find_by(member_id: @payment.creditor_member_id)
    @debtor_member = Member.find_by(member_id: @payment.debtor_member_id)
    if @payment.update(payment_params)
      flash.now.notice = "支払い明細を更新しました"
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    if @payment.destroy
      flash.now.notice = "支払いが完了しました"
    end
  end

  def destroy_selected
    @target_payments = Payment.where(payment_id: params[:payment_ids])
    @present_flag = @target_payments.present?
    if params[:payment_ids]
      @payments = Payment.where(group_id: @target_payments[0].group_id).where.not(payment_id: @target_payments.pluck(:payment_id))
      @group = Group.find_by(group_id: @target_payments[0].group_id)
      @members = Member.where(group_id: @group.group_id)
      @search = @payments.ransack(params[:q])
      if @target_payments.destroy_all
        flash.now.notice = "選択された支払いを完了しました。"
      end
    else
      flash.now.alert = "完了する支払いを選択してください。"
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:creditor_member_id, :debtor_member_id, :group_id, :amount, :payment_date, :description)
  end
end

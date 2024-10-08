class FormatsController < ApplicationController
  # クラスインスタンス変数を定義
  @member_name = []
  @member_name_keys = []
  @members = []

  # クラスインスタンス変数のアクセサメソッドを定義
  class << self
    attr_accessor :member_name, :member_name_keys, :members
  end

  def index
    @formats = Group.includes(:members)
    @format = GroupMember.new
    self.class.members.clear
    # 新規作成するグループのIDを採番
    if Group.count == 0
      @group_id = 1
    else
      @group_id = Group.maximum(:group_id) + 1
    end
  end

  def show
    @group = Group.find_by(token: params[:token])
    @members = Member.where(group_id: @group.group_id)
    @payments = Payment.where(group_id: @group.group_id)

    @search = @payments.ransack(params[:q])
    @payments = @search.result.includes(:creditor_member).select(:payment_id, :creditor_member_id, :debtor_member_id, :amount)
  end

  # --- グループとメンバーを作成する ---
  def create
    set_member_name
    GroupMember.create_member_accessors(self.class.member_name_keys)
    @format = GroupMember.new(format_params)
    if @format.save(self.class.member_name)
      @group = Group.find(Group.order(group_id: :desc).first.group_id)
      redirect_to group_show_path(token: @group.token)
    else
      render "index"
    end
  end
  # --------------------------------

  # --- グループ名を更新する ---
  def edit_group
    @group = Group.find(params[:id])
  end

  def update_group
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash.now.notice = "グループ情報を更新しました"
    else
      render 'edit_group', status: :unprocessable_entity
    end
  end
  # -------------------------

  # --- メンバー情報を追加・更新・削除する ---
  def edit
    @member = Member.find(params[:id])
    @group = Group.find_by(group_id: @member.group_id)
  end

  def update
    @member = Member.find(params[:id])
    @group = Group.find_by(group_id: @member.group_id)
    if @member.update(member_params)
      flash.now.notice = "メンバー情報を更新しました。"
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @group = Group.find_by(group_id: @member.group_id)

    @members = Member.where(group_id: @group.group_id)
    @payments = Payment.where(group_id: @group.group_id)
    @search = @payments.ransack(params[:q])
    @payments = @search.result.includes(:creditor_member).select(:payment_id, :creditor_member_id, :debtor_member_id, :amount)
    if @member.destroy
      flash.now.notice = "メンバー情報を削除しました。"
    else
      flash.now.alert = "このメンバーには関連する支払い明細があるため、削除できません。"
    end
  end

  def add_member
    @member = Member.new
    @group = Group.find(params[:id])
  end

  def create_member
    @member = Member.new(member_params)
    @group = Group.find_by(group_id: @member.group_id)
    if @member.save
      flash.now.notice = "メンバー情報を登録しました。"
    else
      render 'add_member', status: :unprocessable_entity
    end
  end
  # --------------------------------

  # クラスインスタンス変数（配列）にmember_name(連番)のパラメータの値を格納
  def set_member_name
    self.class.member_name.clear
    self.class.member_name_keys = params[:group_member].keys.select { |key| key.to_s.start_with?("member_name") }
    self.class.member_name_keys.each do |name|
      self.class.member_name << params[:group_member][name]
    end
  end

  private

  def format_params
    member_names = params[:group_member].keys.select { |key| key.to_s.start_with?("member_name") } # member_name(連番)のキーを変数に格納
    permitted_params = [:group_name] + member_names
    params.require(:group_member).permit(permitted_params)
  end

  def group_params
    params.require(:group).permit(:group_id, :group_name, :token)
  end

  def member_params
    params.require(:member).permit(:member_id, :member_name, :group_id)
  end
end

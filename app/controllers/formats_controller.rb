class FormatsController < ApplicationController

  @@member_name = []

  def index
    @formats = Group.includes(:member)
  end

  def show
    @group = Group.find_by(token: params[:token])
    @members = Member.where(group_id: @group.group_id)
    @payments = Payment.where(group_id: @group.group_id)
  end

  def new
    @format = GroupMember.new
    # 新規作成するグループのIDを採番
    if Group.count == 0
      @group_id = 1
    else
      @group_id = Group.maximum(:group_id) + 1
    end
  end

  def create
    set_member_name
    GroupMember.create_member_accessors(get_member_name.count)
    @format = GroupMember.new(format_params)
    if @format.save(get_member_name)
      @group = Group.find(@format.group_id)
      redirect_to group_show_path(token: @group.token)
    else
      render "new"
    end
  end

  # クラス変数（配列）にmember_name(連番)のパラメータの値を格納
  def set_member_name
    @@member_name.clear
    member_name_key = params[:group_member].keys.select { |key| key.to_s.start_with?("member_name") }
    member_name_key.each do |name|
        @@member_name << params[:group_member][name]
    end
  end

  # クラス変数（配列）の値を取得
  def get_member_name
    @@member_name
  end

  private
  def format_params
    member_names = params[:group_member].keys.select { |key| key.to_s.start_with?("member_name") }#member_name(連番)のキーを変数に格納
    permitted_params = [:group_name, :group_id] + member_names
    params.require(:group_member).permit(permitted_params)
  end
end

module FormatsHelper
  def update_payments_info(member)
    @payments = Payment.where(group_id: member.group_id)
  end

  def get_members_info(member)
    @members = Member.where(group_id: member.group_id)
  end

  def get_search_info(member)
    @payments = Payment.where(group_id: member.group_id)
    @search = @payments.ransack(params[:q])
  end
end

module FormatsHelper
  def update_payments_info(member)
    Payment.where(group_id: member.group_id)
  end

  def get_members_info(member)
    Member.where(group_id: member.group_id)
  end

  def get_search_info(member)
    payments = Payment.where(group_id: member.group_id)
    payments.ransack(params[:q])
  end
end

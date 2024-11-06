class DeleteOldRecordsJob
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform
    Rails.logger.info "DeleteOldRecordsJob is running"
    # 作成日が60日以上前のグループのid一覧を取得
    ids = Group.where('created_at < ?', 60.days.ago).pluck(:group_id)

    # 作成日が60日以上前のグループのidに紐づく支払い明細を削除
    Payment.where(group_id: ids).destroy_all

    # 作成日が60日以上前のグループのidに紐づくメンバーを削除
    Member.where(group_id: ids).destroy_all

    # 作成日が60日以上前のグループを削除
    Group.where('created_at < ?', 60.days.ago).destroy_all
    Rails.logger.info "DeleteOldRecordsJob is completed"
  end
end

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe DeleteOldRecordsJob, type: :job do
  before do
    Sidekiq::Worker.clear_all # キューをクリア
    @group = FactoryBot.create(:group) # 最新の支払いデータ
    @group_to_be_deleted = FactoryBot.create(:group, :group_created_at_least_60_days_ago) # 60日以上前のデータ
  end

  context 'ジョブがキューに追加されるか確認する' do
    before { Sidekiq::Testing.fake! }

    it 'キューにジョブが追加されることを確認する' do
      expect do
        DeleteOldRecordsJob.perform_async
      end.to change(DeleteOldRecordsJob.jobs, :size).by(1)
    end
  end

  context 'ジョブが即時実行されるか確認する' do
    before { Sidekiq::Testing.inline! }

    it '60日以上経過したデータが削除されることを確認する' do
      expect do
        DeleteOldRecordsJob.perform_async
      end.to change { Group.exists?(@group_to_be_deleted.id) }.from(true).to(false)
    end

    it '最新のデータは削除されないことを確認する' do
      DeleteOldRecordsJob.perform_async
      expect(Group.exists?(@group.group_id)).to eq(true)
    end
  end
end

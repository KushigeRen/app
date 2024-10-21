require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class CalendarsController < ApplicationController
  def handle_oauth_callback
    amount, description, deadline, token = params[:state].split(',')

    params[:user_id] || 'default' # 必要に応じてデフォルト値
    code = params[:code]

    @calendar = Google::Apis::CalendarV3::CalendarService.new
    @calendar.client_options.application_name = ENV.fetch('GOOGLE_CALENDAR_APPLICATION_NAME')
    @calendar_id = 'primary'

    client_id = Google::Auth::ClientId.from_file(ENV.fetch('GOOGLE_CALENDAR_SECRET_PATH'))
    token_store = Google::Auth::Stores::FileTokenStore.new(file: ENV.fetch('GOOGLE_CALENDAR_TOKEN_PATH'))
    authorizer = Google::Auth::UserAuthorizer.new(client_id, Google::Apis::CalendarV3::AUTH_CALENDAR, token_store)
    user_id = 'default' # ユーザーの識別子（必要に応じて変更）

    # コードを使って認証トークンを取得し、保存
    credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code,
                                                                 base_url: ENV.fetch('GOOGLE_CALENDAR_REDIRECT_URI'))

    @calendar.authorization = credentials

    date = deadline
    summary = "#{amount}円の支払期日です。"
    description = "#{description}"
    location = ""
    start_time = Google::Apis::CalendarV3::EventDateTime.new(date: date)
    end_time = Google::Apis::CalendarV3::EventDateTime.new(date: date)

    create(
      summary: summary,
      description: description,
      location: location,
      start_time: start_time,
      end_time: end_time
    )

    flash[:notice] = "Googleカレンダーに支払い期日を登録しました。"
    redirect_to controller: :formats, action: :show, token: token
  rescue
    flash[:alert] = "Googleカレンダーに支払い期日を登録できませんでした。"
    redirect_to controller: :formats, action: :show, token: token
  end

  def build_event(summary:, description:, location:, start_time:, end_time:)
    Google::Apis::CalendarV3::Event.new(
      summary: summary,
      description: description,
      location: location,
      start: start_time,
      end: end_time
    )
  end

  def create(summary:, description:, location:, start_time:, end_time:)
    event = build_event(
      summary: summary, # String
      description: description, # String
      location: location, # String
      start_time: start_time, # DateTime.now
      end_time: end_time # DateTime.now + 1.hour
    )
    @calendar.insert_event(
      @calendar_id,
      event
    )
  end
end

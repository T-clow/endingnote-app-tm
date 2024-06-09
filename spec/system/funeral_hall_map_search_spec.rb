require 'rails_helper'

RSpec.describe '葬儀場マップ', type: :system, js: true do
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
    visit user_funeral_hall_map_search_index_path(user)
    dismiss_alert_if_present
  end

  it 'ページを訪れたときに現在地のMapsが表示されること' do
    expect(page).to have_css('#map', visible: true)
  end

  it '東京駅を入力して周辺の葬儀場のマップが更新されること' do
    fill_in 'address-input', with: '東京駅'
    find('button', text: 'MAPを更新').click
    expect(page).to have_css('#map', visible: true, wait: 10)
  end

  def dismiss_alert_if_present
    page.driver.browser.switch_to.alert.accept
  rescue Selenium::WebDriver::Error::NoSuchAlertError
  end
end

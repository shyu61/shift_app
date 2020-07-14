require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:fixed_user) }

  it 'signs up' do
    visit root_url

    expect(page).to have_link '新規登録'
    expect(page).to have_link 'ログイン'

    find('.top-form').click_link '新規登録'

    expect(current_path).to eq new_user_registration_path

    expect do
      fill_in 'ユーザー名', with: 'Sample User'
      fill_in 'メールアドレス', with: 'sample@gmail.com'
      fill_in 'パスワード', with: 'foobar'
      fill_in 'パスワード再入力', with: 'foobar'
      click_button 'サインアップ'
  
      expect(page).to have_css '.alert-info'
      expect(page).to have_content 'アカウント登録が完了しました。'
    end.to change(User, :count).by(1)
    expect(current_path).to eq user_path(User.last)
    expect(page).to have_content 'Sample User'
    expect(page).to have_link 'アカウント設定'
    expect(page).to have_link '社員シフト一覧'
    expect(page).to have_link '勤怠を入力する'
    expect(page).to have_button '提出'
  end

  it 'logs in and logs out' do
    visit root_url
    find('.top-form').click_link 'ログイン'

    expect(current_path).to eq new_user_session_path

    fill_in 'メールアドレス', with: 'fixed@user.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'

    expect(page).to have_content 'ログインしました。'
    expect(current_path).to eq user_path(user)
    expect(page).to have_content user.name
    expect(page).to have_link 'アカウント設定'
    expect(page).to have_link '社員シフト一覧'
    expect(page).to have_link '勤怠を入力する'
    expect(page).to have_button '提出'

    click_link 'ログアウト'

    expect(page).to have_content 'ログアウトしました。'
    expect(current_path).to eq root_path
  end

  context "user updates or deletes profile" do
    before do
      sign_in user
      visit user_path(user)
      find('.left-side-bar').click_link 'アカウント設定'
    end

    it 'updates name' do
      expect(current_path).to eq edit_user_registration_path
      expect(page).to have_field 'ユーザー名', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      
      fill_in '現在のパスワードを確認', with: 'password'
      fill_in 'ユーザー名', with: 'Updated Name'
      click_button '変更を保存'
      
      expect(page).to have_content 'アカウント情報を変更しました。'
      expect(current_path).to eq user_path(user)
      expect(user.reload.name).to eq 'Updated Name'
    end

    it 'updates password' do
      expect(page).to have_link 'パスワードを変更する'

      click_link 'パスワードを変更する'
      fill_in '現在のパスワードを確認', with: 'password'
      fill_in '新しいパスワード', with: 'newpass'
      fill_in '新しいパスワード再確認', with: 'newpass'
      click_button '変更を保存'

      expect(page).to have_content 'アカウント情報を変更しました。'
      expect(current_path).to eq user_path(user)
      expect(user.reload.valid_password?('newpass')).to be_truthy
    end

    it 'deletes my account', js: true do
      expect do
        expect(page).to have_link 'アカウントを削除する'
  
        click_link 'アカウントを削除する'
        page.driver.browser.switch_to.alert.accept
  
        expect(page).to have_content 'アカウントを削除しました'
        expect(current_path).to eq root_path
      end.to change(User, :count).by(-1)
    end
  end
end

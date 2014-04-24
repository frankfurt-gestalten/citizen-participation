module LoginHelper
  def sign_in(user)
    visit new_user_session_path
    within '#login-form' do
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => 'password'
      click_button "Anmelden"
    end
  end

  def user_should_be_signed_in
    page.should have_css '.login'
  end
end
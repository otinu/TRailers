module SignupSupport
  def sign_up_as(user)
    visit new_user_registration_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    check 'user[mine_open]'
    click_button '新規登録'
  end
  
  def sign_up_same_session(user)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session){ { id: 1 } }
    sign_up_as(user2)
  end
end

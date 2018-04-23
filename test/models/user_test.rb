require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(user_name: 'admin',
                     name: 'Admin',
                     last_name: 'Istrator',
                     email: 'admin@example.com',
                     last_activity: Time.now,
                     password: 'foobar',
                     password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'user_name should be present' do
    @user.user_name = '     '
    assert_not @user.valid?
  end

  test 'name should be present' do
    @user.name = '     '
    assert_not @user.valid?
  end

  test 'last_name should be present' do
    @user.last_name = '     '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert_not @user.valid?
  end

  test 'email should be valid' do
    @user.email = 'bad email@'
    assert_not @user.valid?
  end

  test 'email should be downcase' do
    mixed_email = 'UPemail@EXAMPLE.com'
    @user.email = mixed_email
    @user.save
    assert_equal @user.reload.email, mixed_email.downcase
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end

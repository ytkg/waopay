class CreateAdminUsersToUsers < ActiveRecord::Migration[5.1]
  def up
    User.new(id: -1, name: "登録ボーナス", password: 'hogefoobar', password_confirmation: 'hogefoobar').save(validate: false)
    User.new(id: -2, name: "ログインボーナス", password: 'hogefoobar', password_confirmation: 'hogefoobar').save(validate: false)
    User.new(id: -3, name: "友達紹介ボーナス", password: 'hogefoobar', password_confirmation: 'hogefoobar').save(validate: false)
  end

  def down
    User.find(-1).delete
    User.find(-2).delete
    User.find(-3).delete
  end
end

class CreateAdminUsersToUsers < ActiveRecord::Migration[5.1]
  def up
    User.create(id: -1, name: "wao:PAY運営", username: "登録ボーナス", password: 'hogefoobar', password_confirmation: 'hogefoobar')
    User.create(id: -2, name: "wao:PAY運営", username: "ログインボーナス", password: 'hogefoobar', password_confirmation: 'hogefoobar')
    User.create(id: -3, name: "wao:PAY運営", username: "お友達紹介ボーナス", password: 'hogefoobar', password_confirmation: 'hogefoobar')
  end

  def down
    User.find(-1).delete
    User.find(-2).delete
    User.find(-3).delete
  end
end

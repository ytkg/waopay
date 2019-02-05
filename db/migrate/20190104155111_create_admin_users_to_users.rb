class CreateAdminUsersToUsers < ActiveRecord::Migration[5.1]
  def up
    User.new(id: -1, name: "wao:Pay運営(登録ボーナス)", password: 'hogefoobar', password_confirmation: 'hogefoobar').save(validate: false)
    User.new(id: -2, name: "wao:Pay運営(ログインボーナス)", password: 'hogefoobar', password_confirmation: 'hogefoobar').save(validate: false)
    User.new(id: -3, name: "wao:Pay運営(お友達紹介ボーナス)", password: 'hogefoobar', password_confirmation: 'hogefoobar').save(validate: false)
  end

  def down
    User.find(-1).delete
    User.find(-2).delete
    User.find(-3).delete
  end
end

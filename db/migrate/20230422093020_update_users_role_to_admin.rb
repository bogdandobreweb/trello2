class UpdateUsersRoleToAdmin < ActiveRecord::Migration[7.0]
  def change
    User.update_all(role: "admin")
  end
end

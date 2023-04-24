class BoardPolicy < ApplicationPolicy

  def create?
    puts "current_user.role: #{user.role}"
    puts "requested action: create"
    user_admin_or_staff_or_manager?
  end

  def show?
    user_admin_or_staff_or_manager?
  end

  def update?
    user_admin_or_manager?
  end

  def destroy?
    user_admin?
  end

  private

  def user_admin?
    user.role.name == "admin"
  end

  def user_manager?
    user.role.name == "manager"
  end

  def user_staff?
    user.role.name == "staff"
  end

  def user_admin_or_manager?
    user_admin? || user_manager?
  end

  def user_admin_or_staff_or_manager?
    user_admin? || user_manager? || user_staff?
  end

end
  
=begin
  
add to the users:  admin(create, show, update, delete), manager(create, show,update), staff(create, show)

add roles > users > permissions > access controls
add permissions (new table) -> 
access controls (role_id, permission_id)

user.role(manager)

=end
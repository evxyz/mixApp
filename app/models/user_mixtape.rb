class UserMixtape < ActiveRecord::Base
  Permissions = {:own => 0, :edit => 10, :listen => 100}

  Permissions.each do |action, level|
    define_method "#{action}able?" do
      true if self.permission <= Permissions[action.to_sym]
    end
  end

  belongs_to :user
  belongs_to :mixtape

  def set_permission(permission)
    self.permission = Permissions[permission]
    self.save
  end

end

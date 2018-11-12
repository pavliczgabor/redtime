# noinspection RubyResolve,RubyClassModuleNamingConvention
class CreateDemoUser < ActiveRecord::Migration

  def self.up
    user = User.new("firstname" => "Felhasználó", "lastname" => "Demo", "status" => 1, "language" => "hu", "mail_notification" => "none", "salt" => "21cfba6223035807839efc718e9cf9fd", "must_change_passwd" => true)
    user.login = "demo"
    user.password = 'demo1234'
    user.password_confirmation = 'demo1234'
    user.mail = "user@user.null"
    user.admin = true
    user.custom_field_values = {UserCustomField.find_by(:name => "Munkaóra/Hét").id => 4}
    user.save!

    group = Group.create!({name: "Demo"})
    group.users << user
    group.save!

    Member.create_principal_memberships(Group.find_by(lastname: "Demo"),
                                        :project_ids => Project.all.pluck(:id),
                                        :role_ids => [Role.find_by(id: "3").id])

  end

  def self.down
    Group.destroy_all(lastname: "Demo")
    User.destroy_all(login: "demo")
  end
end

namespace :create_groups do
  desc "create_groups"
  task create_group: :environment do
    Group.delete_all
    user_lists = User.is_not_normal_user
    user_lists.each do |user|
      Group.create(user_id: user.id, name: "Group_#{user.name}")
    end
  end
end

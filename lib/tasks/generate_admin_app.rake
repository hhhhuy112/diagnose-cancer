namespace :generate_admin_app do
  desc "Auto generate data request state"
  task admin_user: :environment do
    User.create(name: "Admin", email: "admin@gmail.com", birthday: "20/11/1994", gender: "male", password: "123456", role: "admin")
  end
 end

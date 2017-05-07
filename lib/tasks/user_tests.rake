namespace :user_test do
  desc "user_test"
  task create_user: :environment do
    User.delete_all
    User.create(patient_code: "A0001" ,name: "Admin", email: "admin@gmail.com", birthday: "20/11/1994", gender: "male", password: "123456", role: "admin")
    (1..10).to_a.each do |index|
      User.create(patient_code: "P1234" + "#{index}" ,name: "Nguyen Van BN" + "#{index}", gender: :male, birthday: Date.today, email: "bn" + "#{index}" + "@gmail.com", password: "123456")
      User.create(patient_code: "D1234" + "#{index}" ,name: "Nguyen Van BS" + "#{index}", gender: :male, birthday: Date.today, email: "bs" + "#{index}" + "@gmail.com", password: "123456")
    end
  end
end

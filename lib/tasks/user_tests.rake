namespace :user_test do
  desc "user_test"
  task create_user: :environment do
    (1..10).to_a.each do |index|
      User.create(patient_code: "P1234" + "#{index}" ,name: "Nguyen Van BN" + "#{index}", gender: :male, birthday: Date.today, email: "bn" + "#{index}" + "@gmail.com", password: "123456")
    end
  end
end

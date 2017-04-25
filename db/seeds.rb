# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(patient_code: "A0001" ,name: "Admin", email: "admin@gmail.com", birthday: "20/11/1994", gender: "male", password: "123456", role: "admin")
Classification.create(name: "benign")
Classification.create(name: "malignant")
value = [1,2,3,4,5,6,7,8,9,10]
f = File.open("/home/ubuntu/datn/data/data.txt", "r")
count = 1
c =1
f.each_line do |line|
  data = line.split(",")
  if data.count == 11
    putc "#{c}"
    c++
    result = data[10].split("\n")[0] == "2" ? 1 : 2
    DataCancer.create(sample_code_number: data[0].to_i ,
      clump_thickness: data[1].to_i,
      uniformity_of_cell_size: data[2].to_i,
      uniformity_of_cell_shape: data[3].to_i ,
      marginal_adhesion: data[4].to_i,
      single_epithelial_cell_size: data[5].to_i,
      bare_nuclei: data[6].to_i,
      band_romatin: data[7].to_i,
      nomal_nucleoli: data[8].to_i,
      mitoses: data[9].to_i,
      classification_id: result.to_i)
  end
end
f.close

putc "create fiction"

fiction_file = File.open("/home/ubuntu/datn/data/data_fiction.txt", "r")
fiction_file.each_line do |line|
  name = line[0, line.length - 1]
  Fiction.create(name: name, description: "")
end
fiction_file.close

Fiction.all.each do |f|
  putc "create fiction"
  value.each do |v|
    ValueFiction.create(name: ("#{f.name}" +"#{v}").to_s, value: v, description: "", fiction_id: f.id)
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Classification.create(name: "benign")
Classification.create(name: "malignant")

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

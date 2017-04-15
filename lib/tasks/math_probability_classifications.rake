namespace :math_probability_classificaton do
  desc "math_probability_classificaton"
  task math_classifications: :environment do
    Classification.all.each do |classification|
      probability = (classification.data_cancers.count +1).to_f / (DataCancer.all.count + Classification.all.count)
      classification.update(probability: probability)
    end
  end
end

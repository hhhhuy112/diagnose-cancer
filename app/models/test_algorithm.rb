class TestAlgorithm < ApplicationRecord
  enum type_diagnose: {naise_bayes: 0, c45_algorithm: 1, id3_algorithm: 2}
  enum type_data: {training: 0, test: 1}
end

class DataUser < ApplicationRecord
  belongs_to :fiction, dependent: :destroy
  belongs_to :diagnose, optional: true, dependent: :destroy
end

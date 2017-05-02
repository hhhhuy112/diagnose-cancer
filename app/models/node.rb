class Node < ApplicationRecord
  serialize :parent_path, Array

  belongs_to :parent, class_name: Node.name, foreign_key: :closest_parent_id

  enum type_node: {root:1 , internal: 2, leaf: 3}

   scope :load_node_childs_of_node, ->node_id do
    if node_id.present?
      where("(parent_path LIKE '%- #{node_id}\n%')")
    end
  end

  scope :load_root, ->{where type_node: :root }
end

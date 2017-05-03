class ConvertDecisionTreeToRulesService
  def initialize nodes
    @nodes = nodes
    @list = []
  end

  def convert nodes, rule
    rule_internal = rule.dup
    nodes.each do |node|
      if node.leaf?
        rule_leaf = rule.dup
        rule_leaf.classification_id = node.attr_id
        rule_leaf.save
      else
        rule_internal = set_value_fiction node, rule_internal
        node_childs = Node.load_node_childs_of_node(node.id)
        if node_childs.present?
          convert node_childs, rule_internal
        end
      end
    end
    @list
  end

  def create_rules node_root, node_childs, rule

  end

  def set_value_fiction node, rule
    fiction = Fiction.find_by id: node.attr_id
    value_fiction = ValueFiction.find_by id: node.value_id
    case fiction.name
    when Settings.fiction.clump_thickness
      rule.clump_thickness = value_fiction.value
    when Settings.fiction.uniformity_of_cell_size
      rule.uniformity_of_cell_size = value_fiction.value
    when Settings.fiction.uniformity_of_cell_shape
      rule.uniformity_of_cell_shape = value_fiction.value
    when Settings.fiction.marginal_adhesion
      rule.marginal_adhesion = value_fiction.value
    when Settings.fiction.single_epithelial_cell_size
      rule.single_epithelial_cell_size = value_fiction.value
    when Settings.fiction.bare_nuclei
      rule.bare_nuclei = value_fiction.value
    when Settings.fiction.bland_chromatin
      rule.bland_chromatin = value_fiction.value
    when Settings.fiction.normal_nucleoli
      rule.normal_nucleoli = value_fiction.value
    when Settings.fiction.mitoses
      rule.mitoses = value_fiction.value
    else
      binding.pry
    end
    rule
  end


  # def convert nodes, rule
  #   nodes.each do |node_parent|
  #     node_childs = Node.load_node_childs_of_node(node_parent.id)
  #     rule = Rule.new if rule.nil?
  #     rule =  set_value_fiction node_parent, rule
  #     node_childs.each do |node_child|
  #       rule_instance = rule
  #       if node_child.leaf?
  #         rule_instance.classification_id = node_child.attr_id
  #         rule_instance.save
  #       elsif node_child.internal?
  #         rule_instance = set_value_fiction node_child, rule
  #         node_childs = Node.load_node_childs_of_node(node_parent.id)
  #         convert node_childs, rule_instance
  #       end
  #     end
  #   end
  # end

end

class ConvertDecisionTreeToRulesService
  def inittialize
  end

  def convert
    @node_roots = Node.load_root
    @node_roots.each do |node_root|
      node_childs = Node.load_node_childs_of_node(node_root.id)
      rule = Rule.new
      rule =  set_value_fiction node_root, rule
      create_rules node_root, node_childs, rule
    end
  end

  def create_rules node_root, node_childs, rule
    rule_instance = rule
    node_childs.each_with_index do |node_child, index|
      if node_child.leaf?
        rule_instance.classification_id = node_child.attr_id
        rule_instance.save
        node_childs.delete(node_child)
      elsif node_child.internal?
        rule_instance = set_value_fiction node_child, rule
        node_childs.delete(node_child)
      end
    end
    if node_childs.present?
      create_rules node_root, node_childs, rule
    end
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
      rule.band_romatin = value_fiction.value
    when Settings.fiction.normal_nucleoli
      rule.nomal_nucleoli = value_fiction.value
    when Settings.fiction.mitoses
      rule.mitoses = value_fiction.value
    else
      binding.pry
    end
    rule
  end

end

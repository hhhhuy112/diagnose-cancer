class CreateRulesDecisionTreeService
  def initialize classifications, data_cancers
    @classifications = classifications
    @abc = ""
    @array_special_fictions = []
  end

  def c45_algorithm data_cancers, fictions
    arr_classification = get_classification data_cancers
    putc "asdsas" + "#{data_cancers.count}"
    if arr_classification.count == 1

      #tao nut root cua cay quyet dinh
      #node[:classification] = arr_classification.first
      @abc +=   "node-la:" + "#{arr_classification.first}"  + "\n"
      @abc += "-------------------------------------end-node------------------------------------ \n"
      return

    elsif fictions.blank?

      classification_max = get_classification_max data_cancers
      #node[:classification] = classification_max.name
      @abc +=  "node_la: #{classification_max.name} " + "\n"
      @abc += "-------------------------------------end-node------------------------------------ \n"
      return

    else
      infor_fiction_service = MathInforFictionService.new data_cancers, @classifications, fictions
      # lay best attribute
      best_attribute = infor_fiction_service.get_best_fiction
      @array_special_fictions << best_attribute.id
      # xoa best_attribute
      fictions_v = Fiction.not_into_ids(@array_special_fictions.uniq)
      #voi moi v thuoc best_attribute
      @abc += "-------------------------------------start-node------------------------------------ \n"
      @abc += "-------------------------------------nhanh"+ "#{best_attribute.name}" + "------------------------------------\n"
      best_attribute.value_fictions.each do |value_fiction|
        @abc +=  "\n \n value of #{best_attribute.name}" + "#{value_fiction.value}----- \n"
        data_cancers_v =  infor_fiction_service.get_data_cancers_for_fiction best_attribute, value_fiction
        if data_cancers_v.blank?
          return
        else
          c45_algorithm(data_cancers_v, fictions_v)
        end
      end
    end
    @abc
  end


  def get_classification_max data_cancers
    @classifications.max_by do |classification|
        data_cancers.count{|data_cancer| data_cancer.classification_id ==  classification.id}
      end
  end

  def get_classification data_cancers
    data_cancers.pluck(:classification_id).uniq
  end


  # def c45_algorithm data_cancers, fictions
  #   arr_classification = get_classification data_cancers
  #   if arr_classification.count == 1
  #     #tao nut root cua cay quyet dinh
  #     #node[:classification] = arr_classification.first
  #     @abc +=   "lop:" + "#{arr_classification.first}"  + "\n"
  #     @abc += "-------------------------------------end-node------------------------------------ \n"
  #     #@list.push(["classification", arr_classification.first])
  #     return
  #   elsif fictions.blank?

  #     classification_max = @classifications.max_by do |classification|
  #       data_cancers.count{|data_cancer| data_cancer.classification_id ==  classification.id}
  #     end
  #     #node[:classification] = classification_max.name
  #     @abc +=  "lop_nhieu: #{classification_max.name} " + "\n"
  #     @abc += "-------------------------------------end-node------------------------------------ \n"
  #     #@list.push(["classification", classification_max.id])
  #     return
  #   else
  #     # lay best attribute
  #     best_attribute = get_best_fiction(fictions, data_cancers)
  #     # xoa best_attribute
  #     @array_special_fictions << best_attribute
  #     fictions_v = Fiction.not_into_ids(@array_special_fictions.pluck(:id))
  #     #voi moi v thuoc best_attribute
  #     @abc += "-------------------------------------start-node------------------------------------ \n"
  #     @abc += "-------------------------------------nhanh"+ "#{best_attribute.name}" + "------------------------------------\n"
  #     best_attribute.value_fictions.each do |value_fiction|
  #       @abc +=  "\n \n value of #{best_attribute.name}" + "#{value_fiction.value}----- \n"
  #       #@list.push([best_attribute.name, value_fiction.value])
  #       data_cancers_v =  get_data_cancers_for_fictions best_attribute, value_fiction.value
  #       c45_algorithm(data_cancers_v, fictions_v)
  #     end
  #   end
  #   @list
  # end

end

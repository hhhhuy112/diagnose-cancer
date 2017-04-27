class AssignUserService
  def create user_ids, group, message_error
    array_user_id_temp = []
    if user_ids[0].blank?
      user_ids = user_ids.drop(1)
    end
      import_user_group user_ids, array_user_id_temp, group
    {success: true}
  rescue StandardError
    {
      success: false,
      error: message_error
    }
  end

  def destroy user_ids, group, message_error
    group.user_ids -= user_ids.map(&:to_i)
    {success: true}
  rescue StandardError
    {
      success: false,
      error: message_error
    }
  end

  def import_user_group user_ids, array_user_id_temp, group
    user_ids.each do |user_id|
      array_user_id_temp << UserGroup.new(group_id: group.id, user_id: user_id)
    end
    UserGroup.import array_user_id_temp
  end
end

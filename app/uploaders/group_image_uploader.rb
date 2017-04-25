class GroupImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_limit: [400, 400]

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base
      .helpers
      .asset_path([version_name, "group_default.gif"].compact.join("_"))
  end

  def extension_white_list
    Settings.image_types.to_h.values
  end
end

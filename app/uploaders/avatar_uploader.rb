# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_limit: [400, 400]
  process convert: "png"

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base
      .helpers
      .asset_path([version_name, "user_avatar_default.png"].compact.join("_"))
  end

  version :standard do
    process resize_to_fill: [128, 128, :north]
  end

  version :medium do
    resize_to_fit 400, 400
  end

  version :thumbnail do
    resize_to_fit 64, 64
  end

  version :extra_small do
    resize_to_fit 32, 32
  end

  def extension_white_list
    Settings.image_types.to_h.values
  end
end

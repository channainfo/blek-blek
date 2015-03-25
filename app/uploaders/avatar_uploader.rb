# encoding: utf-8

class AvatarUploader < Uploader

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    ActionController::Base.helpers.asset_path("fallback/avartar/" + [version_name, "default.png"].compact.join('_'))
  end

  # Process files as they are uploaded:
  # process resize_to_fit: [800, 800]

  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  version :standard do
    resize_to_fit(600, 600)
  end

  version :medium, from_version: :standard do
    process resize_to_fit: [400, 400]
  end

  version :thumb do
    process crop: [150, 150]
  end

  def crop(width, height)
    if model.crop_x.present?
      resize_to_fit(600, 600)
      x = model.crop_x
      y = model.crop_y
      w = model.crop_w
      h = model.crop_h

      manipulate! do |img|
        img.crop "#{w}x#{h}+#{x}+#{y}"
        img
      end
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   original_filename ? "#{model.imageable_id}-#{original_filename}" : model.id
  # end
end

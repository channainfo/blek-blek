CarrierWave.configure do |config|

  config.aws_credentials = {
    access_key_id:     ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET']
  }

  config.storage    = :aws
  config.aws_bucket = ENV['FOG_DIRECTORY']
  config.aws_acl    = :public_read
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365


  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false

  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  elsif Rails.env.development?
    config.storage = :file
  end
  
end
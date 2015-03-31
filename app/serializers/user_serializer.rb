class UserSerializer < ActiveModel::Serializer
  attributes :full_name, :email, :user_name, :profile_images

  def profile_images
    { 
      thumb: object.avatar.thumb.url,
      medium: object.avatar.medium.url,
      standard: object.avatar.standard.url
    }
  end
end
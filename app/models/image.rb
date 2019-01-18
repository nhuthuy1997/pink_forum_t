class Image < ApplicationRecord
  mount_uploader :link, ImageUploader

  belongs_to :user

  before_save :flag_off_current_avatar

  private

  def change_avatar params
    self.current_avatar = true
    self.save
  end

  private

  def flag_off_current_avatar
    return unless self.current_avatar
    current_avatar = self.user.avatar.current_avatar = false
    current_avatar.save
  end
end

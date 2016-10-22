class Item < ActiveRecord::Base
  belongs_to :admin
  belongs_to :category
  mount_uploader :image, ImageUploader


  def cart_action(current_admin_id)
    if $redis.sismember "cart#{current_admin_id}", id
      "Remove from"
    else
      "Add to"
    end
  end
end

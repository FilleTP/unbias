class AddImageCloudinaryToSearch < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :img_cloudinary, :string
  end
end

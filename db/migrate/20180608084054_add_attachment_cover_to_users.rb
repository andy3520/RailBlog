class AddAttachmentCoverToUsers < ActiveRecord::Migration[5.2]
  def change
    add_attachment :users, :cover
  end
end

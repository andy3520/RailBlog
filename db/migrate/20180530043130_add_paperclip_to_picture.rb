class AddPaperclipToPicture < ActiveRecord::Migration[5.2]
  def change
    add_attachment :pictures, :image
  end
end

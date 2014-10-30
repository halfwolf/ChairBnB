class AddAttachmentPicToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.attachment :pic
    end
  end

  def self.down
    remove_attachment :pictures, :pic
  end
end

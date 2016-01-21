class RenameSubmitterIdColumn < ActiveRecord::Migration
  def change
    rename_column :shortened_urls, :user_id, :submitter_id
  end
end

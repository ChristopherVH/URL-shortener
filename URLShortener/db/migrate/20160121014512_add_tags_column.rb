class AddTagsColumn < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :tags, :string
  end
end

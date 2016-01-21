class RenameShortUrlColumn < ActiveRecord::Migration
  def change
    rename_column :shortened_urls, :shortened_url, :short_url
  end
end

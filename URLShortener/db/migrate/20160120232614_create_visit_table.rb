class CreateVisitTable < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.integer :shortened_url_id
      t.timestamps
    end

    def change_table
      add_column(:shortened_urls, :created_at, :datetime)
      add_column(:shortened_urls, :updated_at, :datetime)
    end
  end
end

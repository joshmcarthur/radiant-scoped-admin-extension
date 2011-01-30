class AddSites < ActiveRecord::Migration
  def self.up
    [:layouts, :snippets, :users, :pages, :roles].each do |table|
      add_column table, :site_id, :integer
    end
  end

  def self.down
    [:layouts, :snippets, :users, :pages, :roles].each do |table|
     remove_column table, :site_id
    end
  end
end

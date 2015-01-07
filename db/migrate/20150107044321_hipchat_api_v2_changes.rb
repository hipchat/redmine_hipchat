class HipchatApiV2Changes < ActiveRecord::Migration
  def change
    add_column :projects, :hipchat_endpoint, :string, :default => "", :null => false
  end
end

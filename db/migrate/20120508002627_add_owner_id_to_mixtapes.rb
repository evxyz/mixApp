class AddOwnerIdToMixtapes < ActiveRecord::Migration
  def change
    add_column :mixtapes, :owner_id, :integer

  end
end

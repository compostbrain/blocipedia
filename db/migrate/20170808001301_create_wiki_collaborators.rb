class CreateWikiCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :wiki_collaborators do |t|
      t.references :user, foreign_key: true
      t.references :wiki, foreign_key: true

      t.timestamps
    end
  end
end

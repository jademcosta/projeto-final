class CreatePublications < ActiveRecord::Migration
  def change
    add_column :inputs, :link, :string
    add_column :inputs, :language, :string
    add_column :inputs, :doi, :string
    add_column :inputs, :bibtex, :text
  end
end

class MakeShoutsPolymorphic < ActiveRecord::Migration[5.2]
  # redefine models inside of this class (this will look inside this class first instead of looking at our existing Shout class).
  class Shout < ApplicationRecord
    # this association allows us to make the reference to content below.
    belongs_to :content, polymorphic: true
  end
  class TextShout < ApplicationRecord; end

  def change
    change_table(:shouts) do |t|
      t.string :content_type
      t.integer :content_id
      t.index [:content_type, :content_id]
    end

    reversible do |dir|
      # reset the columns in case the columns are cached (we don't have the appropriate columns possibly).
      Shout.reset_column_information
    # now make it so each of our current shouts will have the proper content_type and content_id
      Shout.find_each do |shout|
        dir.up do
          text_shout = TextShout.create(body: shout.body)
          shout.update(content_id: text_shout.id, content_type: "TextShout")
        end
        dir.down do
          shout.update(body: shout.content.body)
          shout.content.destroy
        end
      end
    end

    #remove existing body column.
    remove_column :shouts, :body, :string
  end
end

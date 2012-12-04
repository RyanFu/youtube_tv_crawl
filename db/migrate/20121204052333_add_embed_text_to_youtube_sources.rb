class AddEmbedTextToYoutubeSources < ActiveRecord::Migration
  def change
    add_column :youtube_sources, :embed_text, :text
  end
end

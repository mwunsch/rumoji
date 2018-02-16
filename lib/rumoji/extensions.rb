class ApplicationRecord
  def self.stores_emoji_characters(*attributes)
    return unless table_exists?

    Rumoji::Mixin.inject_methods(self, attributes)
  end
end
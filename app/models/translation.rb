class Translation < ActiveRecord::Base
  attr_accessible :source_text, :target_translation, :reverse_translation
end

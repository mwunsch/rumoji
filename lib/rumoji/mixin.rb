module Rumoji
  module Mixin
    def self.inject_methods(model, attributes)
      attributes.each do |attribute|
        model.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          before_save do
            unless respond_to?("#{attribute}=")
              raise ArgumentError.new('#{model} must respond to #{attribute}= in order for Rumoji to store emoji.')
            end

            self.#{attribute} = Rumoji.encode(self.#{attribute})
            true
          end

          def #{attribute}
            Rumoji.decode(super)
          end
        RUBY
      end
    end
  end
end
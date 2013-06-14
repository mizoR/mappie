require "mappie/version"

module Mappie
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def mappie(method_name, options={})
      method_name  = method_name.to_sym
      foreign_key  = options[:foreign_key] || "#{method_name}_id".to_sym
      primary_key  = options[:primary_key] || :id
      class_name   = options[:class_name]  || "#{method_name}".capitalize

      define_method method_name do
        klass = Object.const_get class_name
        klass.find { |source|
          source.send(primary_key) == self.send(foreign_key)
        }
      end
    end
  end
end

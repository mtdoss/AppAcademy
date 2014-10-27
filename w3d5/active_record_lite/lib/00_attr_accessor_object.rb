class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|

      define_method "#{name}" do
        ivar_name = "@#{name}"
        instance_variable_get(ivar_name)
      end

      define_method "#{name}=" do |val|
        ivar_name = "@#{name}"
        instance_variable_set(ivar_name, val)
      end
    end
  end
end
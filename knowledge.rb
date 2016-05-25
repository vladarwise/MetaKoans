class Module
  def attribute val, &block
    val, default = val.first if val.is_a? Hash
    define_method(val) do
      return instance_variable_get "@#{val}" if instance_variable_defined?("@#{val}")
      send("#{val}=", block_given? ? instance_eval(&block) : default)
    end
    define_method("#{val}=") { |value| instance_variable_set("@#{val}", value) }
    define_method(:"#{val}?") { send(val) }
  end
end

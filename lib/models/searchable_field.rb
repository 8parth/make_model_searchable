class SearchableField
	attr_accessor :name, :field_type, :association_name, :associated_klass
	
	def initialize(name, field_type, association_name, associated_klass)
    @name = name
    @field_type = field_type
    @association_name = association_name
    @associated_klass = associated_klass
  end
end
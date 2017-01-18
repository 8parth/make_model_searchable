require "make_model_searchable/version"
require 'active_record'
require 'models/searchable_field'

module MakeModelSearchable

	def searchable_attributes(*options)
    # self.connection
    joined_options = options.select{ |option| option.is_a? (Hash) }
    options = options.select{ |option| !option.is_a?(Hash) }
    setup_fields(options)
    if joined_options.present?
      setup_joined_fields(joined_options)
    end
    self.extend(ClassMethods)
  end

  def setup_joined_fields(options_array)
    joined_fields = []
    association_names = self.reflect_on_all_associations.map(&:name)
    valid_opts = options_array.first.select {|k,v| association_names.include?(k)  }
    searchable_fields = []

    valid_opts.each do |key, val|
      assoc =  self.reflect_on_association(key)
      joined_fields << get_valid_joined_fields(key, val)
      joined_fields.flatten.each do |f|
        searchable_fields << SearchableField.new(f.name, f.type, assoc.name,  assoc.klass)
      end
    end
    self.instance_variable_set(:@joined_fields, searchable_fields.flatten) if searchable_fields.present?
  end

  def setup_fields(options)
    unless options.present?
      options = self.column_names
    end
    valid_fields = get_valid_fields(options)
    self.instance_variable_set(:@selected_fields, valid_fields)
  end

  def get_valid_fields(options)
    column_names = self.columns.map(&:name)
    column_types = self.columns.map(&:type)
    searchable_columns = []
    if column_names.length == column_types.length
      column_names.each_with_index do |column_name, index|
        searchable_columns << column_name if column_types[index].to_sym == :string 
      end
    end
    if searchable_columns.present?
      valid_fields = options.select{ |option| searchable_columns.include?(option.to_s) }
    else
      valid_fields = []
    end
    valid_fields
  end

  def get_valid_joined_fields(key, columns_array)
    associated_model = self.reflect_on_association(key).klass
    associated_model.connection
    if columns_array.empty?
      valid_joied_fields = associated_model.columns.select{ |col| col.type == :string or col.type == :text }
    else
      valid_joied_fields = associated_model.columns.select{ |col| (col.type == :string or col.type == :text) and columns_array.include?(col.name.to_sym) }
    end
    valid_joied_fields
  end

  module ClassMethods 
    def search(search_term)
      valid_fields = self.instance_variable_get(:@selected_fields)
      joined_fields = self.instance_variable_get(:@joined_fields)
      
      if valid_fields.present?
        if search_term
          search_term = "%#{search_term.downcase}%"
          own_table = self.arel_table
          arel_node = Arel::Nodes::Node.new
          valid_fields.each_with_index do |val, index|
            if index == 0
              arel_node = own_table[val].lower.matches(search_term)
            else
              arel_node = arel_node.or(own_table[val].lower.matches(search_term))
            end
          end
          join_table_names = []
          
          if joined_fields.present?
            joined_fields.each do |field|
              associated_relation = field.associated_klass.arel_table
              join_table_names << field.association_name
              if arel_node.present?
                arel_node = arel_node.or(associated_relation[field.name].lower.matches(search_term))
              else
                arel_node = associated_relation[field.name].lower.matches(search_term)
              end
            end
          end

          joins(join_table_names).where(arel_node)
        else
          all
        end
      else
        raise Exception,  "Please pass valid attributes for class: #{self.name}"
      end
    end
  end
  ActiveRecord::Base.extend MakeModelSearchable
end

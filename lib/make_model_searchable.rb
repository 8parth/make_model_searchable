require "make_model_searchable/version"
require 'active_record'

module MakeModelSearchable

	def searchable_attributes(*options)
    options = options.collect{ |option| option.to_s }
    self.connection
    setup_fields(options)
    self.extend(ClassMethods)
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
      options.select{ |option| searchable_columns.include?(option) }
    else
      options = []
    end
    options
  end

  module ClassMethods 
    def search(search_term)
      valid_fields = self.instance_variable_get(:@selected_fields)
      if valid_fields.present?
        if search_term
          search_term = "%#{search_term.downcase}%"
          users = self.arel_table
          arel_node = Arel::Nodes::Node.new
          valid_fields.each_with_index do |val, index|
            if index == 0
              arel_node = users[val].lower.matches(search_term)
            else
              arel_node = arel_node.or(users[val].lower.matches(search_term))
            end
          end
          where(arel_node)
        else
          all
        end
      else
        raise Exception,  "Please pass valid attributes for class: #{self.name}"
      end
    end

    # def get_valid_fields(fields)
    #   column_names = self.columns.map(&:name)
    #   column_types = self.columns.map(&:type)
    #   fields.reject { |element| !column_names.include?(element) or column_types[element].type != :string }
    # end

    # def get_join_fields(fields, associations)
    #   # self.reflect_on_association(:emails).class_name.constantize.column_names
    #   column_names = []
    #   associations.each do |association_name|
    #     # association_name
    #     column_names << self.reflect_on_association(association_name).class_name.constantize.column_names
    #   end
    #   column_names.flatten!
    #   column_names.uniq!

    #   fields.reject { |element| !column_names.include?(element) }
    # end

    # def get_valid_associations(associations)
    #   associations.collect! { |assoc| assoc.to_sym }
    #   association_names = self.reflect_on_all_associations.collect{|assoc| assoc.name  }
    #   associations.reject { |element| !association_names.include?(element) }
    # end
  end
  ActiveRecord::Base.extend MakeModelSearchable
end

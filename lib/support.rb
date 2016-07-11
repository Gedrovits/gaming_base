module TestCoverage
  class Support
    def self.save_as_factory(model, overwrite = false)
      max_column_length = model.column_names.max_by(&:length).length
      filter = %w(id created_at updated_at)
      
      output = ''
      output += "FactoryGirl.define do\n"
      output += "  factory :#{model.name.underscore} do\n"
      model.columns.each do |column|
        next if filter.include?(column.name)
        spaces_count = ((max_column_length - column.name.length) + 2)
        example_data = column.default || example_data_for_column(column.name, column.type)
        output += "    #{column.name}#{ ' ' * spaces_count }#{example_data}\n"
      end
      output += "  end\n"
      output += "end\n"
      
      file_name = "#{Rails.root}/spec/factories/#{model.name.underscore}.rb"
      
      if File.exists?(file_name) && overwrite === false
        puts 'File already exists!'
      else
        File.open(file_name, 'w') {|f| f.write(output) }
        puts 'File successfully created!'
      end
    end
    
    private
    
    def self.example_data_for_column(name, type)
      case type
      when :boolean  then name == 'active' ? 'true' : 'false'
      when :date, :datetime then '{ Date.today }'
      when :integer  then '1'
      when :string   then name == 'comments' ? 'nil' : "''"
      when :text     then name == 'metadata' ? '[]' : 'nil'
      else 'nil'
      end
    end
  end
end

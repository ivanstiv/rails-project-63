require_relative "hexlet_code/version"
require_relative "hexlet_code/tag"
module HexletCode
  def self.form_for(object, url: '#', **attributes, &block)
    form_attributes = { action: url, method: 'post' }.merge(attributes)
    builder = TagBuilder.new(object)
    form_content = block_given? ? yield(builder) : ''
    builder.form_content = form_content

    HexletCode::Tag.build('form', form_attributes) { builder.form_content }
  end

  class TagBuilder
    attr_accessor :form_content

    def initialize(object)
      @object = object
      @form_content = ''
    end

    def input(name, **options)
      value = @object.public_send(name).to_s
      
      if options[:as] == :text
        options.delete(:as)
        @form_content += HexletCode::Tag.build('textarea', name: name, **options) { value }
      else
        options = { type: 'text', name: name, value: value }.merge(options)
        @form_content += HexletCode::Tag.build('input', options)
      end
    end
     module InputHelper
  def input(prompt = "> ", as: :string)
    print prompt
    user_input = gets.chomp

    case as
    when :string
      user_input
    when :integer
      user_input.to_i
    when :float
      user_input.to_f
    when :array
      user_input.split
    when :boolean
      user_input.downcase == "true" || user_input.downcase == "yes"
    else
      raise ArgumentError, "Unsupported type: #{as}"
    end
  end
end

    module InputHelper
       class Form
    def initialize
      @fields = {}
      @submitted = false
    end

    def inputy(name, label: nil, as: :string, **options)
      label ||= name.to_s.capitalize
      prompt = "#{label}: "
      
      value = InputHelper.input(prompt, as: as, **options)
      @fields[name] = value
    end

     def submit
      @submitted = true
      @fields
    end

    def submitted?
      @submitted
    end

    def [](name)
      @fields[name]
    end
  end

   def form
    Form.new
  end
end

  def inputil(prompt = "> ", as: :string)
    print prompt
    user_input = gets.chomp

    case as
    when :string
      user_input
    when :integer
      user_input.to_i
    when :float
      user_input.to_f
    when :array
      user_input.split
    when :boolean
      user_input.downcase == "true" || user_input.downcase == "yes"
    else
      raise ArgumentError, "Unsupported type: #{as}"
    end
  end
end


    def submit(value = 'Save')
      @form_content += HexletCode::Tag.build('input', type: 'submit', value: value)
    end
  end
end
  class Error < StandardError; end

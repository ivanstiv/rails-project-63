require_relative "hexlet_code/version"
require_relative "hexlet_code/tag"

module HexletCode
  autoload(:FormBuilder, 'hexlet_code/form_builder')
  autoload(:FormRenderer, 'hexlet_code/form_renderer')
  autoload(:Tag, 'hexlet_code/tag')

  def self.form_for(object, attributes = {})
    builded_form = FormBuilder.new(object, **attributes)
    yield(builded_form) if block_given?
    FormRenderer.render_html(builded_form)
  end
end

    HexletCode::Tag.build('form', form_attributes) { builder.form_content }

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

    def submit(value = 'Save')
      @form_content += HexletCode::Tag.build('input', type: 'submit', value: value)
    end
  end

  module InputHelper
    def self.input(prompt = "> ", as: :string)
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
  end

  class Error < StandardError; end
end
require_relative "hexlet_code/version"
require_relative "hexlet_code/tag"

module HexletCode
  autoload(:FormBuilder, 'hexlet_code/form_builder')
  autoload(:FormRenderer, 'hexlet_code/form_renderer')
  autoload(:Tag, 'hexlet_code/tag')

  def self.form_for(object, attributes = {})
    builder = FormBuilder.new(object, **attributes)
    yield(builder) if block_given?
    FormRenderer.render_html(builder)
  end

  class FormBuilder
    attr_reader :form_body

    def initialize(object, attributes = {})
      @object = object
      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: {
          action: attributes.fetch(:url, '#'),
          method: attributes.fetch(:method, 'post')
        }.merge(attributes.except(:url, :method))
      }
    end

    def input(name, **options)
      @form_body[:inputs] << { name: name, options: options }
    end

    def submit(value = 'Save', **options)
      @form_body[:submit] = { options: options.merge(value: value) }
    end
  end

  class FormRenderer
    def self.render_html(builder)
      form_options = builder.form_body[:form_options]
      inputs = builder.form_body[:inputs]
      submit = builder.form_body[:submit]

      inputs_html = inputs.map do |input|
        name = input[:name]
        options = input[:options] || {}
        value = builder.object.public_send(name) rescue nil

        if options[:as] == :text
          HexletCode::Tag.build('textarea', name: name, **options.except(:as)) { value.to_s }
        else
          input_type = options.fetch(:as, 'text')
          HexletCode::Tag.build('input', type: input_type, name: name, value: value.to_s, **options.except(:as))
        end
      end.join

      submit_html = HexletCode::Tag.build('input', type: 'submit', **submit[:options])

      HexletCode::Tag.build('form', **form_options) do
        inputs_html + submit_html
      end
    end
  end
end
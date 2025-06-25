class FormBuilder
  attr_reader :form_body

  def initialize(object, attributes = {})
    @object = object
    
    action = attributes.fetch(:url, '#')
    method = attributes.fetch(:method, 'post')
    
    @form_body = {
      inputs: [],
      submit: { options: nil },
      form_options: { 
        action: action,
        method: method
      }.merge(attributes.except(:url, :method))
    }
  end

  def input(name, options = {})
    @form_body[:inputs] << { name: name, options: options }
  end

  def submit(value = 'Save', options = {})
    @form_body[:submit] = { options: options.merge(value: value) }
  end
end
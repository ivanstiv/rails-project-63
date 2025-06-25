module HexletCode
  class FormRenderer
    def self.render_html(form_builder)
      form_options = form_builder.form_body[:form_options]
      inputs = form_builder.form_body[:inputs]
      submit = form_builder.form_body[:submit]

      form_attrs = form_options.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
      form_start = "<form #{form_attrs}>"
      form_end = "</form>"

      inputs_html = inputs.map do |input|
        name = input[:name]
        options = input[:options] || {}
        
        input_type = options.fetch(:as, :input)
        
        case input_type
        when :input
          input_attrs = options.except(:as).map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
          "<input name=\"#{name}\" type=\"text\" #{input_attrs}>"
        when :textarea
          textarea_attrs = options.except(:as).map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
          "<textarea name=\"#{name}\" #{textarea_attrs}></textarea>"
        when :select
          select_options = options[:collection].map do |option|
            "<option value=\"#{option[:value]}\">#{option[:text]}</option>"
          end.join
          select_attrs = options.except(:as, :collection).map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
          "<select name=\"#{name}\" #{select_attrs}>#{select_options}</select>"
        else
          input_attrs = options.except(:as).map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
          "<input name=\"#{name}\" type=\"#{input_type}\" #{input_attrs}>"
        end
      end.join("\n")

      submit_html = if submit[:options]
                      submit_attrs = submit[:options].map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
                      "<input type=\"submit\" #{submit_attrs}>"
                    else
                      "<input type=\"submit\" value=\"Save\">"
                    end

      "#{form_start}\n#{inputs_html}\n#{submit_html}\n#{form_end}"
    end
  end
end
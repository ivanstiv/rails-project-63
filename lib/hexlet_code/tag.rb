module HexletCode
	class Tag
		  SINGLE_TAGS = %w[br hr img input].freeze

    def self.build(tag_name, attributes = {}, &block)
      attrs = attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
      
      if SINGLE_TAGS.include?(tag_name)
        "<#{tag_name}#{attrs}>"
      else
        content = block_given? ? yield : ''
        "<#{tag_name}#{attrs}>#{content}</#{tag_name}>"
      end
    end
  end
end
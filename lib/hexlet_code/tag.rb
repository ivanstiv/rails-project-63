	class Tag
		def self.build(name,content=nil,*attributes)
			attrs = attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
      attrs = " #{attrs}" unless attrs.empty?
      if content.nil? && block_given?
    content = yield
  end
   if content
    "<#{name}#{attrs}>#{content}</#{name}>"
  else
    "<#{name}#{attrs} />"
    end
  end
end
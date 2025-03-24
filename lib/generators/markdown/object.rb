# frozen_string_literal: true

module Generators
  class Markdown
    # Base generator of a json schema of type object
    class Object < Struct
      protected

      def additional_content
        out = []
        out << properties_table
        out << constants_tables if constants.any?
        out.join("\n")
      end

      def properties_table
        props = Terminal::Table.new
        props.headings = %w[Title Property Type Req. Description]
        props.style = { border: :markdown }
        props.rows = attributes

        <<~EOFMOD
        ## Properties

        #{props.to_s}
        EOFMOD
      end

      def constants_tables
        constants.map do |const|
          table = Terminal::Table.new
          table.headings = %w[Value Description]
          table.style = { border: :markdown }
          table.rows = const.enum.map { |key, desc| [(key.blank? ? "" : "`#{key}`"), desc&.to_s&.gsub(/[\r\n]+/, ' ')&.strip] }

          <<~EOFCONST
            ## #{const.title} Values

            #{table.to_s}
          EOFCONST
        end.compact.join("\n")
      end

      def attributes
        schema.properties.map { |name, property| attribute(name, property) }
      end

      def attribute(name, property)
        [
          property.title,
          "`#{name}`",
          type_string(property),
          !schema.optional?(name) ? 'true' : '',
          property.description&.split&.join(" "),
        ]
      end

      def constants
        @constants ||= schema.properties.values.select(&:enum?)
      end
    end
  end
end

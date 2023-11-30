# frozen_string_literal: true

module Generators
  class Markdown
    # Base generator of a json schema of type nil or string
    class Value < Struct
      def additional_content
        enum_constant
      end

      def enum_constant
        return unless enum?

        table = Terminal::Table.new
        table.headings = %w[Value Title Description]
        table.style = { border: :markdown }
        table.rows = enum_rows.map do |row|
          [row.const.blank? ? '' : "`#{row.const}`", row.title, row.description]
        end
        table.to_s

        <<~EOFCONST
          ## Values

          #{table}
        EOFCONST
      end

      def enum_rows
        @enum_rows ||=
          schema
          .composition
            &.entries
            &.filter(&:const?)
        # &.to_h { |e| [e.const, e.description.presence || e.title] }
      end

      def enum?
        enum_rows.present?
      end

      def strict_enum?
        enum? && schema.composition.entries.all?(&:const?)
      end
    end
  end
end

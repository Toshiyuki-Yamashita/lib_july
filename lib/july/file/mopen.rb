# frozen_string_literal: true

module July
  # File I/O
  module File
    refine Array do
      def open(...)
        each do |path|
          File.open(path, ...)
        end
      end
    end
  end
end

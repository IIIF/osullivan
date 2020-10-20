require File.join(File.dirname(__FILE__), '../service')

module IIIF
  module Presentation
    class AbstractResource < Service

      # Every subclass should override the following five methods where
      # appropriate, see Subclasses for how.
      def required_keys
        %w{ @type }
      end

      def any_type_keys # these are allowed on all classes
        %w{ label description thumbnail attribution license logo see_also
        related within }
      end

      def string_only_keys
        %w{ viewing_hint } # should any of the any_type_keys be here?
      end

      def array_only_keys
        %w{ metadata }
      end

      def abstract_resource_only_keys
        super + [ { key: 'service', type: IIIF::Service } ]
      end

      def hash_only_keys
        %w{ }
      end

      def int_only_keys
        %w{ }
      end

      # Not every subclass is allowed to have viewingDirect, but when it is,
      # it must be one of these values
      def legal_viewing_direction_values
        %w{ left-to-right right-to-left top-to-bottom bottom-to-top }
      end

      def legal_viewing_hint_values
        []
      end

      # Initialize a Presentation node
      # @param [Hash] hsh - Anything in this hash will be added to the Object.
      # @param [boolean] include_context (default: false). Pass true if the'
      #   context should be included.
      def initialize(hsh={})
        if self.class == IIIF::Presentation::AbstractResource
          raise "#{self.class} is an abstract class. Please use one of its subclasses."
        end
        super(hsh)
      end

      # Options:
      #  * force: (true|false). Skips validations.
      #  * include_context: (true|false). Adds the @context to the top of the
      #      document if it doesn't exist. Default: true.
      #  * sort_json_ld_keys: (true|false). Brings all properties starting with
      #      '@'. Default: true. to the top of the document and sorts them.
      def to_ordered_hash(opts={})
        include_context = opts.fetch(:include_context, true)
        if include_context && !self.has_key?('@context')
          self['@context'] = IIIF::Presentation::CONTEXT
        end
        super(opts)
      end

      # alias_method has to be included after to_ordered_hash is defined
      alias_method :as_json, :to_ordered_hash
      
    end
  end
end


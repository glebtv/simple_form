module SimpleForm
  module Inputs
    class CollectionSelectInput < CollectionInput
      def input
        if !options[:collection_options].blank?
          restricted_input_options = input_html_options.dup
          restricted_input_options.merge!(input_options.select{ |k,v| k.in?(:multiple, :disabled, :include_blank, :prompt) })

          template.select_tag("#{indexed_object_name}[#{attribute_name}]", options[:collection_options], restricted_input_options)
        else
          label_method, value_method = detect_collection_methods

          @builder.collection_select(
            attribute_name, collection, value_method, label_method,
            input_options, input_html_options
          )
        end
      end
    end
  end
end

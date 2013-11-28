module SimpleForm
  module Components
    module LabelInput
      extend ActiveSupport::Concern

      included do
        include SimpleForm::Components::Labels
      end

      def label_input
        apply_label_input_options(options)

        options[:label] == false ? input : (label + input)
      end

      private

      # Get the options given to the label_input component and apply to both
      # label and input components.
      def apply_label_input_options(options)
        return unless options[:label_input_html]
        label_input_defaults = options[:label_input_html].dup

        specific_defaults = {
          label_html: label_input_defaults.delete(:label_html) || {},
          input_html: label_input_defaults.delete(:input_html) || {}
        }

        [:input_html, :label_html].each do |key|
          options[key] ||= {}
          options[key] = specific_defaults[key].deep_merge(options[key])
          options[key] = label_input_defaults.deep_merge(options[key])
        end
      end

    end
  end
end

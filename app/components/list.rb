# frozen_string_literal: true

class List < Primer::Component
  HEADING_TAG_OPTIONS = [:h1, :h2, :h3, :h4, :h5, :h6].freeze
  HEADING_TAG_FALLBACK = :h2

  # Optional heading
  #
  # @param tag [Symbol] <%= one_of(List::HEADING_TAG_OPTIONS) %>
  # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
  renders_one :heading, lambda { |tag:, **system_arguments|
    system_arguments[:tag] = fetch_or_fallback(HEADING_TAG_OPTIONS, tag, HEADING_TAG_FALLBACK)
    system_arguments[:classes] = class_names(
      "List-heading",
      system_arguments[:classes]
    )

    Primer::BaseComponent.new(**system_arguments)
  }

  # Required list of navigational links
  #
  # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
  renders_many :items, lambda { |**system_arguments|
    deny_tag_argument(**system_arguments)
    system_arguments[:tag] = :span
    system_arguments[:classes] = class_names(
      "List-item",
      system_arguments[:classes]
    )

    Primer::BaseComponent.new(**system_arguments)
  }

  # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
  def initialize(**system_arguments)
    @system_arguments = deny_tag_argument(**system_arguments)
    @system_arguments[:tag] = :div
    @system_arguments[:classes] = class_names(
      "List",
      @system_arguments[:classes]
    )
  end

  def render?
    items.any?
  end
end

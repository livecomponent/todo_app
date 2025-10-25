# frozen_string_literal: true

class TodoItemComponent < ApplicationComponent
  include LiveComponent::Base

  serializes :todo_item, with: :model_serializer, attributes: [:text, :todo_list_id]

  attr_reader :todo_item, :editing

  def initialize(todo_item:, editing: false)
    @todo_item = todo_item
    @editing = editing
  end
end

# frozen_string_literal: true

class TodoListComponent < ApplicationComponent
  include LiveComponent::Base

  renders_many :todo_items, TodoItemComponent

  def initialize(todo_list:)
    @todo_list = todo_list
  end
end

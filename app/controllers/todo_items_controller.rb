# frozen_string_literal: true

class TodoItemsController < ApplicationController
  def update
    @todo_item = TodoItem.find(params[:id])
    @todo_item.update(todo_item_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: live.rerender(todo_item: @todo_item, editing: false)
      end
  end
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.create(todo_item_params)

    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: live.rerender(todo_list: @todo_list) do |todo_list_component|
          todo_list_component.with_todo_item(todo_item: @todo_item)
        end)
      end
    end
  end

  def destroy
    TodoItem.delete(params[:id])

    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: live.rerender do |todo_list_component|
          todo_list_component.todo_items.reject! do |todo_item_component|
            todo_item_component.todo_item.id == params[:id].to_i
          end
        end)
      end
    end
  end

  private

  def todo_item_params
    params.require(:todo_item).permit(:text)
  end
end

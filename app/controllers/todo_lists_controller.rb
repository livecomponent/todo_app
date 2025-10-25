# frozen_string_literal: true

class TodoListsController < ApplicationController
  def new
  end

  def index
    @todo_lists = TodoList.all
  end

  def create
    todo_list = TodoList.create(todo_list_params)
    redirect_to todo_list_path(todo_list)
  end

  def show
    @todo_list = TodoList.includes(:todo_items).find(params[:id])
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end
end

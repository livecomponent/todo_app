---
layout: default
title: Overview
nav_order: 1
---

<img src="logo/live_component_logo.svg" alt="live_component logo" style="width:400px;"/>

# What is this thing?

LiveComponent provides client-side rendering and state management for ViewComponent. It is intended to fulfill the same purpose as React, Angular, and other JavaScript frameworks while complimenting Hotwire and Rails' existing front-end tooling.

To opt-in, simply include `LiveComponent::Base` into your view component:

```ruby
class TodoItemComponent < ApplicationComponent
  include LiveComponent::Base

  def initialize(todo_item:, editing: false)
    @todo_item = todo_item
    @editing = editing
  end
end
```

Now, create todo_item_component.js in the same directory as todo_item_component.rb and define a controller:

```javascript
import { live, LiveController } from "@camertron/live-component";

@live("TodoItemComponent") // this is the Ruby class name
export class TodoItemComponent extends LiveController {
  edit() {
    this.render((component) => {
      component.props.editing = true;
    });
  }
}
```

In your component's template, render different content depending on the edit mode:

```erb
<% if @editing %>
  <%= form_with(model: @todo_item) do |f| %>
    <%= f.text_field :text %>
    <%= f.submit %>
  <% end %>
<% else %>
  <%= @todo_item.text %>
  <%= button_tag("Edit", data: { target: "click->todoitemcomponent#edit" }) %>
<% end %>
```

LiveComponent is built on top of Stimulus, so targets and actions work as expected. Clicking the "Edit" button next to each todo item will cause a text field to appear, allowing you to edit the item's text.

Behind the scenes, LiveComponent makes an HTTP request to the backend, renders the `TodoItemComponent` with the new state (i.e. `@editing = true`), and updates the page.

For a more complete showcase, including submitting changes back to the server, check out the full example on GitHub: [https://github.com/camertron/live_component_todo_app](https://github.com/camertron/live_component_todo_app)

# Why does this exist?

The complexity and fragmentation of the front-end landscape continues to grow, with even simple blogging sites now requiring byzantine build systems and megabytes of JavaScript just to display some text. Rendering is done entirely in JavaScript, leading to fragile pages and poor performance.

We've all experienced the consequences: instead of the content you were expecting, now you get a blank page with no explanation as to what went wrong. Clicking the submit button doesn't do anything. The JavaScript console is full of warnings and error messages pointing to minified, transpiled code in dependencies of dependencies. Nobody can explain why sourcemaps aren't working in development. The list goes on and on.

LiveComponent is an attempt to shift live updates to the server so you can re-render your view components by simply updating their state. It does so using tried-and-true technologies like HTTP, HTML, and a bit of JavaScript when necessary.

In this way, LiveComponent offers the same fidelity as frameworks like React but without large bundle sizes. Since LiveComponent "remembers" the state of your components, it can re-render them very quickly: on the order of ~50ms or less.

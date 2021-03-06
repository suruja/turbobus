# Turbobus

Real-time partial using MessageBus and Turbolinks 3.0.


## Installation

Add this line to your application's Gemfile:

    gem 'turbolinks', github: 'rails/turbolinks'
    gem 'turbobus', github: 'suruja/turbobus'

And then execute:

    $ bundle

## Usage


```ruby
# add to app/assets/javascripts/application.js
//= require turbobus

# add at the end of body tag of app/views/layouts/application.html.erb
<%= turbobus_include_tag %>

# on the server, use turbobus method in any controller action to send partial update
# to every client which subscribed to the key you provide below
turbobus [:key, :as, :array, :which, :may, :include, @record], partial: "path/to/partial"

# on the client, set id to a tag using the previous key
# in app/views/path/to/_partial.erb
<div id="<%= turbobus_id_for([:key, :as, :array, :which, :may, :include, @record])">
  <%= @record.value %>
</div>
```

## Example

In this example, we have one model `Counter` and we want to propagate a counter value update to
every clients viewing the current counter.

```ruby
# app/controllers/counters_controller.rb
def show
  @counter = Counter.find(params[:id])
end

def increase
  @counter = Counter.find(params[:id])
  @counter.value += 1
  @counter.save
  turbobus [:counters, @counter], partial: "counters/content"
  head :accepted
end

# app/views/counters/show.html.erb
<%= render partial: "counters/content" %>
<%= link_to "Increase counter", increase_counter_path(@counter), remote: true %>

# app/views/counters/_content.html.erb
<div id="<%= turbobus_id_for([:counters, @counter])">
  <%= @counter.value %>
</div>
```

The partial Turbobus send with `turbobus` method is the same for every clients. However if your partial needs to be evaluated on runtime for each specific user, you can pass a `path` instead of `partial` to force reloading the partial in context of the current user:

```ruby
# app/controllers/counters_controller.rb
def show
  @counter = Counter.find(params[:id])
end

def increase
  @counter = Counter.find(params[:id])
  @counter.value += 1
  @counter.save
  turbobus [:counters, @counter], path: 'counters/value'
  head :accepted
end

def value
  @counter = Counter.find(params[:id])
  render partial: 'counters/content'
end

# app/views/counters/show.html.erb
<%= render partial: "counters/content" %>
<%= link_to "Increase counter", increase_counter_path(@counter), remote: true %>

# app/views/counters/_content.html.erb
<div id="<%= turbobus_id_for({ channel: [:counters, @counter] })">
  <%= @counter.value %>
</div>
```

*Note: don't forget to add the `counters#likes` route in your routes file.*


Also you can pass an extra option `id` to `turbobus_id_for` helper in order to define multiple
synchronized HTML DOM nodes using the same Turbobus channel:

```ruby
# app/controllers/counters_controller.rb
def increase
  @counter = Counter.find(params[:id])
  @counter.value += 1
  @counter.save
  turbobus [:counters, @counter], partial: 'counters/contents'
  head :accepted
end

# app/views/counters/_contents.html.erb
<%= render partial: "counters/content", locals: { sequence_number: 1 } %>
<%= render partial: "counters/content", locals: { sequence_number: 2 } %>

# app/views/counters/_content.html.erb
<div id="<%= turbobus_id_for({ channel: [:counters, @counter], id: sequence_number })">
  <%= @counter.value %>
</div>

# app/views/counters/show.html.erb
<%= render partial: "counters/contents" %>
<%= link_to "Increase counter", increase_counter_path(@counter), remote: true %>
```

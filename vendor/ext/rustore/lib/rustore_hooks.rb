class RustoreHooks < Spree::ThemeSupport::HookListener
  insert_before :product_properties do
    %(
      <dl class="table-display">
      <% if @product.master.sku? %>
      <dt><%= t("sku") %></dt>
      <dd><%= @product.master.sku %></dd>
      <% end %>
    <% unless @product.has_variants? %>
      <% if @product.master.width? %>
      <dt><%= t("width") %></dt>
      <dd><%= @product.master.width %></dd>
      <% end %>
      <% if @product.master.height? %>
      <dt><%= t("height") %></dt>
      <dd><%= @product.master.height %></dd>
      <% end %>
      <% if @product.master.depth? %>
      <dt><%= t("depth") %></dt>
      <dd><%= @product.master.depth %></dd>
      <% end %>
     <% end %>
    </dl>)
  end
end
Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name: 'show_only_group_buy_checkbox',
  insert_after: '.form-group .checkbox.mt-2:last-child',
  partial: 'spree/admin/shared/show_only_group_buy_checkbox'
)
Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'group_buy_to_admin_sidebar',
  replace: '#sidebarOrder',
  partial: 'spree/admin/shared/group_buy_sidebar_menu'
)


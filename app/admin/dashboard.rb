ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    section 'Recent Orders' do
        table_for Order.order('created_at DESC').limit(5) do
            column :name
            column :total_price do |order|
                number_to_currency order.total_price
              end
              column :created_at do |order|
                time_ago_in_words order.created_at
              end
          end 
          strong {link_to 'View All Orders', admin_orders_path}
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    end # content
  end
end
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc { I18n.t("active_admin.dashboard") }

  content :title => proc { I18n.t("active_admin.dashboard") } do


    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Games" do
          table_for Game.order("started_at desc").limit(10) do
            column :type do |game|
              link_to game.game_type, [:admin, game]
            end
            column :rating do |game|
              status_tag "#{game.rating} points"
            end
            column :time_per_move do |game|
              "#{game.time_per_move} minutes"
            end
            column :started_at
          end
          strong { link_to "View All Games", admin_games_path }

        end
      end


      column do
        panel "Recently Registered Users" do
          table_for User.order("created_at desc").limit(10) do
            column :name do |user|
              link_to user.full_name, [:admin, user]
            end
            column :email
            column :provider do |user|
              user.provider ? "Came from #{user.provider}" : 'simple registration'
            end
            column :country do |user|
              status_tag(user.country)
            end
            column :created_at
          end
          strong { link_to "View All Users", admin_users_path }

        end
      end


    end

    columns do

      column do
        panel "Chart" do

          div do
            br
            text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>}.html_safe
          end
        end
      end

    end #
  end

end

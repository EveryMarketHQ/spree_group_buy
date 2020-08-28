module SpreeGroupBuy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      source_root File.expand_path('../../../templates', __FILE__)
      
      def copy_javascripts
        directory 'vendor'
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_group_buy'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bundle exec rails db:migrate'
        else
          puts 'Skipping rails db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end

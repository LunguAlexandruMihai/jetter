module Jetter
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../../templates', __FILE__)
      desc "Creates Jetter initializer for your application"

      def copy_initializer
        template "jetter.rb", "config/initializer/jetter.rb"
        puts "Install Complete! Put your api keys inside config/initializer/jetter.rb"
      end
    end

  end

end
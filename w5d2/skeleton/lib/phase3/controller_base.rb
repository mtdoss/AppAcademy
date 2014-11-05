require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      # res = ERB.new("<%= file %>").result(binding)
      #(something).eval(res)
      controller_name = self.class.to_s.underscore
      file_name = "views/#{controller_name}/#{template_name}.html.erb"
      file = File.read(file_name)
      
      res = ERB.new(file).result(binding)
      render_content(res, "text/html")
    end
  end
end

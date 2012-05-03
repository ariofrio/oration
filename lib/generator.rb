# Programmer: Chris Bunch
require 'fileutils'

require 'hair'

class Generator
  def self.generate_app(*args)
    Generator.new(*args).generate_app
  end
  
  # A list of languages that we can build Cicero-ready applications for. Right
  # now it's just Python and Go.
  #
  # TODO(cgb): Add Java support
  def self.supported_languages
    %w{py go}
  end

  attr_reader :file_name, :function_name, :output_dir, :app_id
  def initialize(file_name, function_name, output_dir, app_id)
    @file_name = file_name
    @function_name = function_name
    @output_dir = output_dir
    @app_id = app_id
  end

  # The language file suffix (e.g. "py") in which `file_name` is written.
  def file_suffix
   file_name.split('.').last 
  end
  alias :language :file_suffix 

  # The package name in which the function will be found.
  def package_name
    case language
    when 'py', 'go'
      File.basename(file_name, '.' + language)
    end
  end

  # This function finds out what language the application we need to make
  # 'Cicero-ready' is, and if it is a supported language, dispatches the
  # necessary function to do so. See `self.class.supported_languages` for the
  # currently supported languages.
  def generate_app
    if file_suffix.empty?  # no suffix
      abort("The file specified needs an extension.")
    end

    if !self.class.supported_languages.include?(file_suffix)
      abort("The file specified is not in a supported language. Supported " +
        "languages are #{self.class.supported_languages.join(', ')}")
    end

    # Create the boilerplate code (e.g. app.yaml, main.{go,py}, etc.)
    #
    # The templates are able to call instance methods of `self`. That's how we
    # pass information to them.
    Hair.render(File.join(File.dirname(__FILE__), "..", "templates", 
                          "appengine", language), output_dir, self)

    # Hair doesn't support files with dynamic paths, so we move such files
    # manually here.
    case language
    when 'go'
      Dir.chdir(output_dir) do
        Dir.mkdir(function_name)
        FileUtils.mv('main.go', function_name)
      end
    end

    # Copy over any files in the directory the user has given us over to the
    # new directory we are making for their App Engine app.
    FileUtils.cp_r(File.dirname(file_name) + "/.", output_dir)
  end
  
end


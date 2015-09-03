require 'thor'
require 'pathname'

module IosAnalytics
  class CLI < Thor
    include ::IosAnalytics::Translate
    desc 'translate', 'Exec Translate'
    option :data
    option :file
    option :appName, require: true
    option :derivedData, require: true
    def translate
      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')

      checkstyle = doc.add_element('checkstyle')

      path = Pathname.new(options[:derivedData])
        .join(
          'Build',
          'Intermediates',
          "#{options[:appName]}.build",
          '**',
          'StaticAnalyzer',
          '**',
          '*.plist'
        )
      Dir.glob(path).each do |plist_file|
        trans(checkstyle, plist_file)
      end

      formatter = REXML::Formatters::Pretty.new(4)
      formatter.write(doc, STDOUT)
    end
  end
end

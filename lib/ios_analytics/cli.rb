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
      doc = trans(options[:derivedData], options[:appName])

      formatter = REXML::Formatters::Pretty.new(4)
      formatter.write(doc, STDOUT)
    end
  end
end

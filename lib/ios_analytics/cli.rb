require 'thor'

module IosAnalytics
  class CLI < Thor
    include ::IosAnalytics::Translate
    desc 'translate', 'Exec Translate'
    option :data
    option :file
    # path = '/Users/ishikuranoboru/.ghq/github.com/noboru-i/kyouen-ios/derivedData/Build/Intermediates/TumeKyouen.build/**/StaticAnalyzer/**/*.plist'
    option :derivedData, default: '/Users/ishikuranoboru/.ghq/github.com/noboru-i/ios_analytics/samples/*.plist'
    def translate
      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')

      checkstyle = doc.add_element('checkstyle')

      path = options[:derivedData]
      Dir.glob(path).each do |plist_file|
        trans(checkstyle, plist_file)
      end

      formatter = REXML::Formatters::Pretty.new(4)
      formatter.write(doc, STDOUT)
    end
  end
end

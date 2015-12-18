require 'plist'
require 'rexml/document'

module IosAnalytics
  module Translate
    def trans(derived_data, app_name)
      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')

      checkstyle = doc.add_element('checkstyle')

      path = Pathname.new(derived_data)
        .join(
          'Build',
          'Intermediates',
          "#{app_name}.build",
          '**',
          'StaticAnalyzer',
          '**',
          '*.plist'
        )
      Dir.glob(path).each do |plist_file|
        trans_file(checkstyle, plist_file)
      end

      unless checkstyle.has_elements?
        IosAnalytics::Translate.add_dummy(checkstyle)
      end

      doc
    end

    def trans_file(checkstyle_dom, plist_file)
      result = Plist::parse_xml(plist_file)
      return checkstyle_dom if result['files'].empty?

      file_path = result['files'][0]
      result['diagnostics'].each do |diagnostics|
        create_element(checkstyle_dom, file_path, diagnostics)
      end

      checkstyle_dom
    end

    def create_element(checkstyle_dom, file_path, diagnostics)
      file = checkstyle_dom.add_element('file',
                                        'name' => file_path
                                       )
      file.add_element('error',
                       'line' => diagnostics['location']['line'],
                       'severity' => 'error',
                       'message' => "#{diagnostics['category']}\n#{diagnostics['description']}"
                      )
    end

    def self.add_dummy(checkstyle)
      checkstyle.add_element('file',
                             'name' => ''
                            )

      checkstyle
    end
  end
end

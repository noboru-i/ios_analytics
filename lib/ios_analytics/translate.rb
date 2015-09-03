require 'plist'
require 'rexml/document'

module IosAnalytics
  module Translate
    def trans(checkstyle_dom, plist_file)
      puts plist_file
      result = Plist::parse_xml(plist_file)
      return nil if result['files'].empty?

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
  end
end

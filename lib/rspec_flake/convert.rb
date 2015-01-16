module RSpecFlake
  class << self
    def hash_to_xml source_hash
      # top level attribues from root node
      converted             = source_hash[:testsuites][:attrs] || {}
      converted[:testsuite] = []

      source_hash[:testsuites][:testsuite].each do |suite_location, suite_obj|
        suite_with_tests            = suite_obj[:attrs] || {}
        suite_with_tests[:testcase] = []
        suite_obj[:testcase].each do |testcase_location, testcase_obj|
          testcase = testcase_obj[:attrs]
          if testcase_obj[:failure]
            fail_content = testcase_obj[:failure][:content]
            fail_content = "\n<![CDATA[#{fail_content}]]>\n"
            # content key must be a string for xml simple
            testcase.merge!(failure: testcase_obj[:failure][:attrs].merge('content' => fail_content))
          end
          suite_with_tests[:testcase] << testcase
        end

        converted[:testsuite] << suite_with_tests
      end

      # ap converted, index: false, indent: 2

      xml_out converted
    end

    def xml_out hash
      xml_header = %Q(<?xml version="1.0" encoding="UTF-8"?>\n)
      xml_body = XmlSimple.xml_out(hash, RootName: 'testsuites')
      # xmlsimple will escape the cdata by default
      xml_body = EscapeUtils.unescape_html xml_body
      xml_header + xml_body
    end
  end
end

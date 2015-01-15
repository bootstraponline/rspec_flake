module RSpecFlake
  class << self
    def hash_to_xml source_hash
      # top level attribues from root node
      converted             = source_hash[:testsuites][:attrs]
      converted[:testsuite] = []

      source_hash[:testsuites][:testsuite].each do |suite_location, suite_obj|
        suite_with_tests            = suite_obj[:attrs]
        suite_with_tests[:testcase] = []
        suite_obj[:testcase].each do |testcase_location, testcase_obj|
          suite_with_tests[:testcase] << testcase_obj[:attrs]
        end

        converted[:testsuite] << suite_with_tests
      end

      # ap converted, index: false, indent: 2

      xml_header = %Q(<?xml version="1.0" encoding="UTF-8"?>\n)
      xml_header + XmlSimple.xml_out(converted, RootName: 'testsuites')
    end
  end
end

require 'pry'

module RSpecFlake
  class << self

    # merge input xml files into a hash
    #
    # input - single path or array of paths to input xml files
    # @return merged hash
    def merge_xml opts={}
      input = opts[:input]
      raise 'input path(s) not provided' unless input
      input = [input] unless input.kind_of?(Array)

      merged = { testsuite: { testcase: {} } }

      # annotate each testcase node with two attributes
      #
      # failures - amount of times this test failed
      # runs     - amount of times this test was executed
      #
      # name/time - saved from the first run of the testcase
      # location - stored for each run

      input.each do |xml_path|
        parsed = parse_xml(xml_path)

        parsed[:testsuites][:testsuite].each do |suite_location, suite_obj|
          suite_obj[:testcase].each do |testcase_location, testcase_obj|
            attrs = testcase_obj[:attrs]
            test  = merged[:testsuite][:testcase][testcase_location] ||= { failures: 0, runs: 0, name: attrs['name'], location: attrs['location'], time: [] }
            # todo: merge failure tags and retain cdata
            if testcase_obj[:failure]
              test[:failures] += 1
            end
            test[:runs] += 1
            test[:time] << attrs['time']
          end
        end
      end

      # transform merge hash keyed on location into simple testcase array
      # for xml conversion
      converted = { testsuite: { testcase: [] } }

      merged[:testsuite][:testcase].each do |testcase_location, testcase_obj|
        converted[:testsuite][:testcase] << testcase_obj
      end

      xml_out converted
    end
  end
end

module RSpecFlake
  class << self

    # Merges individual xml reports (from parallel_rspec)
    # into a single combined xml file
    #
    # @example:
    #    merge_individual_xml files: Dir.glob('tmp/*.xml')
    def merge_individual_xml opts={}
      files = opts[:files]
      files = [files] unless files.is_a?(Array)

      files_hash = {}
      files.each { |file| files_hash.merge!(RSpecFlake.parse_xml(file)[:testsuites][:testsuite]) }

      RSpecFlake.hash_to_xml({ testsuites: { testsuite: files_hash } })
    end

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

            if testcase_obj[:failure]
              test[:failures] += 1
              test[:failure]  ||= []
              test[:failure] << { 'content' => cdata(testcase_obj[:failure][:content]) }
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

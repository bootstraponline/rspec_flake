=begin
<testsuite errors="0" failures="0" skipped="0" tests="4" time="0.001283" timestamp="2015-01-15T10:25:40-05:00">
  <testsuite location="./spec/a_spec.rb:1" name="a" tests="2" errors="0" failures="0" skipped="0">
    <testcase name="a a 1" time="0.000177" location="./spec/a_spec.rb:6">

# sax parser
# http://nokogiri.org/Nokogiri/XML/SAX.html
=end

module RSpecFlake
  class << self
    class ReportParser < Nokogiri::XML::SAX::Document
      def initialize
        reset
      end

      def reset
        @data           = {}
        @suite_location = nil
        @testcase_location = nil
        @failure = nil
      end

      def result
        @data
      end

      def start_element name, attrs = []
        name      = name.to_sym
        attrs     = attrs.to_h
        testsuite = :testsuite
        root      = :testsuites
        location  = attrs['location']

        case name
          when root
            @data[root] ||= { attrs: attrs, testsuite: {} }
          when :testsuite
            @suite_location                         = location
            @data[root][testsuite][@suite_location] ||= { attrs: attrs, testcase: {} }
          when :testcase
            raise 'testcase not part of a suite' unless @suite_location
            @testcase_location = location
            @data[root][testsuite][@suite_location][:testcase][location] ||= { attrs: attrs }
          when :failure
            raise 'failure not part of a testcase' unless @testcase_location
            @data[root][testsuite][@suite_location][:testcase][@testcase_location].merge!( { failure: { attrs: attrs } } )
            @failure = @data[root][testsuite][@suite_location][:testcase][@testcase_location][:failure]
        end
      end

      def cdata_block string
        raise 'cdata not associated with failure' unless @failure
        @failure[:content] = string
        @failure = nil
      end

      def end_element name
        case name
          when 'testsuite'
             @suite_location = nil
          when 'testcase'
            @testcase_location = nil
        end
      end
    end

    def read_as_utf8 path
      File.read(path).encode!('UTF-8', invalid: :replace, undef: :replace, replace: '')
    end

    def parse_xml xml_path
      xml = read_as_utf8 xml_path

      parser = @parser ||= Nokogiri::XML::SAX::Parser.new(ReportParser.new)
      parser.document.reset
      parser.parse xml

      parser.document.result
    end
  end
end

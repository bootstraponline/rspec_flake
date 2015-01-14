=begin
<testsuite errors="0" failures="0" skipped="0" tests="4" time="0.001283" timestamp="2015-01-15T10:25:40-05:00">
  <testsuite location="./spec/a_spec.rb:1" name="a" tests="2" errors="0" failures="0" skipped="0">
    <testcase name="a a 1" time="0.000177" location="./spec/a_spec.rb:6">

# sax parser
# http://nokogiri.org/Nokogiri/XML/SAX.html
=end

require 'rubygems'
require 'nokogiri'
require 'pry'
require 'awesome_print'

Pry.config.command_prefix = "%" if defined?(Pry)

class ReportParser < Nokogiri::XML::SAX::Document
  def initialize
    reset
  end

  def reset
    @data = {}
    @suite_location = nil
  end

  def result
    @data
  end

  def start_element name, attrs = []
    name = name.to_sym
    testsuite = :testsuite
    root = :testsuites
    location = attrs.to_h['location']

    case name
      when root
        @data[root] ||= {attrs: attrs, testsuite: {}}
      when :testsuite
        @suite_location = location
        @data[root][testsuite][@suite_location] ||= {attrs: attrs, testcase: {}}
      when :testcase
        raise 'testcase not part of a suite' unless @suite_location
        @data[root][testsuite][@suite_location][:testcase][location] ||= attrs
    end
  end

  def end_element name
    @suite_location = nil if name == 'testsuite'
  end
end

def read_as_utf8 path
  File.read(path).encode!('UTF-8', invalid: :replace, undef: :replace, replace: '')
end

xml = read_as_utf8 '0.xml'

parser = Nokogiri::XML::SAX::Parser.new ReportParser.new
parser.document.reset
parser.parse xml

ap parser.document.result


=begin
{
    :testsuites => {
            :attrs => [
            [0] [
                [0] "errors",
                [1] "0"
            ],
            [1] [
                [0] "failures",
                [1] "0"
            ],
            [2] [
                [0] "skipped",
                [1] "0"
            ],
            [3] [
                [0] "tests",
                [1] "4"
            ],
            [4] [
                [0] "time",
                [1] "0.001283"
            ],
            [5] [
                [0] "timestamp",
                [1] "2015-01-15T10:25:40-05:00"
            ]
        ],
        :testsuite => {
            "./spec/a_spec.rb:1" => {
                   :attrs => [
                    [0] [
                        [0] "location",
                        [1] "./spec/a_spec.rb:1"
                    ],
                    [1] [
                        [0] "name",
                        [1] "a"
                    ],
                    [2] [
                        [0] "tests",
                        [1] "2"
                    ],
                    [3] [
                        [0] "errors",
                        [1] "0"
                    ],
                    [4] [
                        [0] "failures",
                        [1] "0"
                    ],
                    [5] [
                        [0] "skipped",
                        [1] "0"
                    ]
                ],
                :testcase => {
                     "./spec/a_spec.rb:6" => [
                        [0] [
                            [0] "name",
                            [1] "a a 1"
                        ],
                        [1] [
                            [0] "time",
                            [1] "0.000177"
                        ],
                        [2] [
                            [0] "location",
                            [1] "./spec/a_spec.rb:6"
                        ]
                    ],
                    "./spec/a_spec.rb:10" => [
                        [0] [
                            [0] "name",
                            [1] "a a 2"
                        ],
                        [1] [
                            [0] "time",
                            [1] "0.000198"
                        ],
                        [2] [
                            [0] "location",
                            [1] "./spec/a_spec.rb:10"
                        ]
                    ]
                }
            },
            "./spec/b_spec.rb:1" => {
                   :attrs => [
                    [0] [
                        [0] "location",
                        [1] "./spec/b_spec.rb:1"
                    ],
                    [1] [
                        [0] "name",
                        [1] "b"
                    ],
                    [2] [
                        [0] "tests",
                        [1] "2"
                    ],
                    [3] [
                        [0] "errors",
                        [1] "0"
                    ],
                    [4] [
                        [0] "failures",
                        [1] "0"
                    ],
                    [5] [
                        [0] "skipped",
                        [1] "0"
                    ]
                ],
                :testcase => {
                     "./spec/b_spec.rb:6" => [
                        [0] [
                            [0] "name",
                            [1] "b b 3"
                        ],
                        [1] [
                            [0] "time",
                            [1] "0.000112"
                        ],
                        [2] [
                            [0] "location",
                            [1] "./spec/b_spec.rb:6"
                        ]
                    ],
                    "./spec/b_spec.rb:10" => [
                        [0] [
                            [0] "name",
                            [1] "b b 4"
                        ],
                        [1] [
                            [0] "time",
                            [1] "0.000204"
                        ],
                        [2] [
                            [0] "location",
                            [1] "./spec/b_spec.rb:10"
                        ]
                    ]
                }
            }
        }
    }
}
=end
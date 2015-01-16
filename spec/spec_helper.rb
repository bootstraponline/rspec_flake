require_relative '../lib/rspec_flake'
require 'awesome_print'
require 'pry'

Pry.config.command_prefix = "%" if defined?(Pry)

def data data_path
  File.expand_path File.join('..', 'data', data_path), __FILE__
end

def expected_merge_xml
  <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<testsuites>
  <testsuite>
    <testcase failures="0" runs="3" name="a a 1" location="./spec/a_spec.rb:6">
      <time>0.000177</time>
      <time>0.000217</time>
      <time>0.000184</time>
    </testcase>
    <testcase failures="0" runs="3" name="a a 2" location="./spec/a_spec.rb:10">
      <time>0.000198</time>
      <time>0.00015</time>
      <time>0.000171</time>
    </testcase>
    <testcase failures="0" runs="3" name="b b 3" location="./spec/b_spec.rb:6">
      <time>0.000112</time>
      <time>0.000171</time>
      <time>0.00016</time>
    </testcase>
    <testcase failures="0" runs="3" name="b b 4" location="./spec/b_spec.rb:10">
      <time>0.000204</time>
      <time>0.000148</time>
      <time>0.000173</time>
    </testcase>
    <testcase failures="2" runs="2" name="a a 3" location="./spec/a_spec.rb:2">
      <time>0.001008</time>
      <time>0.001008</time>
      <failure>
<![CDATA[
expected: 2
     got: 1

(compared using ==)

["./spec/a_spec.rb:4:in `block (2 levels) in <top (required)>'"]]]>
</failure>
      <failure>
<![CDATA[
expected: 2
     got: 1

(compared using ==)

["./spec/a_spec.rb:4:in `block (2 levels) in <top (required)>'"]]]>
</failure>
    </testcase>
  </testsuite>
</testsuites>
XML
end

def expected_converted_0_xml
  <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<testsuites errors="0" failures="0" skipped="0" tests="4" time="0.001283" timestamp="2015-01-15T10:25:40-05:00">
  <testsuite location="./spec/a_spec.rb:1" name="a" tests="2" errors="0" failures="0" skipped="0">
    <testcase name="a a 1" time="0.000177" location="./spec/a_spec.rb:6" />
    <testcase name="a a 2" time="0.000198" location="./spec/a_spec.rb:10" />
  </testsuite>
  <testsuite location="./spec/b_spec.rb:1" name="b" tests="2" errors="0" failures="0" skipped="0">
    <testcase name="b b 3" time="0.000112" location="./spec/b_spec.rb:6" />
    <testcase name="b b 4" time="0.000204" location="./spec/b_spec.rb:10" />
  </testsuite>
</testsuites>
XML
end

def expected_converted_failure_xml
  <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<testsuites errors="0" failures="1" skipped="0" tests="1" time="0.001672" timestamp="2015-01-16T10:14:25-05:00">
  <testsuite location="./spec/a_spec.rb:1" name="a" tests="1" errors="0" failures="1" skipped="0">
    <testcase name="a a 3" time="0.001008" location="./spec/a_spec.rb:2">
      <failure message="failed a a 3" type="failed">
<![CDATA[
expected: 2
     got: 1

(compared using ==)

["./spec/a_spec.rb:4:in `block (2 levels) in <top (required)>'"]]]>
</failure>
    </testcase>
  </testsuite>
</testsuites>
XML
end

def expected_parsed_0_xml
  {
    :testsuites => {
      :attrs     => {
        'errors'    => '0',
        'failures'  => '0',
        'skipped'   => '0',
        'tests'     => '4',
        'time'      => '0.001283',
        'timestamp' => '2015-01-15T10:25:40-05:00'
      },
      :testsuite => {
        './spec/a_spec.rb:1' => {
          :attrs    => {
            'location' => './spec/a_spec.rb:1',
            'name'     => 'a',
            'tests'    => '2',
            'errors'   => '0',
            'failures' => '0',
            'skipped'  => '0'
          },
          :testcase => {
            './spec/a_spec.rb:6'  => {
              :attrs => {
                'name'     => 'a a 1',
                'time'     => '0.000177',
                'location' => './spec/a_spec.rb:6'
              }
            },
            './spec/a_spec.rb:10' => {
              :attrs => {
                'name'     => 'a a 2',
                'time'     => '0.000198',
                'location' => './spec/a_spec.rb:10'
              }
            }
          }
        },
        './spec/b_spec.rb:1' => {
          :attrs    => {
            'location' => './spec/b_spec.rb:1',
            'name'     => 'b',
            'tests'    => '2',
            'errors'   => '0',
            'failures' => '0',
            'skipped'  => '0'
          },
          :testcase => {
            './spec/b_spec.rb:6'  => {
              :attrs => {
                'name'     => 'b b 3',
                'time'     => '0.000112',
                'location' => './spec/b_spec.rb:6'
              }
            },
            './spec/b_spec.rb:10' => {
              :attrs => {
                'name'     => 'b b 4',
                'time'     => '0.000204',
                'location' => './spec/b_spec.rb:10'
              }
            }
          }
        }
      }
    }
  }
end

def expected_parsed_failure_xml
  {
    :testsuites => {
      :attrs     => {
        "errors"    => "0",
        "failures"  => "1",
        "skipped"   => "0",
        "tests"     => "1",
        "time"      => "0.001672",
        "timestamp" => "2015-01-16T10:14:25-05:00"
      },
      :testsuite => {
        "./spec/a_spec.rb:1" => {
          :attrs    => {
            "location" => "./spec/a_spec.rb:1",
            "name"     => "a",
            "tests"    => "1",
            "errors"   => "0",
            "failures" => "1",
            "skipped"  => "0"
          },
          :testcase => {
            "./spec/a_spec.rb:2" => {
              :attrs   => {
                "name"     => "a a 3",
                "time"     => "0.001008",
                "location" => "./spec/a_spec.rb:2"
              },
              :failure => {
                :attrs   => {
                  "message" => "failed a a 3",
                  "type"    => "failed"
                },
                :content => "\nexpected: 2\n     got: 1\n\n(compared using ==)\n\n[\"./spec/a_spec.rb:4:in `block (2 levels) in <top (required)>'\"]"
              }
            }
          }
        }
      }
    }
  }
end

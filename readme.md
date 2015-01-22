#### rspec_flake [![Gem Version](https://badge.fury.io/rb/rspec_flake.svg)](http://badge.fury.io/rb/rspec_flake)[![Build Status](https://travis-ci.org/bootstraponline/rspec_flake.svg?branch=master)](https://travis-ci.org/bootstraponline/rspec_flake)

Measure RSpec test flakiness

#### Design Notes

`rspec` doesn't enforce unique test names, also test suite names may be reused
in different files. The only reliable way to identify a test or suite is by
location.

A nokogiri SAX parser is used to read the junit xml into a hash keyed on
location. After that the hash is rewritten and passed to XmlSimple for
serilization to xml.

The value of `errors` is hardcoded to 0 in `jarjuf` because rspec records
failures. Errors are considered a type of failure.

#### Example output

```
$ rspec_flake 2 rspec
Running: "rspec" --format JUnit --out "/rspec_simple_example/tmp/0.xml"
Running: "rspec" --format JUnit --out "/rspec_simple_example/tmp/1.xml"
a a 1 - runs: 2 - failures: 0 - avg time: 0.0 - ./spec/a_spec.rb:6
a a 2 - runs: 2 - failures: 0 - avg time: 0.0 - ./spec/a_spec.rb:10
a a 3 - runs: 2 - failures: 0 - avg time: 0.0 - ./spec/a_spec.rb:13
b b 3 - runs: 2 - failures: 0 - avg time: 0.0 - ./spec/b_spec.rb:6
b b 4 - runs: 2 - failures: 0 - avg time: 0.0 - ./spec/b_spec.rb:9
```

#### Parallel

When running [tests in parallel](https://github.com/grosser/parallel_tests),
the output can be [saved by env number](http://elementalselenium.com/tips/57-junit-xml)
in the `.rspec_parallel` options file

`--out junit/xml_<%= ENV['TEST_ENV_NUMBER'] %>.xml`

There's also the `.rspec` options file and flags such as `--format documentation`
can be passed directly to rspec_flake.

#### Google Sheets Note

The file time output is tab delimited and can be posted directly into
a Google Sheets document using Command/Control + Shift + V.

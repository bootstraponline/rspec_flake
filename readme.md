#### rspec_flake [![Build Status](https://travis-ci.org/bootstraponline/rspec_flake.svg?branch=master)](https://travis-ci.org/bootstraponline/rspec_flake)

Measure RSpec test flakiness

#### Design Notes

`rspec` doesn't enforce unique test names, also test suite names may be reused
in different files. The only reliable way to identify a test or suite is by
location.

A nokogiri SAX parser is used to read the junit xml into a hash keyed on
location. After that the hash is rewritten and passed to XmlSimple for
serilization to xml.
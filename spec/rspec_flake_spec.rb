describe 'RSpecFlake::Runner.run_tests' do
  it 'runs successfully' do
    command               = 'bundle exec rspec spec/stats_spec.rb'
    io                    = StringIO.new

    # Ensure rspec process that's created as part of this test doesn't
    # report coverage data to coveralls.io.
    ENV['SKIP_COVERALLS'] = 'true'
    RSpecFlake::Runner.run_tests count: 1, command: command, io: io
    ENV['SKIP_COVERALLS'] = nil # false

    actual = io.string

    # time will differ so we can't use one long string.
    expected = ['stats generates stats from merge xml  - runs: 1 - failures: 0 - avg time:',
                ' - ./spec/stats_spec.rb:2']

    expected.each do |expected_string|
      expect(actual.include?(expected_string)).to eq(true)
    end
  end
end

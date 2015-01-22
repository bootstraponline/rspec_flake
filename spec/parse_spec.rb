describe 'parse rspec_junit xml' do
  it 'parses success results' do
    actual   = RSpecFlake.parse_xml data '0.xml'
    expected = expected_parsed_0_xml

    expect(actual).to eq expected
  end

  it 'parses failure results' do
    actual   = RSpecFlake.parse_xml data 'failure.xml'
    expected = expected_parsed_failure_xml

    expect(actual).to eq expected
  end
end

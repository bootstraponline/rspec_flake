describe 'parse' do
  it 'should successfully parse rspec_junit xml' do
    actual = RSpecFlake.parse_xml data '0.xml'
    expected = expected_parsed_0_xml

    expect(actual).to eq expected
  end
end
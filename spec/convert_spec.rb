describe 'convert' do
  it 'should convert to xml successfully' do
    actual = RSpecFlake.hash_to_xml expected_parsed_0_xml
    expected = expected_converted_0_xml

    expect(actual).to eq(expected)
  end
end
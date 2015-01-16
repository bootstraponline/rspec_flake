describe 'convert xml' do
  it 'should convert successful results' do
    actual   = RSpecFlake.hash_to_xml expected_parsed_0_xml
    expected = expected_converted_0_xml

    expect(actual).to eq(expected)
  end

  it 'should convert failed results' do
    actual   = RSpecFlake.hash_to_xml expected_parsed_failure_xml
    expected = expected_converted_failure_xml

    expect(actual).to eq(expected)
  end
end

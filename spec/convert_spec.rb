describe 'convert xml' do
  it 'converts successful results' do
    actual   = RSpecFlake.hash_to_xml expected_parsed_0_xml
    expected = expected_converted_0_xml

    expect(actual).to eq(expected)
  end

  it 'converts failed results' do
    actual   = RSpecFlake.hash_to_xml expected_parsed_failure_xml
    expected = expected_converted_failure_xml

    expect(actual).to eq(expected)
  end
end

describe 'merge rspec_junit xml' do
  it 'merges successfully' do
    xml_files = %w[0.xml 1.xml 2.xml failure.xml failure2.xml]
    actual    = RSpecFlake.merge_xml input: xml_files.map(&method(:data))
    expected  = expected_merge_xml

    expect(actual).to eq expected
  end

  it 'merges individual xml files' do
    xml_files = %w[3.xml 4.xml]
    actual    = RSpecFlake.merge_individual_xml files: xml_files.map(&method(:data))
    expected  = expected_merge_individual_xml

    expect(actual).to eq(expected)
  end
end

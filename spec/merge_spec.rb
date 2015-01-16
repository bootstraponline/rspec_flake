describe 'merge rspec_junit xml' do
  it 'should merge successfully' do
    xml_files = %w[0.xml 1.xml 2.xml failure.xml failure2.xml]
    actual    = RSpecFlake.merge_xml input: xml_files.map(&method(:data))
    expected  = expected_merge_xml

    expect(actual).to eq expected
  end
end

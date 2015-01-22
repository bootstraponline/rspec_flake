describe 'file time' do

  it 'calculates time spent per file' do
    # handles fast times < 0 seconds
    xml_files = %w[0.xml 1.xml 2.xml]
    actual    = RSpecFlake.file_time files: xml_files.map(&method(:data))
    expected  = "0           \t./spec/b_spec.rb\n0           \t./spec/a_spec.rb\n"

    expect(actual).to eq expected
  end

  it 'sorts high to low' do
    xml_files = %w[time.xml]
    actual    = RSpecFlake.file_time files: xml_files.map(&method(:data))
    expected  = "18 secs     \t./spec/b_spec.rb\n15 secs     \t./spec/a_spec.rb\n"

    expect(actual).to eq expected
  end
end

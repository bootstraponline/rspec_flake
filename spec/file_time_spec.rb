describe 'file time' do

  it 'should calculate time spent per file' do
    # handles fast times < 0 seconds
    xml_files = %w[0.xml 1.xml 2.xml]
    actual    = RSpecFlake.file_time files: xml_files.map(&method(:data))
    expected  = "./spec/b_spec.rb\t 0./spec/a_spec.rb\t 0"

    expect(actual).to eq expected
  end

  it 'should sort high to low' do
    xml_files = %w[time.xml]
    actual    = RSpecFlake.file_time files: xml_files.map(&method(:data))
    expected  = "./spec/b_spec.rb\t 18 secs./spec/a_spec.rb\t 15 secs"

    expect(actual).to eq expected
  end
end

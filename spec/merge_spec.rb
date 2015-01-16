describe 'merge rspec_junit xml' do
  it 'should merge successfully' do
    actual   = RSpecFlake.merge_xml input: [data('0.xml'), data('1.xml'),
                                            data('2.xml'), data('failure.xml'),
                                            data('failure2.xml')]
    expected = expected_merge_xml

    expect(actual).to eq expected
  end
end

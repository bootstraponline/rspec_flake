describe 'stats' do
  it 'generates stats from merge xml ' do
    actual = RSpecFlake.stats_from_merge_xml expected_merge_xml
    expected  = expected_stats

    expect(actual).to eq expected
  end
end

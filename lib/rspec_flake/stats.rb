module RSpecFlake
  class << self
    def stats_from_merge_xml xml_string
      output = ''

      xml = Nokogiri::XML(xml_string)
      xml.xpath('//testcase').each do |testcase|
        # <testcase failures="0" runs="3" name="a a 1" location="./spec/a_spec.rb:6">
        failures = testcase[:failures]
        runs     = testcase[:runs]
        name     = testcase[:name]
        location = testcase[:location]

        times = []
        testcase.xpath('time').each do |time|
         times << time.content.to_f
        end

        average_time = (times.inject(:+).to_f / times.size).round 2

        output += "#{name} - runs: #{runs} - failures: #{failures} - avg time: #{average_time} - #{location}\n"
      end

      output
    end
  end
end

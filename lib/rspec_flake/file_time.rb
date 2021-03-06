module RSpecFlake
  class << self

    # Read in JUnit xml files and output an xml report
    # that lists the time spent per file
    #
    # @example puts RSpecFlake.file_time files: Dir.glob("*.xml")
    def file_time opts={}
      files = opts[:files]
      files = [files] unless files.is_a?(Array)

      file_times = Hash.new 0

      xml = Nokogiri::XML(merge_individual_xml files: files)
      xml.xpath('//testcase').each do |test|
        file_name = test.attr('location').split(':').first
        file_times[file_name] += test.attr('time').to_i
      end

      file_times = file_times.sort_by { |file, time| time }.reverse

      # Paste into Google Sheets with Ctrl/Command + Shift + V
      output = ''
      file_times.each do |file, time|
        time = ChronicDuration.output(time) || '0'
        output += "#{time.ljust(12)}\t#{file}\n"
      end

      output
    end
  end
end

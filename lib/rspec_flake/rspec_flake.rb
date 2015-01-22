# encoding: utf-8
module RSpecFlake
  class Runner
    def self.run_tests opts={}
      count = opts[:count]
      raise 'count is required and must be a number' unless count && count.match(/\d+/)
      count = count.to_i

      command = opts[:command]
      raise "command is required and must start with rspec. #{command}" unless command && command.include?('rspec')

      tmp_path = File.expand_path File.join Dir.pwd, 'tmp'
      FileUtils.rm_rf tmp_path
      FileUtils.mkdir_p tmp_path

      xml_files = []

      count.times do |iteration|
        out_file = File.expand_path File.join(tmp_path, iteration.to_s + '.xml')
        xml_files << out_file
        spawn_command = %Q(#{command} --format JUnit --out "#{out_file}")
        puts "Running: #{spawn_command}"
        Process::waitpid(POSIX::Spawn::spawn(spawn_command))
      end

      merge_path = File.join(tmp_path, '..', 'merged.xml')
      File.open(merge_path, 'w') do |file|
        xml = RSpecFlake.merge_xml input: xml_files
        file.write xml
        puts RSpecFlake.stats_from_merge_xml xml
      end
    end
  end
end

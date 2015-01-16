# encoding: utf-8
module RSpecFlake
  class Runner
    def self.run_tests opts={}
      count = opts[:count]
      raise 'count is required and must be a number' unless count && count.match(/\d+/)
      count = count.to_i

      command = opts[:command]
      raise "command is required and must start with rspec. #{command}" unless command && command.start_with?('rspec')

      tmp_path = File.expand_path File.join Dir.pwd, 'tmp'
      FileUtils.rm_rf tmp_path
      FileUtils.mkdir_p tmp_path

      count.times do |iteration|
        out_file = File.join(tmp_path, iteration.to_s + '.xml')
        spawn_command = %Q("#{command}" --format JUnit --out "#{out_file}")
        puts "Running: #{spawn_command}"
        Process::waitpid(POSIX::Spawn::spawn(spawn_command))
      end
    end
  end
end
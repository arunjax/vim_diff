module VimDiff
  class Generator

    attr_accessor :left_file_path
    attr_accessor :right_file_path
    attr_accessor :html_diff_path

    def initialize(left_file_path, right_file_path, html_diff_path)
      self.left_file_path  = left_file_path
      self.right_file_path = right_file_path
      self.html_diff_path  = html_diff_path
    end

    def generate
      command = ("nohup vimdiff #{self.left_file_path} #{self.right_file_path} -c TOhtml  -c 'w! #{self.html_diff_path}' -c 'qa!'")
      say `#{command}`
      say "Generated file to #{self.html_diff_path}"
    end

    private

    def say(message)
      puts message
    end
    
  end
end

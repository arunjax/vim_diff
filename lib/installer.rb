module VimDiff
  class Installer
    def isntall
      vim_plugin_path = "~/.vim/plugin"
      puts `mkdir -p #{vim_plugin_path}`
      puts `cp #{File.join(File.dirname(__FILE__), '..', 'vim_plugin', 'tohtml.vim')} #{vim_plugin_path}`
    end
  end
end

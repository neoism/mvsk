require 'json'
require 'lolcat'
require 'treely'
require 'stringio'
require 'fileutils'
require 'tty-config'
require 'tty-prompt'
require 'dolphin_kit'

require 'papago/version'
require 'papago/services/openai_service'
require 'papago/actions/switch'
require 'papago/actions/run'
require 'papago/printer'

module Papago
  class Application
    attr_reader :config

    def initialize
      @config = TTY::Config.new
      @config_dir = File.dirname(config_file)

      unless File.exist?(@config_dir)
        FileUtils.mkdir(@config_dir)
      end

      @config.append_path @config_dir

      if File.exist?(config_file)
        @config.read
      else
        @config.write
      end
    end

    private

    def config_file
      @config_file ||= "#{Dir.home}/.papago/config.yml"
    end
  end

  def self.service_name
    config.fetch('translator.service_name')
  end

  def self.application
    @application ||= Application.new
  end

  def self.config
    @config ||= application.config
  end
end

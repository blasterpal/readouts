require 'active_support/all'
require 'hashie'
require_relative 'readoutsweb'

class Readouts
  APP_ROOT = File.join(File.dirname(__FILE__), '../')
  attr_accessor :metrics, :app_info, :env_filter,:app_name, :file_root,:github_base_url, :headers_enabled, :version_info_enabled
  class_attribute :config_block
  
  def self.configure(&block)
    Readouts.config_block = block
  end

  def initialize()
    @metrics = Hashie::Mash.new
    @app_info = Hashie::Mash.new
    @file_root = APP_ROOT
    @headers_enabled = false
    @version_info_enabled = false
    @github_base_url = 'N/A'
    Readouts.config_block.call(self) if Readouts.config_block
  end

  #def self.configure(&block)
    #Readouts.config_block = block
  #end

  def register_metric(name,data,info='')
    # use an activesupport method to ensure spaced, mixed case names get converted
    @metrics.deep_update( {name.parameterize.gsub('-','_') => {:data => data,:info => info, :name => name}})
  end

  def register_app_info(name,data,info='')
    @app_info.deep_update( {name.parameterize.gsub('-','_') => {:data => data,:info => info, :name => name}})
  end

  def version_or_branch
    @version ||= if File.exists?(version_file)
    File.read(version_file).chomp.gsub('^{}', '')
    elsif environment == 'development' && `git branch` =~ /^\* (.*)$/
      $1
    else
      'Unknown'
    end
  end

  def version_file
    @version_file ||= File.join(file_root, 'VERSION')
  end

  def environment
    ENV['RAILS_ENV'] || ENV['RACK_ENV']
  end

  def deploy_date
    @deploy_date ||= if File.exists?(version_file)
      File.stat(version_file).mtime
    elsif environment == 'development'
      'Live'
    else
      'Unknown'
    end
  end

  def last_commit
    @last_commit ||= if File.exists?(revision_file)
      File.read(revision_file).chomp
    elsif environment == 'development' && `git show` =~ /^commit (.*)$/
      $1
    else
      nil
    end
  end

  def revision_file
    @revision_file ||= File.join(file_root, 'REVISION')
  end

  def hostname
    @hostname ||= `/bin/hostname` || 'Unknown'
  end

  def repo_link
    last_commit.nil? ? "#{github_base_url}" : "#{github_base_url}/commit/#{last_commit}"
  end

  # this should be further expanded upon
  # single purpose to mask AWS crendentials, make more better
  def self.mask(string)
    string.gsub(/.(?=.{4})/, '*')
  end

end

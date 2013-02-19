module Readouts
  class MetricsInfo
    require 'hashie'

    attr_accessor :metrics, :app_info, :env_filter,:app_name, :file_root,:github_base_url, :headers_enabled, :version_info_enabled
    class_attribute :config_block

    def initialize()
      @metrics = Hashie::Mash.new
      @app_info = Hashie::Mash.new
      @headers_enabled = false
      @version_info_enabled = false
      @github_base_url = 'N/A'
      @env_filter = []
      MetricsInfo.config_block.call(self) if MetricsInfo.config_block
    end

    def self.configure(&block)
      MetricsInfo.config_block = block
    end

    def register_metric(name,data,info='')
      # use an activesupport method to ensure spaced, mixed case names get converted
      @metrics.deep_update( {name.parameterize.gsub('-','_') => {:data => data,:info => info, :name => name}})
    end

    def register_app_info(name,data,info='')
      @app_info.deep_update( {name.parameterize.gsub('-','_') => {:data => data,:info => info, :name => name}})
    end

    # legacy method 
    def env_info
      #env_filter = ['PATH','RACK_ENV','FOO_BAR','USER'] #add other keys you want to see values of here from the ENV
      if env_filter && env_filter.size > 0
        ENV.select {|k,v| env_filter.include? k}
      else
        ENV
      end
    end

    # this should be further expanded upon
    # single purpose to mask AWS crendentials, make more better
    def self.mask(string)
      string.gsub(/.(?=.{4})/, '*')
    end


    def set_config
      yield if block_given?
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

def app_name
  @app_name || begin
  dirs = Dir.pwd.split('/')
  if dirs.last =~ /^\d+$/
    dirs[-3]
  else
    dirs.last
  end.sub(/\.com$/, '') 
end
  end

  def version_link(version)
    "#{github_base_url}/#{app_name}/tree/#{version}" unless version_or_branch =~ /^Unknown/
  end

  def commit_link(commit)
    "#{github_base_url}/#{app_name}/commit/#{commit}" unless commit =~ /^Unknown/
  end

  def repo_link
    last_commit.nil? ? "#{github_base_url}" : "#{github_base_url}/commit/#{last_commit}"
  end

end
end

require './spec/spec_helper'

describe Readouts do 
  it 'should be instantiated without any Class configuration' do
    Readouts.new.must_be_instance_of Readouts
  end
end

describe Readouts do

  before :each do 
    Readouts.configure do |c|
      c.app_name 'Readouts'
      c.file_root APP_ROOT
      c.github_base_url 'https://github.com/blasterpal/readouts'
    end
    @metrics_info = Readouts.new
  end

  it "should support block configuration on class_attribute" do
    @metrics_info.app_name.must_equal 'Readouts'
  end
  it "should create nested accessors from Hash assignments" do
    @metrics_info.register_metric 'my_metrics', {'foo' => 1}, 'My apps wonderful metrics'
    puts @metrics_info.metrics.my_metrics
    @metrics_info.metrics.my_metrics.data.foo.must_equal 1
  end
  it "should convert mixed case, spaced metric names into key friendly string" do
    @metrics_info.register_metric 'My Silly* Metric', {'foo' => 1}, 'My apps wonderful metrics'
    puts @metrics_info.metrics.my_silly_metric
    @metrics_info.metrics.my_silly_metric.data.foo.must_equal 1
  end

end

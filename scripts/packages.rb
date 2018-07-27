require File.dirname(__FILE__)+"/dependency_manager"
require File.dirname(__FILE__)+"/vagrant_rancheros_guest_plugin"

@settings = YAML.load_file('settings.yml')

@master = YAML.load_file(@settings['machines']['master'])
num_of_workers = @settings['machines']['workers']
@workers = Array.new()
if num_of_workers.count() > 0
  for worker in num_of_workers
      @workers.push(YAML.load_file(worker))
  end
end

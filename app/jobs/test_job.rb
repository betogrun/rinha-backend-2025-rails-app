class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "Performing TestJob with arguments: " + args.inspect
    Rails.logger.info "TestJob executed with arguments: #{args.inspect}"
  end
end

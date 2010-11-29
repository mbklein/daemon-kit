require 'yaml'
require 'stomp'

module DaemonKit
  # Thin wrapper around the stomp gem, specifically designed to ease
  # configuration of a STOMP consumer daemon and provide some added
  # simplicity
  class STOMP

    @@instance = nil

    class << self

      def instance
        @instance ||= new
      end

      private :new

      def run(&block)
        instance.run(&block)
      end
    end

    def initialize( config = {} )
      @config = DaemonKit::Config.load('stomp').to_h( true )
    end

    def run
      # Start our event loop and STOMP client
      DaemonKit.logger.debug("STOMP.start(#{@config.inspect})")
      @client = Stomp::Client.new(@config[:login], @config[:passcode], @config[:host], @config[:port], @config[:reliable])
      begin
        yield(@client)
      ensure
        @client.close
      end
    end
  end
end

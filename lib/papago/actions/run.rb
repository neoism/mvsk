module Papago
  module Actions
    class Run
      attr_reader :printer
      attr_reader :service

      def initialize
        @printer = Papago::Printer.new
        @service = create_service(Papago.service_name || 'youdao')
      end

      private

      def create_service(name)
        if name.to_sym == :openai
          Papago::OpenAIService.new(config: Papago.config)
        else
          DolphinKit.create_service(name)
        end
      end

      def self.process(text:, dest:)
        instance = self.new
        printer = instance.printer
        service = instance.service

        case service.name
        when :baidu, :qcloud
          printer.println(
            service.name,
            service.call(text: text, target: dest)
          )
        else
          printer.println(
            service.name,
            service.call(text: text)
          )
        end
      end
    end
  end
end

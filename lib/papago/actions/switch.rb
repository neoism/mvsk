module Papago
  module Actions
    class Switch
      CHOICES = %w{baidu openai qcloud youdao}

      def self.process(config:)
        prompt = TTY::Prompt.new
        choice = prompt.select('Choose a service?', CHOICES)

        config.set('translator.service_name', value: choice)
        config.write(force: true)

        if choice == 'openai' and (config.fetch('openai.endpoint').nil? or prompt.yes?('Update endpoint?'))
          if endpoint = prompt.ask('OpenAI endpoint:')
            config.set('openai.endpoint', value: endpoint)
            config.write(force: true)
          end
        end
      end
    end
  end
end

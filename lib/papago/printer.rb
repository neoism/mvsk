module Papago
  class Printer
    def println(name, data)
      puts send(:"result_#{name}", data)
    end

    private

    def result_baidu(data)
      result = data['trans_result']&.first
      return data if result.nil?

      tree_format({
        name: result['src'],
        contents: [
          {
            name: result['dst']
          }
        ]
      })
    end

    def result_openai(data)
      result = data['choices']&.first['text']
      return data if result.nil?

      tree_format({
        name: result&.strip
      })
    end

    def result_qcloud(data)
      result = data['TargetText']
      return data if result.nil?

      tree_format({
        name: result
      })
    end

    def result_youdao(data)
      return data unless data['errorCode'].zero?

      explains = data.fetch('web', []).map { |explain|
        {
          name: "#{explain.fetch('key')}: #{explain.fetch('value').join(' ')}"
        }
      }

      result = {
        name: "#{data['query']} [#{data.dig('basic', 'phonetic')}]".gsub(' []', ''),
        contents: [
          {
            name: data.fetch('translation').join(' '),
            contents: (data.dig('basic', 'explains') || []).map { |explain| { name: explain } }
          }
        ] + explains
      }

      tree_format(result)
    end

    def tree_format(data)
      result = StringIO.new(Treely.tree([data]).to_s)
      Lol.cat(result, freq: 0.25, spread: 8.0, os: rand(128))
    end
  end
end

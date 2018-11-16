require "rexml/document"

class XmlReader
  def self.read
    file = File.new("data/questions.xml", "r:UTF-8")
    doc = REXML::Document.new file
    collect = []
    file.close

    doc.root.each_element do |x|
      second = x.attributes["second"]
      text = x.elements["text"].text

      variants = []
      good_variant = nil

      x.each_element("variants/variant") do |y|
        variants << y.text

        if y.attributes["right"] == "true"
            good_variant = y.text
        end
      end

      collect << Question.new(second, text, variants, good_variant)
    end
    collect
  end
end

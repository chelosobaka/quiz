class Question
  attr_reader :second, :text, :variants, :good_variant
  def initialize(second, text, variants, good_variant)
    @second = second
    @text = text
    @variants = variants.sort_by { rand }
    @good_variant = good_variant
  end

=begin
  def to_s
    "#{@second} минут, текст - #{@text}, variants: #{@variants}, good_variant: #{@good_variant}"
  end
=end
end

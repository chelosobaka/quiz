class Question
  attr_reader :second, :text, :variants, :good_variant
  def initialize(second, text, variants, good_variant)
    @second = second
    @text = text
    @variants = variants.sort_by { rand }
    @good_variant = good_variant
  end
end

class KantanRegex
  # Literalは文字リテラルやエスケープ文字を表す型
  # valueにはその文字を表す長さ1の文字列が入る
  # 1文字のパターンaはLiteral['a']として表す
  Literal = Data.define(:value)
  Repetition = Data.define(:child, :quantifier)
  Choice = Data.define(:children)
  Concat = Data.define(:children)
end

class KantanRegex::Parser
  def initialize(pattern)
    @pattern = pattern
    @offset = 0
  end

  def current_char = @pattern[@offset]
  def end? = @pattern.size <= @offset

  def next_char
    @offset += 1
  end

  def parse
    tree = parse_choise

    raise 'End-of-string is expected' unless end?
    tree
  end
end

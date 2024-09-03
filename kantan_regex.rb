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

  # エントリーポイント
  def parse
    tree = parse_choise

    # 最後までパースしたか確認
    raise 'End-of-string is expected' unless end?
    tree
  end

  # 選択 (a|b) をパースする
  def parse_choice
    children = []
    children << parse_concat

    while current_char == '|'
      next_char
      children << parse_concat
    end

    # childrenが1つの場合はChoiceを生成しない
    return children.first if children.size == 1
    KantanRegex::Choice[children]
  end
end

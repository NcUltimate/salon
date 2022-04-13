class Card < OpenStruct
  def rankstr
    case rank
    when 11 then 'J'
    when 12 then 'Q'
    when 13 then 'K'
    when 14 then 'A'
    else rank.to_s
    end
  end

  def suitstr
    case suit
    when 0 then 'H'
    when 1 then 'D'
    when 2 then 'S'
    when 3 then 'C'
    end
  end

  def lead?
    spade? && rank == 2
  end

  def heart?
    suit == 0
  end

  def club?
    suit == 3
  end

  def diamond?
    suit == 1
  end

  def spade?
    suit == 2
  end

  def to_s
    "#{rankstr} of #{suitstr}"
  end

  def inspect
    to_s
  end
end

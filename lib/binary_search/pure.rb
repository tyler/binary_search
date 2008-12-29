class Array
  def binary_index(target)
    binary_chop { |v| target <=> v }
  end

  def binary_search(&block)
    index = binary_chop(&block)
    index ? self[index] : nil
  end

  private

  def binary_chop(&block)
    upper = self.size - 1
    lower = 0

    while(upper >= lower) do
      idx = lower + (upper - lower) / 2
      comp = yield self[idx]

      if comp == 0
        return idx
      elsif comp > 0
        lower = idx + 1
      else
        upper = idx - 1
      end
    end
    nil
  end
end


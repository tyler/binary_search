class Array
  def binary_index(target)
    binary_find_index { |v| target <=> v }
  end

  def binary_search(&block)
    index = binary_find_index(&block)
    index ? self[index] : nil
  end

  def binary_find_index(&block)
    upper = self.size - 1
    lower = 0

    while upper >= lower
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


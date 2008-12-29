class Array
  def binary_index(target,lower=0,upper=self.size-1)
    return if lower > upper
    idx = lower + (upper - lower) / 2
    value = self[idx]
    if value == target
      return idx
    elsif value > target
      self.binary_index(target, lower, idx - 1)
    elsif value < target
      self.binary_index(target, idx + 1, upper)
    end
  end
end


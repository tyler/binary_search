class Array
  def binary_index(*args, &block)
    if block_given?
      if args.size > 0
        raise ArgumentError.new("No arguments allowed when a block is provided")
      end
      found, index = binary_chop_approximate(&block)
      found ? index : nil
    else
      if args.size != 1
        raise ArgumentError.new("Requires only one argument")
      end
      found, index = binary_chop_approximate { |v| args[0] <=> v }
      found ? index : nil
    end
  end

  def binary_index_approximate(*args, &block)
    if block_given?
      if args.size > 0
        raise ArgumentError.new("No arguments allowed when a block is provided")
      end
      found, index = binary_chop_approximate(&block)
      index
    else
      if args.size != 1
        raise ArgumentError.new("Requires only one argument")
      end
      found, index = binary_chop_approximate { |v| args[0] <=> v }
      index
    end
  end

  def binary_search(&block)
    found, index = binary_chop_approximate(&block)
    found ? self[index] : nil
  end

  private

  def binary_chop_approximate(&block)
    upper = self.size - 1
    lower = 0

    while(upper >= lower) do
      idx = lower + (upper - lower) / 2
      comp = yield self[idx]

      if comp == 0
        return [true, idx]
      elsif comp > 0
        lower = idx + 1
      else
        upper = idx - 1
      end
    end
    [false, upper]
  end
end


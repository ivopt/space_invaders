class Detection
  def initialize(intruder, column_number)
    @intruder = intruder
    @column_number = column_number
    @current_line = 0
    @invalid = false
    @positive = false
  end

  def push(sample, column_number)
    return if positive? || invalid?
    return if column_number != @column_number

    if current_line_matches(sample)
      @current_line += 1
    else
      @invalid = true
    end

    @positive = matched_all_intruder?
  end

  def positive?
    @positive
  end

  def invalid?
    @invalid
  end

  private

  def current_line_matches(sample)
    @intruder.bitmap[@current_line] == sample
  end

  def matched_all_intruder?
    @current_line == @intruder.length
  end
end
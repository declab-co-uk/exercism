defmodule LogLevel do
  @log_labels %{0 => :trace, 1 => :debug, 2 => :info, 3 => :warning, 4 => :error, 5 => :fatal}
  @log_labels_legacy %{1 => :debug, 2 => :info, 3 => :warning, 4 => :error}
  def to_label(level, legacy?) do
    cond do
      not legacy? -> Map.get(@log_labels, level, :unknown)
      legacy? -> Map.get(@log_labels_legacy, level, :unknown)
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    case to_label(level, legacy?) do
      output when output == :error or output == :fatal -> :ops
      output when legacy? and output == :unknown -> :dev1
      output when output == :unknown -> :dev2
      _ -> false
    end
  end
end

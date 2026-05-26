defmodule Newsletter do
  def read_emails(path) do
    case File.read(path) do
      {:ok, file} -> file |> String.split("\n", trim: true)
      {:error, error} -> {:error, error}
    end
  end

  def open_log(path) do
    case File.open(path, [:write]) do
      {:ok, pid} -> pid
      {:error, _} -> :error
    end
  end

  def log_sent_email(pid, email) do
    IO.write(pid, email <> "\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(log, email)
        _ -> :error
      end
    end)

    close_log(log)
  end
end

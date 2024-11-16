defmodule Mix.Tasks.Parse do
  use Mix.Task
  alias Html2react

  @spec run([binary()]) :: :ok
  def run(cli_args) do
    file_path = "#{cli_args}"

    IO.puts(file_path)

    case File.read(file_path) do
      {:ok, contents} ->
        parsed_html = Html2react.parse(contents)
        IO.puts("\n\n" <> parsed_html <> "\n\n")

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
    end
  end
end

defmodule Html2react do
  @moduledoc """
  Documentation for `Html2react`.
  """

  @doc """
  Parse HTML to React.

  ## Examples

      iex> Html2react.parse("<div class='test'>Hello</div>")
      "<div className='test'>Hello</div>"

  """

  @spec parse([binary() | {any(), any(), list()}]) :: binary()
  def parse(html) do
    {:ok, html} =
      html
      |> Floki.parse_document()

    html |> get_tags()
  end

  defp get_tags([{"html" = tag, attributes, children}]) do
    ~s(<#{tag} #{get_attributes(attributes)}>#{get_tags(children)}</#{tag}>)
  end

  defp get_tags([{tag, attributes, children} | rest]) do
    ~s(<#{tag} #{get_attributes(attributes)}>#{get_tags(children ++ rest)}</#{tag}>)
  end

  defp get_tags([text | rest]), do: text <> get_tags(rest)
  defp get_tags([]), do: ""

  defp get_attributes(list) do
    list
    |> Enum.reduce("", fn {k, v}, a ->
      ~s(#{a}#{convert_attribute_key(k)}=#{"'"}#{v}#{"'"})
    end)
  end

  defp convert_attribute_key(attr) do
    case attr do
      "class" -> "className"
      "for" -> "htmlFor"
      _ -> attr
    end
  end
end

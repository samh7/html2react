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
  def parse(html), do: get_tags(html)

  defp get_tags([{"html" = tag, attributes, children}]) do
    "<#{tag} #{get_attributes(attributes)}> #{get_tags(children)} </#{tag}>"
  end

  defp get_tags([{tag, attributes, children} | rest]) do
    "<#{tag} #{get_attributes(attributes)}> #{get_tags(children ++ rest)} </#{tag}>"
  end

  defp get_tags([text | rest]), do: text <> get_tags(rest)
  defp get_tags([]), do: ""

  defp get_attributes(list) do
    list
    |> Enum.reduce("", fn {k, v}, a ->
      "#{a} #{convert_attribute_key(k)}=#{<<34>>}#{v}#{<<34>>} "
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

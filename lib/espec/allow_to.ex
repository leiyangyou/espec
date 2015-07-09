defmodule ESpec.AllowTo do
  @moduledoc """
  Defines `to/2` function which make the mock.
  """
  
  @doc "Makes specific mock with ESpec.Mock.expect/3."
  def to(mock, {ESpec.AllowTo, module}) do
    case mock do
      {:accept, name, function} -> ESpec.Mock.expect(module, name, function)
      {:accept, list} when is_list(list)-> 
        if Keyword.keyword?(list) do
          Enum.each(list, fn({name, function}) -> 
            ESpec.Mock.expect(module, name, function)
          end)
        else
          Enum.each(list, &ESpec.Mock.expect(module, &1, fn -> end))
          Enum.each(list, &ESpec.Mock.expect(module, &1, fn(_) -> end))
        end
      {:accept, name} -> 
        ESpec.Mock.expect(module, name, fn -> end)  
        ESpec.Mock.expect(module, name, fn(_) -> end) 
    end
  end
end

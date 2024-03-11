defmodule Diamond do
  @moduledoc """
  Documentation for `Diamond`.
  """

  @diamond_storage_module DiamondStorage

  @doc """
  Initializes the Diamond storage with an Enumerable of keys and values.

  If the storage has already been initialized, calling this function again will
  wipe the existing data before inserting the provided key/value pairs.

  ## Examples

      iex> Diamond.initialize(%{key: "value", foo: "bar"})
      :ok

  """
  def initialize(data \\ %{}) do
    module = @diamond_storage_module
    :code.delete(module)
    :code.purge(module)

    ast =
      quote do
        defmodule unquote(module) do
          def state, do: unquote(Macro.escape(data))

          def state(id), do: Map.get(unquote(Macro.escape(data)), id)
        end
      end

    [{^module, _}] = Code.compile_quoted(ast, "nofile")
    {:module, ^module} = Code.ensure_loaded(module)
    :ok
  end

  @doc """
  Gets the value a specified key.
  """
  def get(key) do
    module = @diamond_storage_module
    module.state(key)
  end

  @doc """
  Puts an Enumerable of key/value pairs into storage, overwriting any existing values
  for given keys.  This function is optimized to update all keys in bulk.

  Note this function is resource-intensive and will block any incoming `get/1` calls
  until it completes.
  """
  def put(enum) do
    module = @diamond_storage_module

    enum
    |> Enum.reduce(module.state(), fn {k, v}, acc -> Map.put(acc, k, v) end)
    |> initialize()
  end

  @doc """
  Puts a key/value pair into storage, overwriting any existing value for the given key.

  Note this function is resource-intensive and will block any incoming `get/1` calls
  until it completes.

  Avoid calling this repeatedly i.e.

      Enum.each(pairs, fn {k, v} -> Diamond.put(k, v) end)

  Instead use `put/1` to write in bulk.
  """
  def put(key, value) do
    module = @diamond_storage_module

    module.state()
    |> Map.put(key, value)
    |> initialize()
  end
end

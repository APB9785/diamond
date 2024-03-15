defmodule Diamond do
  @moduledoc """
  Documentation for `Diamond`.
  """

  @diamond_storage_module Diamond.Storage

  @type key() :: any()
  @type value() :: any()

  @doc """
  Initializes the Diamond storage with an Enumerable of keys and values.

  If the storage has already been initialized, calling this function again will
  wipe the existing data before inserting the provided key/value pairs.

  ## Examples

      iex> Diamond.initialize(%{key: "value", foo: "bar"})
      :ok

  """
  @spec initialize(map() | Keyword.t() | [{key(), value()}]) :: :ok
  def initialize(data \\ %{}) do
    module = @diamond_storage_module
    data = Map.new(data)

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
  @spec get(key()) :: value()
  def get(key) do
    module = @diamond_storage_module
    module.state(key)
  end
end

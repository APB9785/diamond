defmodule Diamond do
  @moduledoc """
  Diamond is a read-only in-memory key/value store.

  At application startup, initialize your Diamond storage with `initialize/1`.
  Then you can call `get/1` from any process to fetch the value(s) you need.
  """

  @diamond_storage_module Diamond.Storage

  @type key() :: any()
  @type value() :: any()

  @doc """
  Initializes the Diamond storage with an Enumerable of keys and values.

  Raises an error if the Diamond storage already exists.

  Note: this can take a while with large datasets (50,000+ keys)

  ## Examples

      iex> Diamond.initialize(%{key: "value", foo: "bar"})
      :ok
      iex> Diamond.initialize([key: "value", foo: "bar"])
      :ok
      iex> Diamond.initialize([{"key", "value"}, {"foo", "bar"})
      :ok

  """
  @spec initialize(map() | Keyword.t() | [{key(), value()}]) :: :ok
  def initialize(data) do
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
  Gets the value of a specified key.

  Returns `nil` if the key does not exist in the Diamond storage.

  Raises an error if the Diamond storage is missing (e.g. cleared or not yet initialized)
  """
  @spec get(key()) :: value() | nil
  def get(key) do
    module = @diamond_storage_module
    module.state(key)
  end

  @doc """
  Deletes the Diamond storage.

  This

  Warning:  After dropping the storage, your app may no longer call `get/1` unless Diamond is
  re-initialized using `initialize/1`.  Otherwise an error will be raised.
  """
  @spec drop() :: :ok
  def drop do
    module = @diamond_storage_module
    :code.delete(module)
    :code.purge(module)
    :ok
  end
end

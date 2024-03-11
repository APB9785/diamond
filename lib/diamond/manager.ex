defmodule Diamond.Manager do
  @moduledoc """
  Currently unused.

  This will eventually act as a middleman for writes to keep track of various metrics
  about the storage, help prevent data corruption, and possibly provide some features
  for caching and/or sharding.
  """
  use GenServer

  alias Diamond.Utils

  @diamond_storage_module DiamondStorage

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # API

  def put(data) do
    GenServer.call(__MODULE__, {:put, data})
  end

  def overwrite(data) do
    GenServer.call(__MODULE__, {:overwrite, data})
  end

  # Callbacks

  def init(_opts) do
    {:ok, %{}}
  end

  def handle_call({:put, data}, _from, state) do
    data = Map.new(data)

    @diamond_storage_module
    |> Utils.call_function_with_retry!(:state, [])
    |> Map.merge(data)
    |> write!()

    {:reply, :ok, state}
  end

  def handle_call({:overwrite, data}, _from, state) do
    data
    |> Map.new()
    |> write!()

    {:reply, :ok, state}
  end

  defp write!(data) do
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
  end
end

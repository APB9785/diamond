defmodule Diamond.Utils do
  @moduledoc false

  def call_function_with_retry!(module, function, args, failure_count \\ 0) do
    apply(module, function, args)
  rescue
    _e in UndefinedFunctionError ->
      if failure_count >= 10 do
        raise Diamond.StorageError
      else
        :timer.sleep(100 * failure_count)
        call_function_with_retry!(module, function, args, failure_count + 1)
      end
  end
end

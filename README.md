# Diamond

A read-only in-memory key/value storage optimized for maximum performance

## Installation

Coming soon to Hex!

## Usage

```elixir
data = %{foo: "bar", baz: "bong"}
:ok = Diamond.initialize(data)

"bar" = Diamond.get(:foo)
```

## Benchmarks

Coming soon:  comparison with `:ets`, `:persistent_term`, and more

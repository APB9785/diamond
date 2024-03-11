# Diamond

An in-memory key/value storage heavily optimized for fast reads at the expense of slow write time

## Installation

Coming soon to Hex!

## Usage

```elixir
data = get_key_value_pairs()
:ok = Diamond.initialize(data)

Diamond.put(:foo, "value")
"value" = Diamond.get(:foo)
```

## Benchmarks

Coming soon:  comparison with `:ets`, `:persistent_term`, and more

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

Read times

### Small (100 rows)
```
Diamond           - 75_888_000 / sec  
:persistent_term  - 44_868_000 / sec  (1.6x slower)  
:ets (async)      -  9_803_000 / sec  (7x slower)  
GenServer (Map)   -   952_000 / sec  (79x slower)  
:ets (serialized) -   832_000 / sec  (91x slower)  
```
### Medium (1,000 rows)
```
Diamond           - 81_918_000 / sec  
:persistent_term  - 45_045_000 / sec  (1.8x slower)  
:ets (async)      -  9_176_000 / sec  (8x slower)  
GenServer (Map)   -    946_000 / sec  (86x slower)  
:ets (serialized) -    823_000 / sec  (99x slower)  
```
### Large (10,000 rows)
```
Diamond           - 72_992_000 / sec  
:persistent_term  - 39_354_000 / sec  (1.8x slower)  
:ets (async)      -  8_693_000 / sec  (8x slower)  
GenServer (Map)   -    928_000 / sec  (78x slower)  
:ets (serialized) -    823_000 / sec  (88x slower)  
```
### X-Large (100,000 rows)
```
Diamond           - 57_844_000 / sec  
:persistent_term  - 34_447_000 / sec  (1.6x slower)  
:ets (async)      -  8_591_000 / sec  (6x slower)  
GenServer (Map)   -    922_000 / sec  (62x slower)  
:ets (serialized) -    821_000 / sec  (70x slower)  
```
### Huge (500,000 rows)
```
Diamond           - 50_634_000 / sec  
:persistent_term  - 34_000_000 / sec  (1.5x slower)  
:ets (async)      -  8_579_000 / sec  (6x slower)  
GenServer (Map)   -    935_000 / sec  (54x slower)  
:ets (serialized) -    818_000 / sec  (62x slower)  
```
# Rōsoku (candles)
Haskell module to transform currency exchange transactions into japanese candle-sticks style graphs elements

## why
- data aggregation (we are currently storing raw transaction data at a granularity we do not need, and storing candlestick data should save space on our poor tiny cheap digital ocean droplets)
- practice data manipulation
- practice haskell

## goals
- provide ways to injest data in multiple formats (json, csv..)
- integration with postgre/timescaledb

## roadmap
- transaction aggregation into candles
- candle aggregation from smaller time-scale to bigger time-scale
- parsers for both json and csv serialized transactions and candles
- integration with postgres db via postgrest to store candle data
- implement TUI to visualize and explore converted data (mostly to practice TUI creation with brick)



module Lib where

import Data.List (groupBy, map)
import Candle
import ExchangeTransaction

someFunc :: IO ()
someFunc = putStrLn "WIP - Apologies, the main functionality of this application is not implemented at this time"

-- helper function to transform transactions to the most granular possible candles
transformToSecondCandles :: [ExchangeTransaction] -> [Candle]
transformToSecondCandles trxs =
  map (mconcat . (map toCandle)) $ groupBy (\a b -> epoch a == epoch b) trxs

toCandle :: ExchangeTransaction -> Candle
toCandle t =
  Candle
    { epochStart = epoch t
    , epochEnd = epoch t
    , volume = amount t
    , high = price t
    , low = price t
    , open = price t
    , close = price t
    }

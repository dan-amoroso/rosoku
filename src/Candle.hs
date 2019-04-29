module Candle where

data Candle
  = EmptyCandle
  | Candle { epochStart :: Integer
           , epochEnd :: Integer
           , volume :: Double -- sum of all transaction amounts during time range
           , high :: Double -- highest transaction price during time range
           , low :: Double -- lowest transaction price during time range
           , open :: Double -- first transaction price
           , close :: Double -- last transaction price
            }
  deriving (Show, Eq)

instance Ord Candle where
  ca `compare` cb = (epochStart ca) `compare` (epochStart cb)

instance Semigroup Candle where
  x <> EmptyCandle = x
  EmptyCandle <> x = x
  ca <> cb =
    Candle
      { epochStart = minimum [(epochStart ca), (epochStart cb)]
      , epochEnd = maximum [(epochEnd ca), (epochEnd cb)]
      , volume = volume ca + volume cb
      , high = maximum [(high ca), (high cb)]
      , low = minimum [(low ca), (high cb)]
      , open = (open . minimum) [ca, cb]
      , close = (close . maximum) [ca, cb]
      }

instance Monoid Candle where
  mempty = EmptyCandle

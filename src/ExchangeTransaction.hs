module ExchangeTransaction where

data ExchangeTransaction = Transaction
  { _id :: String
  , epoch :: Integer -- timestamp
  , exchange :: Exchange
  , price :: Double
  , amount :: Double
  , operationType :: OperationType
  , symbol :: Symbol
  } deriving (Show, Eq)

data Symbol
  = BTC
  | ETH
  deriving (Show, Eq)

data OperationType
  = Buy
  | Sell
  deriving (Show, Eq)

data Exchange
  = Bitfinex
  | Others
  deriving (Show, Eq)

-- order ExchangeTransaction chronologically from earlier to latest by default
instance Ord ExchangeTransaction where
  ta `compare` tb = (epoch ta) `compare` (epoch tb)

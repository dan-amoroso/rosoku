{-# LANGUAGE TemplateHaskell #-}

import Test.QuickCheck
import Test.QuickCheck.Modifiers (NonEmptyList)
import Data.List (sort)

import Lib
import Candle
import ExchangeTransaction


-- TEST CASES 

-- for any single arbitrary transactions
-- the candle resulting from converting that transaction holds the correct data

prop_converted_single_transaction :: ExchangeTransaction -> Bool
prop_converted_single_transaction transaction =
  and
    [ volume candle == amount transaction
    , and $ map (== epoch transaction) [epochStart candle, epochEnd candle]
    , and $
      map
        (== price transaction)
        [high candle, low candle, open candle, close candle]
    ]
  where
    candle = toCandle transaction

-- for any number of candles in a sorted list
-- the first candle has the earliest epoch start

prop_first_candle_has_earliest_epoch :: NonEmptyList Candle -> Bool
prop_first_candle_has_earliest_epoch (NonEmpty cs) =
  epochStart h <= (minimum $ map epochStart cs)
  where
    h = head $ sort cs


-- HELPER FUNCTIONS

positive :: (Arbitrary a, Ord a, Num a ) => Gen a
positive = getPositive <$> arbitrary


-- ARBITRARY INSTANCES

instance Arbitrary ExchangeTransaction where
    arbitrary = Transaction <$> arbitrary -- string, for _id
                            <*> positive -- Integer, for epoch time
                            <*> return Bitfinex -- exchange
                            <*> positive -- price
                            <*> positive -- amount
                            <*> return Buy -- operation type
                            <*> return BTC 

instance Arbitrary Candle where 
    arbitrary = Candle <$> positive
                       <*> positive
                       <*> positive
                       <*> positive
                       <*> positive
                       <*> positive
                       <*> positive


return [] -- odd statement to allow quickcheck to test all properties in this module

main :: IO Bool 
main = $quickCheckAll

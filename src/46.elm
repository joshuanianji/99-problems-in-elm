module Main exposing (and_, equivalent, implies, main, nand_, nor_, or_, truthTable, xor_)

import Debug
import Html exposing (..)



-- logical binary functions and the truth table


and_ : Bool -> Bool -> Bool
and_ a b =
    a && b


or_ : Bool -> Bool -> Bool
or_ a b =
    a || b


nand_ : Bool -> Bool -> Bool
nand_ a b =
    not a || not b


nor_ : Bool -> Bool -> Bool
nor_ a b =
    not a && not b


xor_ : Bool -> Bool -> Bool
xor_ a b =
    or_ a b && not (and_ a b)


implies : Bool -> Bool -> Bool
implies a b =
    not a || b


equivalent : Bool -> Bool -> Bool
equivalent a b =
    a == b


truthTable : (Bool -> Bool -> Bool) -> List ( Bool, Bool, Bool )
truthTable function =
    [ ( True, True, function True True )
    , ( True, False, function True False )
    , ( False, True, function False True )
    , ( False, False, function False False )
    ]


main : Html msg
main =
    truthTable implies
        |> Debug.toString
        |> Html.text

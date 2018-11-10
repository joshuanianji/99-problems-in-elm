module Main exposing (main, truthTable)

import Debug
import Html exposing (..)



{-
   INFIX OPERTORS ARE NOT ALLOWED IN ELM 0.19!
   lol rip
-}
-- logical binary functions but with infix operators


(.&) : Bool -> Bool -> Bool
(.&) a b =
    a && b


(.|) : Bool -> Bool -> Bool
(.|) a b =
    a || b


(/&) : Bool -> Bool -> Bool
(/&) a b =
    not a || not b


(/|) : Bool -> Bool -> Bool
(/|) a b =
    not a && not b


(*|) : Bool -> Bool -> Bool
(*|) a b =
    a .| b && not (a .& b)


(.^) : Bool -> Bool -> Bool
(.^) a b =
    not a || b


(.=) : Bool -> Bool -> Bool
(.=) a b =
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
    truthTable (\a b -> a .& (a .| b))
        |> Debug.toString
        |> Html.text

module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- This one was actually very easy


myList =
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]


duplicate : List a -> List a
duplicate list =
    concatMap
        (\x -> [ x, x ])
        list


main : Html msg
main =
    duplicate myList
        |> Debug.toString
        |> Html.text

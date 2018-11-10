module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- An easy one


myList =
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]


dropAt : Int -> List a -> List a
dropAt n list =
    case list of
        [] ->
            []

        hd :: tl ->
            if n == 1 then
                tl

            else
                hd :: dropAt (n - 1) tl


main : Html msg
main =
    dropAt 3 myList
        |> Debug.toString
        |> Html.text

module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Debug


-- Haha didn't think about List.drop and take for like a lot. Did something else entirely ew


myList =
    [ 1, 2, 3, 4, 5 ]


insertAt : Int -> a -> List a -> List a
insertAt position element list =
    take (position - 1) list
        ++ [ element ]
        ++ drop (position - 1) list


main : Html msg
main =
    insertAt 3 8 myList
        |> Debug.toString
        |> Html.text

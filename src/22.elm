module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Debug


-- Haha didn't think about List.drop and take for like a lot. Did something else entirely ew


myList =
    [ 1, 2, 3, 4, 5 ]


rangeList start end =
    if start > end then
        reverse (range end start)
    else
        range start end

main : Html msg
main =
    rangeList 6 2
        |> Debug.toString
        |> Html.text

module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- Haha didn't think about List.drop and take for like a lot. Did something else entirely ew


myList =
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]


sublist start end list =
    let
        lowerBound =
            if start < 0 then
                0

            else if start > length list then
                length list

            else
                start - 1

        upperBound =
            if end < 0 then
                0

            else if end > length list then
                length list

            else
                end
    in
    list
        |> take upperBound
        |> drop lowerBound


main : Html msg
main =
    sublist 0 1 myList
        |> Debug.toString
        |> Html.text

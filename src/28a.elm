module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- Sorting a list by its length


sortByListLengths : List (List a) -> List (List a)
sortByListLengths list =
    sortBy length list


lists =
    [ [ 1 ], [ 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ], [ 2, 3 ], [ 4, 5 ], [ 6, 7, 8, 9, 0 ] ]


main : Html msg
main =
    sortByListLengths lists
        |> Debug.toString
        |> Html.text

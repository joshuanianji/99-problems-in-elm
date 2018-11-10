module Main exposing (main)

import Html exposing (Html)
import List
import Debug


-- wasn't that easy but still pretty easy


myList =
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]


dropNth : Int -> List a -> List a
dropNth n x =
    let
        dropNthIter amount cycle list =
            case list of
                [] ->
                    []

                hd :: tl ->
                    if cycle == 1 then
                        dropNthIter amount amount tl
                    else
                        hd :: dropNthIter amount (cycle - 1) tl
    in
    dropNthIter n n x


main : Html msg
main =
    dropNth 3 myList
        |> Debug.toString
        |> Html.text

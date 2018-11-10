module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Debug


-- Another easy one


myList =
    [ 1, 2, 3, 3 ]


repeatElements : Int -> List a -> List a
repeatElements n list =
    concatMap
        (\x -> repeat n x)
        list


main : Html msg
main =
    repeatElements 3 myList
        |> Debug.toString
        |> Html.text

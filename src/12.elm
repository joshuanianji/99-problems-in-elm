module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- This one was actually very easy


type RleCode a
    = Run Int a
    | Single a


rleList =
    [ Run 4 1, Single 2, Run 2 5, Single 2, Single 1 ]


rleDecode : List (RleCode a) -> List a
rleDecode list =
    concatMap
        rleFunc
        list


rleFunc : RleCode a -> List a
rleFunc element =
    case element of
        Run number a ->
            repeat number a

        Single a ->
            [ a ]


main : Html msg
main =
    rleDecode rleList
        |> Debug.toString
        |> Html.text

module Main exposing (main)

import Html exposing (Html)
import List exposing (..)
import Debug


-- labels each list by the amount of elements and the element


myLists =
    [ ['a','a','a']
    , ['b']
    , ['c', 'c', 'c']
    , ['d','d','d','d']
    , ['e']
    , ['f', 'f']
    ]



runLengths : List (List a) -> List ( Int, a )
runLengths lists =
    map
        (\subList ->
            ( length subList, head subList )
        )
        lists
        |> removeNothings


removeNothings : List ( Int, Maybe a ) -> List ( Int, a )
removeNothings list =
    case list of
        [] ->
            []

        ( length, Nothing ) :: xs ->
            removeNothings xs

        ( length, Just a ) :: xs ->
            ( length, a ) :: removeNothings xs


main : Html msg
main =
    runLengths myLists
        |> Debug.toString
        |> Html.text

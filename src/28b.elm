module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- Sorting a list the frequency of the sublist length
-- pack makes all lists of the same length combine into one list
-- the actual answer was wayy different but I don't care cuz this answer is modulated and nice lol


pack : List (List a) -> List (List (List a))
pack xs =
    case xs of
        [] ->
            []

        hd :: tl ->
            let
                remainder =
                    dropWhile (\x -> length x == length hd) tl
            in
            takeWhile (\x -> length x == length hd) xs :: pack remainder


takeWhile : (a -> Bool) -> List a -> List a
takeWhile predicate xs =
    case xs of
        [] ->
            []

        hd :: tl ->
            if predicate hd then
                hd :: takeWhile predicate tl

            else
                []


dropWhile : (a -> Bool) -> List a -> List a
dropWhile predicate list =
    case list of
        [] ->
            []

        hd :: tl ->
            if predicate hd then
                dropWhile predicate tl

            else
                list


sortByListLengths : List (List a) -> List (List a)
sortByListLengths list =
    sortBy length list


sortByLengthFrequency list =
    pack list
        |> sortByListLengths
        |> concat


lists =
    [ [] ]


main : Html msg
main =
    sortByLengthFrequency lists
        |> Debug.toString
        |> Html.text

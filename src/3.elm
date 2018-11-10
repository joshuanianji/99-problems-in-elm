module Main exposing (elementAt, main)

import Debug
import Html exposing (text)



-- This returns the element at an index (starting at 1 lol)
-- I was really close to the answer. I just didn't need the [a] case.


elementAt : List a -> Int -> Maybe a
elementAt list n =
    if n < 1 then
        Nothing

    else
        case List.drop (n - 1) list of
            [] ->
                Nothing

            [ a ] ->
                Just a

            x :: xs ->
                Just x


main =
    case elementAt [ 1, 2, 3, 4 ] 1 of
        Just a ->
            text (Debug.toString a)

        Nothing ->
            text "No element found"

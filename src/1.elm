module Main exposing (betterLast, last, main)

import Debug
import Html exposing (text)
import Maybe



-- Gets the last element. This is honestly a really bad strategy. the better one is shown below.


last : List a -> Maybe a
last xs =
    let
        lastIter : List a -> Maybe a -> Maybe a
        lastIter list answer =
            case list of
                [] ->
                    answer

                y :: ys ->
                    lastIter ys (Just y)
    in
    lastIter xs Nothing


betterLast : List a -> Maybe a
betterLast xs =
    case xs of
        [] ->
            Nothing

        [ a ] ->
            Just a

        y :: ys ->
            betterLast ys


main =
    case last [ 1, 2, 3, 4 ] of
        Just a ->
            text (Debug.toString a)

        Nothing ->
            text "No element found"

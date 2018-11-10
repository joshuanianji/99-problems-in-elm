module Main exposing (main, penultimate)

import Debug
import Html exposing (text)



-- I am a bit prouder of this, but the code could have been neater after looking at the solution. I could have added another case like [y, z]. This returns the second last element


penultimate : List a -> Maybe a
penultimate xs =
    case xs of
        [] ->
            Nothing

        [ a ] ->
            Nothing

        y :: ys ->
            case ys of
                [ b ] ->
                    Just y

                _ ->
                    penultimate ys


main =
    case penultimate [ 1, 2, 3, 4 ] of
        Just a ->
            text (Debug.toString a)

        Nothing ->
            text "No element found"

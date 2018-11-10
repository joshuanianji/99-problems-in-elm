module Main exposing (dropAt, elementAt, lotto, randSelect)

import Html exposing (..)
import Html.Events exposing (..)
import Random



-- lotto is very similar to the randSelect. The solution in the book was completely built upon the solution in solution 23, though, and I guess it was smarter making the code more modular that way, and not slightly deconstructing the code from before and making it really hard to read.
{--
import Tuple

lotto : Random.Seed -> Int -> Int -> Int -> List Int
lotto seed n low high =
    List.sort
        <| Tuple.first
        <| randomSelect seed n [low .. high]
--}


elementAt : Int -> List a -> Maybe a
elementAt n list =
    case list of
        [] ->
            Nothing

        x :: xs ->
            if n == 1 then
                Just x

            else
                elementAt (n - 1) xs


dropAt : Int -> List a -> List a
dropAt n list =
    case list of
        [] ->
            []

        hd :: tl ->
            if n == 1 then
                tl

            else
                hd :: dropAt (n - 1) tl


lotto : Random.Seed -> Int -> Int -> Int -> List Int
lotto seed amount lower upper =
    let
        ( acc, l, s ) =
            randSelect amount ( [], List.range lower upper, seed )
    in
    acc
        |> List.sort


randSelect : Int -> ( List a, List a, Random.Seed ) -> ( List a, List a, Random.Seed )
randSelect n ( acc, list, seed ) =
    if n > 0 then
        let
            ( randPosition, seed_ ) =
                Random.step (Random.int 1 (List.length list)) seed

            remainingList =
                dropAt randPosition list

            randElement =
                elementAt randPosition list
        in
        case randElement of
            Nothing ->
                ( acc, list, seed )

            Just element ->
                randSelect (n - 1) ( element :: acc, remainingList, seed_ )

    else
        ( acc, list, seed )

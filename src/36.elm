module Main exposing (main)

import Debug
import Html exposing (Html)



-- this is pretty slow though rip


primesUntil n =
    let
        eratos candidates primes =
            case candidates of
                [] ->
                    List.reverse primes

                x :: xs ->
                    let
                        cs =
                            List.filter (\y -> remainderBy y x /= 0) xs
                    in
                    eratos cs (x :: primes)
    in
    eratos (List.range 2 n) []


gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
        abs a

    else
        gcd b (remainderBy b a)


coprime : Int -> Int -> Bool
coprime a b =
    gcd a b == 1


primeFactors num =
    let
        primeList =
            List.reverse (primesUntil num)

        primeFactorIter n list answer =
            case list of
                [] ->
                    answer

                x :: xs ->
                    if coprime x n then
                        primeFactorIter n xs answer

                    else
                        primeFactorIter (n // x) list (x :: answer)
    in
    primeFactorIter num primeList []


pack : List a -> List (List a)
pack xs =
    case xs of
        [] ->
            []

        y :: ys ->
            packIter y [ y ] ys


packIter : a -> List a -> List a -> List (List a)
packIter v run xs =
    case xs of
        [] ->
            [ run ]

        y :: ys ->
            if y == v then
                packIter y (y :: run) ys

            else
                run :: packIter y [ y ] ys


runLengths : List (List a) -> List ( a, Int )
runLengths lists =
    List.map
        (\subList ->
            ( List.length subList, List.head subList )
        )
        lists
        |> removeNothings


removeNothings : List ( Int, Maybe a ) -> List ( a, Int )
removeNothings list =
    case list of
        [] ->
            []

        ( length, Nothing ) :: xs ->
            removeNothings xs

        ( length, Just a ) :: xs ->
            ( a, length ) :: removeNothings xs


primeFactorsM n =
    primeFactors n
        |> pack
        |> runLengths


main : Html msg
main =
    primeFactorsM 9007
        |> Debug.toString
        |> Html.text

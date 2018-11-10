module Main exposing (main)

import Debug
import Html exposing (Html)


gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
        abs a

    else
        gcd b (rem a b)


coprime : Int -> Int -> Bool
coprime a b =
    gcd a b == 1


totient : Int -> Int
totient n =
    List.length <| coprimes n


coprimes : Int -> List Int
coprimes n =
    List.filter (\x -> coprime n x) (List.range 1 n)


{--}
primesUntil n =
    let
        eratos candidates primes =
            case candidates of
                [] ->
                    List.reverse primes

                x :: xs ->
                    let
                        cs =
                            List.filter (\y -> (y % x) /= 0) xs
                    in
                    eratos cs (x :: primes)
    in
    eratos (List.range 2 n) []


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


primeFactorsM : Int -> List ( Int, Int )
primeFactorsM n =
    primeFactors n
        |> pack
        |> runLengths



-- phi is kinda debated but in this case phi of zero is zero


phi : Int -> Int
phi m =
    if m < 1 then
        0

    else
        primeFactorsM m
            |> List.map
                (\( p, m ) -> (p - 1) * p ^ (m - 1))
            |> List.product


test n =
    phi n == totient n


main : Html msg
main =
    phi 0
        |> Debug.toString
        |> Html.text

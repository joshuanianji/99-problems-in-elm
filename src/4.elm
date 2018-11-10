module Main exposing (countElements, main)

import Debug
import Html exposing (text)



-- This counts the amount of elements in the list. Wow, this is as simple as one of the answers!!
-- I really like the recursive strategy, though. Here's it below (in comments lmao)
{-
   countElements : List a -> Int
   countElements list =
       case list of
           [ ] -> 0
           _ :: ys -> 1 + countElements ys
-}


countElements : List a -> Int
countElements list =
    List.foldr
        (\element value ->
            value + 1
        )
        0
        list


main =
    countElements [ 1, 2, 3, 4, 5, 1 ]
        |> Debug.toString
        |> Html.text

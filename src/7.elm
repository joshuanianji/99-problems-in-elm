module Main exposing (main)

import Debug
import Html exposing (Html)
import List exposing (..)



-- The answer is LOT more simple:
{-
   flatten : NestedList a -> List a
   flatten nl =
       case nl of
           Elem x ->
               [ x ]

           SubList sl ->
               List.concatMap flatten sl
-}


type NestedList a
    = Elem a
    | SubList (List (NestedList a))


nl1 : NestedList Int
nl1 =
    SubList
        [ Elem 1
        , SubList
            [ SubList
                [ Elem 2
                , SubList [ Elem 3, Elem 4 ]
                ]
            , Elem 5
            ]
        , Elem 6
        , SubList [ Elem 7, Elem 8, Elem 9 ]
        ]


flatten : NestedList a -> List a
flatten nested =
    case nested of
        Elem a ->
            [ a ]

        SubList list ->
            foldr
                (\elem acc ->
                    append (flatten elem) acc
                )
                []
                list


main : Html msg
main =
    flatten nl1
        |> Debug.toString
        |> Html.text

module Model exposing (..)

import Dict exposing (Dict)
import Html exposing (Html, text)
import Maybe exposing (Maybe)
import Random exposing (Seed)
import String exposing (..)
import Time exposing (Time)


type alias Model =
    { randomSeed : Maybe Seed
    , selection1 : Maybe String
    , selection2 : Maybe String
    , startTime : Maybe Time
    }


type Msg
    = CloseWelcomeScreen
    | Dropdown1Picked String
    | Dropdown2Picked String
    | StartApp Time


items : List ( String, String -> String )
items =
    [ ( "noChange", identity )
    , ( "allCaps", allCaps )
    , ( "allLower", allLower )
    , ( "dropFirst", dropFirst )
    , ( "dropLast", dropLast )
    , ( "justConsonants", justConsonants )
    , ( "justVowels", justVowels )
    , ( "reverse", reverse )
    , ( "rotate", rotate )
    ]


allCaps : String -> String
allCaps s =
    String.toUpper s


allLower : String -> String
allLower s =
    String.toLower s


dropFirst : String -> String
dropFirst s =
    dropLeft 1 s


dropLast : String -> String
dropLast s =
    dropRight 1 s


justConsonants : String -> String
justConsonants s =
    filter (\c -> contains (fromChar c) "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ") s


justVowels : String -> String
justVowels s =
    filter (\c -> contains (fromChar c) "aeiouAEIOU") s


noChange =
    identity


reverse : String -> String
reverse s =
    String.reverse s


rotate : String -> String
rotate s =
    (dropLeft 1 s) ++ (left 1 s)

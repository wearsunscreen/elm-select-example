module Model exposing (..)

import Dict exposing (Dict)
import Html exposing (Html, text)
import Maybe exposing (Maybe)
import Random exposing (Seed)
import String exposing (..)
import Time exposing (Time)


type alias Model =
    { randomSeed : Maybe Seed
    , startTime : Maybe Time
    , function1 : Maybe DeviceName
    , function2 : Maybe DeviceName
    , openDropDown : OpenDropDown
    }


type Msg
    = CloseWelcomeScreen
    | StartApp Time
    | Toggle OpenDropDown
    | Device1Picked DeviceName
    | Device2Picked DeviceName
    | Blur


type OpenDropDown
    = AllClosed
    | Device1DropDown
    | Device2DropDown



-- simple types so we can read the code better


type alias DeviceName =
    String



-- global constants/ config


functions : List ( DeviceName, String -> String )
functions =
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

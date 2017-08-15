module Update exposing (..)

import Model exposing (..)
import Random exposing (Seed, initialSeed)
import Task exposing (Task, perform)
import Time exposing (now)
import Mouse


init : ( Model, Cmd Msg )
init =
    { selection1 = Nothing
    , selection2 = Nothing
    , randomSeed = Nothing
    , startTime = Nothing
    }
        ! []


subs : Model -> Sub Msg
subs model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CloseWelcomeScreen ->
            model ! [ Task.perform StartApp Time.now ]

        StartApp time ->
            ( { model
                | startTime = Just time
                , randomSeed = Just (initialSeed (truncate time * 1000))
              }
            , Cmd.none
            )

        Dropdown1Picked pickedDropdown1 ->
            { model
                | selection1 = Just pickedDropdown1
            }
                ! []

        Dropdown2Picked pickedDropdown2 ->
            { model
                | selection2 = Just pickedDropdown2
            }
                ! []

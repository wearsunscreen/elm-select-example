module Update exposing (..)

import Model exposing (..)
import Random exposing (Seed, initialSeed)
import Task exposing (Task, perform)
import Time exposing (now)
import Mouse


init : ( Model, Cmd Msg )
init =
    { function1 = Nothing
    , function2 = Nothing
    , openDropDown = AllClosed
    , randomSeed = Nothing
    , startTime = Nothing
    }
        ! []


subs : Model -> Sub Msg
subs model =
    case model.openDropDown of
        AllClosed ->
            Sub.none

        _ ->
            Mouse.clicks (always Blur)


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

        Toggle dropdown ->
            let
                newOpenDropDown =
                    if model.openDropDown == dropdown then
                        AllClosed
                    else
                        dropdown
            in
                { model
                    | openDropDown = newOpenDropDown
                }
                    ! []

        Device1Picked pickedDevice1 ->
            { model
                | function1 = Just pickedDevice1
                , openDropDown = AllClosed
            }
                ! []

        Device2Picked pickedDevice2 ->
            { model
                | function2 = Just pickedDevice2
                , openDropDown = AllClosed
            }
                ! []

        Blur ->
            { model
                | openDropDown = AllClosed
            }
                ! []

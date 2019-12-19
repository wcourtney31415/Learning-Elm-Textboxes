module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { txtUsername : String, txtPassword : String, outUsername : String, outPassword : String }


init : Model
init =
    { txtUsername = "john@company.com", txtPassword = "B35tP@55W0RD", outUsername = "", outPassword = "" }


type Msg
    = UsernameTextboxChange String
    | PasswordTextboxChange String
    | GoButtonClicked


update : Msg -> Model -> Model
update msg model =
    case msg of
        UsernameTextboxChange str ->
            { model | txtUsername = str }

        PasswordTextboxChange str ->
            { model | txtPassword = str }

        GoButtonClicked ->
            { model | outUsername = model.txtUsername, outPassword = model.txtPassword }


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput UsernameTextboxChange, value model.txtUsername ] []
        , input [ onInput PasswordTextboxChange, value model.txtPassword ] []
        , button [ onClick GoButtonClicked ] [ text "Go!" ]
        , text ("User: " ++ model.outUsername)
        , text (" Password: " ++ model.outPassword)
        ]

module Pages.Index exposing (Config, Model, Msg, app, configE, main)

import Browser as B
import Dict exposing (Dict)
import Element as E
import Element.Font as EF
import Json.Decode as JD
import Json.Encode as JE
import Realm as R
import Realm.Utils as RU exposing (edges)


main =
    R.app app


app : R.App Config Model Msg
app =
    R.App config R.init0 R.update0 R.sub0 document


type alias Todo =
    { value : String
    , status : Bool
    }


type alias Config =
    { list : List Todo
    }


type alias Model =
    { list : List Todo
    }


type Msg
    = NoOp


todoView : Todo -> E.Element (R.Msg Msg)
todoView t =
    E.el [] (E.text t.value)


empty : Int -> E.Element (R.Msg Msg)
empty width =
    E.el []
        (E.text
            "No ToDos, yay!"
        )


view : Model -> E.Element (R.Msg Msg)
view m =
    let
        todos =
            List.map todoView m.list
    in
    E.column [] todos


document : R.In -> Config -> B.Document (R.Msg Msg)
document in_ =
    view >> R.document in_


todo : JD.Decoder Todo
todo =
    JD.succeed Todo
        |> R.field "value" JD.string
        |> R.field "status" JD.bool


config : JD.Decoder Config
config =
    JD.map Config
        (JD.field "list" (JD.list todo))


todoE : Todo -> JD.Value
todoE i =
    JE.object
        [ ( "value", JE.string i.value )
        , ( "status", JE.bool i.status )
        ]


configE : Config -> JE.Value
configE c =
    JE.object [ ( "list", JE.list todoE c.list ) ]

module Pages.Index exposing (Config, Model, Msg, app, configE, main)

import Browser as B
import Element as E
import Element.Background as EB
import Element.Border as EBo
import Element.Font as EF
import Json.Decode as JD
import Json.Encode as JE
import Realm as R


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


navbar : List (E.Attribute (R.Msg Msg)) -> E.Element (R.Msg Msg)
navbar attr =
    E.row
        (List.append
            attr
            [ E.width E.fill
            , E.padding 20
            , EBo.shadow
                { offset = ( 0, -10 )
                , size = 15
                , blur = 15
                , color = E.rgba255 131 110 93 0.1
                }
            ]
        )
        [ E.el [ E.alignLeft ]
            (E.text "Todo List")
        , E.row
            [ E.alignRight, E.spacing 20 ]
            [ E.el [] (E.text "Engineering")
            , E.el [] (E.text "Repo")
            , E.el [] (E.text "Blog")
            , E.el [] (E.text "Link")
            ]
        ]


sidebar : E.Element (R.Msg Msg)
sidebar =
    E.column [ E.width (E.px 300), EB.color (E.rgb255 253 247 247), E.height E.fill, E.padding 20, EF.size 20 ]
        [ E.el [ E.paddingXY 0 20 ] E.none
        , E.column [ E.spacing 10, E.width E.fill ]
            [ E.el [ EF.size 16 ] (E.text "Starred")
            , E.el [] (E.text "Design Updates")
            , E.el [] (E.text "Release Changes")
            , E.el [] (E.text "Customer Service")
            ]
        , E.el [ E.width E.fill, E.padding 40 ]
            (E.el
                [ E.width E.fill
                , EBo.widthEach
                    { bottom = 1
                    , left = 0
                    , right = 0
                    , top = 1
                    }
                ]
                E.none
            )
        , E.column [ E.spacing 10, E.width E.fill ]
            [ E.el [] (E.text "Design Updates")
            , E.el [] (E.text "Release Changes")
            , E.el [] (E.text "Customer Service")
            ]
        ]


view : Model -> E.Element (R.Msg Msg)
view m =
    let
        todos =
            List.map todoView m.list

        content =
            E.row [ E.width E.fill, E.height E.fill ]
                [ sidebar
                , E.column [ E.centerX, E.centerY ] todos
                ]
    in
    E.column [ E.width E.fill, E.height E.fill ]
        [ navbar [ E.inFront content ]
        ]


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

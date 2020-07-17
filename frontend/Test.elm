module Test exposing (main)

import Json.Encode as JE
import Pages.IndexTest as Index
import Realm.Test as RT
import Routes


main =
    RT.app { tests = tests, title = "Realm Starter App" }


tests : List RT.Test
tests =
    let
        context =
            [ ( "name", JE.string "Realm Tutorial" ) ]

        f : String -> List RT.Step -> RT.Test
        f id steps =
            { id = id, context = context, steps = steps }

        t =
            [ f "index" index
            ]
    in
    t


index : List RT.Step
index =
    [ RT.Navigate Index.fresh Routes.index
    , RT.Navigate Index.increment Routes.increment
    ]

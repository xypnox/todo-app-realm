module Pages.IndexTest exposing (..)

import Pages.Index as M
import Realm as R
import Realm.Utils as RU


fresh : ( String, String )
fresh =
    ( "Index", "fresh" )


increment : ( String, String )
increment =
    ( "Index", "increment" )


main =
    R.test0 M.app init


init : R.In -> R.TestFlags M.Config -> ( M.Config, Cmd (R.Msg ()) )
init in_ test =
    let
        id =
            ( "Index", test.id )

        ( m, c ) =
            M.app.init in_ test.config

        f : List R.TestResult -> ( M.Config, Cmd (R.Msg ()) )
        f l =
            ( m, R.result c (l ++ [ R.TestDone ]) )
    in
    (if id == fresh then
        [ RU.match "message match"
            "hello world"
            test.config.message
        , RU.match "count match"
            0
            test.config.count
        ]

     else if id == increment then
        [ RU.match "message match"
            "hello world"
            test.config.message
        , RU.match "count match"
            1
            test.config.count
        ]

     else
        [ R.TestFailed test.id "IndexTest: id not known" ]
    )
        |> f

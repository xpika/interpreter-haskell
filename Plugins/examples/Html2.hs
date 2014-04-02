let a = (td << "Pane")
    t x = thediv ! [thestyle "float:left;margin:10pt"] << ( (table ! [border 1]) << x)
    in besides (map t [
                 a <-> a
                ,a </> a
                ,a <-> a </> a
                ,a </> a <-> a
                ,a <-> a </> a <-> a
                ,a </> a <-> (a </> a)
                ,a </> (a </> a) <-> a
                ,a </> a </> a <-> a
                ,a <-> a </> a </> a
                ,a <-> a <-> a </> a
                ,(a </> a) <-> (a </> a <-> a)
                ,(a </> a <-> a) <-> (a </> a)
                ,(a </> a <-> a) <-> (a </> a)
                ,a </> a <-> a <-> a <-> a </> a
               ])

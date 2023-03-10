IBDEI05I ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13300,1,3,0)
 ;;=3^Postproc Cardiac Functn Disturb After Cardiac Surg
 ;;^UTILITY(U,$J,358.3,13300,1,4,0)
 ;;=4^I97.190
 ;;^UTILITY(U,$J,358.3,13300,2)
 ;;=^5008089
 ;;^UTILITY(U,$J,358.3,13301,0)
 ;;=I97.191^^53^582^178
 ;;^UTILITY(U,$J,358.3,13301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13301,1,3,0)
 ;;=3^Postproc Cardiac Functn Disturb After Oth Surg
 ;;^UTILITY(U,$J,358.3,13301,1,4,0)
 ;;=4^I97.191
 ;;^UTILITY(U,$J,358.3,13301,2)
 ;;=^5008090
 ;;^UTILITY(U,$J,358.3,13302,0)
 ;;=I97.710^^53^582^101
 ;;^UTILITY(U,$J,358.3,13302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13302,1,3,0)
 ;;=3^Intraop Cardiac Arrensst During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,13302,1,4,0)
 ;;=4^I97.710
 ;;^UTILITY(U,$J,358.3,13302,2)
 ;;=^5008103
 ;;^UTILITY(U,$J,358.3,13303,0)
 ;;=I97.711^^53^582^102
 ;;^UTILITY(U,$J,358.3,13303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13303,1,3,0)
 ;;=3^Intraop Cardiac Arrest During Oth Surgery
 ;;^UTILITY(U,$J,358.3,13303,1,4,0)
 ;;=4^I97.711
 ;;^UTILITY(U,$J,358.3,13303,2)
 ;;=^5008104
 ;;^UTILITY(U,$J,358.3,13304,0)
 ;;=I97.790^^53^582^103
 ;;^UTILITY(U,$J,358.3,13304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13304,1,3,0)
 ;;=3^Intraop Cardiac Functn Disturb During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,13304,1,4,0)
 ;;=4^I97.790
 ;;^UTILITY(U,$J,358.3,13304,2)
 ;;=^5008105
 ;;^UTILITY(U,$J,358.3,13305,0)
 ;;=I97.791^^53^582^104
 ;;^UTILITY(U,$J,358.3,13305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13305,1,3,0)
 ;;=3^Intraop Cardiac Functn Disturb During Oth Surgery
 ;;^UTILITY(U,$J,358.3,13305,1,4,0)
 ;;=4^I97.791
 ;;^UTILITY(U,$J,358.3,13305,2)
 ;;=^5008106
 ;;^UTILITY(U,$J,358.3,13306,0)
 ;;=J95.88^^53^582^107
 ;;^UTILITY(U,$J,358.3,13306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13306,1,3,0)
 ;;=3^Intraop Complications of Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,13306,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,13306,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,13307,0)
 ;;=J95.89^^53^582^181
 ;;^UTILITY(U,$J,358.3,13307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13307,1,3,0)
 ;;=3^Postproc Compl/Disorder,Resp Sys NEC
 ;;^UTILITY(U,$J,358.3,13307,1,4,0)
 ;;=4^J95.89
 ;;^UTILITY(U,$J,358.3,13307,2)
 ;;=^5008346
 ;;^UTILITY(U,$J,358.3,13308,0)
 ;;=K91.81^^53^582^105
 ;;^UTILITY(U,$J,358.3,13308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13308,1,3,0)
 ;;=3^Intraop Complications of Digestive System
 ;;^UTILITY(U,$J,358.3,13308,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,13308,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,13309,0)
 ;;=K91.82^^53^582^211
 ;;^UTILITY(U,$J,358.3,13309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13309,1,3,0)
 ;;=3^Postproc Hepatic Failure
 ;;^UTILITY(U,$J,358.3,13309,1,4,0)
 ;;=4^K91.82
 ;;^UTILITY(U,$J,358.3,13309,2)
 ;;=^5008908
 ;;^UTILITY(U,$J,358.3,13310,0)
 ;;=K91.83^^53^582^212
 ;;^UTILITY(U,$J,358.3,13310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13310,1,3,0)
 ;;=3^Postproc Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,13310,1,4,0)
 ;;=4^K91.83
 ;;^UTILITY(U,$J,358.3,13310,2)
 ;;=^5008909
 ;;^UTILITY(U,$J,358.3,13311,0)
 ;;=K91.89^^53^582^182
 ;;^UTILITY(U,$J,358.3,13311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13311,1,3,0)
 ;;=3^Postproc Compl/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,13311,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,13311,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,13312,0)
 ;;=N99.89^^53^582^183
 ;;^UTILITY(U,$J,358.3,13312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13312,1,3,0)
 ;;=3^Postproc Compl/Disorders of GU System
 ;;^UTILITY(U,$J,358.3,13312,1,4,0)
 ;;=4^N99.89
 ;;^UTILITY(U,$J,358.3,13312,2)
 ;;=^5015971
 ;;^UTILITY(U,$J,358.3,13313,0)
 ;;=N99.81^^53^582^106
 ;;^UTILITY(U,$J,358.3,13313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13313,1,3,0)
 ;;=3^Intraop Complications of GU System
 ;;^UTILITY(U,$J,358.3,13313,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,13313,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,13314,0)
 ;;=D78.01^^53^582^134
 ;;^UTILITY(U,$J,358.3,13314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13314,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Spleen Complicating Spleen Procedure
 ;;^UTILITY(U,$J,358.3,13314,1,4,0)
 ;;=4^D78.01
 ;;^UTILITY(U,$J,358.3,13314,2)
 ;;=^5002397
 ;;^UTILITY(U,$J,358.3,13315,0)
 ;;=D78.21^^53^582^209
 ;;^UTILITY(U,$J,358.3,13315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13315,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Spleen After Spleen Proc
 ;;^UTILITY(U,$J,358.3,13315,1,4,0)
 ;;=4^D78.21
 ;;^UTILITY(U,$J,358.3,13315,2)
 ;;=^5002401
 ;;^UTILITY(U,$J,358.3,13316,0)
 ;;=D78.22^^53^582^208
 ;;^UTILITY(U,$J,358.3,13316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13316,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Spleen After Oth Proc
 ;;^UTILITY(U,$J,358.3,13316,1,4,0)
 ;;=4^D78.22
 ;;^UTILITY(U,$J,358.3,13316,2)
 ;;=^5002402
 ;;^UTILITY(U,$J,358.3,13317,0)
 ;;=E36.01^^53^582^118
 ;;^UTILITY(U,$J,358.3,13317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13317,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Endo Sys Complicating Endo Sys Procedure
 ;;^UTILITY(U,$J,358.3,13317,1,4,0)
 ;;=4^E36.01
 ;;^UTILITY(U,$J,358.3,13317,2)
 ;;=^5002779
 ;;^UTILITY(U,$J,358.3,13318,0)
 ;;=E36.02^^53^582^119
 ;;^UTILITY(U,$J,358.3,13318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13318,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Endo Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13318,1,4,0)
 ;;=4^E36.02
 ;;^UTILITY(U,$J,358.3,13318,2)
 ;;=^5002780
 ;;^UTILITY(U,$J,358.3,13319,0)
 ;;=G97.31^^53^582^126
 ;;^UTILITY(U,$J,358.3,13319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13319,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Nervous Sys Complicating Nervous Sys Procedure
 ;;^UTILITY(U,$J,358.3,13319,1,4,0)
 ;;=4^G97.31
 ;;^UTILITY(U,$J,358.3,13319,2)
 ;;=^5004204
 ;;^UTILITY(U,$J,358.3,13320,0)
 ;;=G97.32^^53^582^127
 ;;^UTILITY(U,$J,358.3,13320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13320,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Nervous Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,13320,1,4,0)
 ;;=4^G97.32
 ;;^UTILITY(U,$J,358.3,13320,2)
 ;;=^5004205
 ;;^UTILITY(U,$J,358.3,13321,0)
 ;;=H59.111^^53^582^130
 ;;^UTILITY(U,$J,358.3,13321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13321,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Right Eye/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,13321,1,4,0)
 ;;=4^H59.111
 ;;^UTILITY(U,$J,358.3,13321,2)
 ;;=^5006401
 ;;^UTILITY(U,$J,358.3,13322,0)
 ;;=H59.112^^53^582^122
 ;;^UTILITY(U,$J,358.3,13322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13322,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Left Eye/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,13322,1,4,0)
 ;;=4^H59.112
 ;;^UTILITY(U,$J,358.3,13322,2)
 ;;=^5006402
 ;;^UTILITY(U,$J,358.3,13323,0)
 ;;=H59.113^^53^582^108
 ;;^UTILITY(U,$J,358.3,13323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13323,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Bilateral Eyes/Adnexa Complicating Ophth Procedure
 ;;^UTILITY(U,$J,358.3,13323,1,4,0)
 ;;=4^H59.113
 ;;^UTILITY(U,$J,358.3,13323,2)
 ;;=^5006403
 ;;^UTILITY(U,$J,358.3,13324,0)
 ;;=H59.121^^53^582^131
 ;;^UTILITY(U,$J,358.3,13324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13324,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Right Eye/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13324,1,4,0)
 ;;=4^H59.121
 ;;^UTILITY(U,$J,358.3,13324,2)
 ;;=^5006405
 ;;^UTILITY(U,$J,358.3,13325,0)
 ;;=H59.122^^53^582^123
 ;;^UTILITY(U,$J,358.3,13325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13325,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Left Eye/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13325,1,4,0)
 ;;=4^H59.122
 ;;^UTILITY(U,$J,358.3,13325,2)
 ;;=^5006406
 ;;^UTILITY(U,$J,358.3,13326,0)
 ;;=H59.123^^53^582^109
 ;;^UTILITY(U,$J,358.3,13326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13326,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Bilateral Eyes/Adnexa Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13326,1,4,0)
 ;;=4^H59.123
 ;;^UTILITY(U,$J,358.3,13326,2)
 ;;=^5006407
 ;;^UTILITY(U,$J,358.3,13327,0)
 ;;=H95.21^^53^582^116
 ;;^UTILITY(U,$J,358.3,13327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13327,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Ear/Mastoid Complicating Ear/Mastoid Procedure
 ;;^UTILITY(U,$J,358.3,13327,1,4,0)
 ;;=4^H95.21
 ;;^UTILITY(U,$J,358.3,13327,2)
 ;;=^5007026
 ;;^UTILITY(U,$J,358.3,13328,0)
 ;;=H95.22^^53^582^117
 ;;^UTILITY(U,$J,358.3,13328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13328,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Ear/Mastoid Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13328,1,4,0)
 ;;=4^H95.22
 ;;^UTILITY(U,$J,358.3,13328,2)
 ;;=^5007027
 ;;^UTILITY(U,$J,358.3,13329,0)
 ;;=I97.410^^53^582^110
 ;;^UTILITY(U,$J,358.3,13329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13329,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Circ Sys Complicating Card Catheterization
 ;;^UTILITY(U,$J,358.3,13329,1,4,0)
 ;;=4^I97.410
 ;;^UTILITY(U,$J,358.3,13329,2)
 ;;=^5008093
 ;;^UTILITY(U,$J,358.3,13330,0)
 ;;=I97.411^^53^582^111
 ;;^UTILITY(U,$J,358.3,13330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13330,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Circ Sys Complicating Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,13330,1,4,0)
 ;;=4^I97.411
 ;;^UTILITY(U,$J,358.3,13330,2)
 ;;=^5008094
 ;;^UTILITY(U,$J,358.3,13331,0)
 ;;=I97.418^^53^582^112
 ;;^UTILITY(U,$J,358.3,13331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13331,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Circ Sys Complicating Oth Circ Sys Procedure
 ;;^UTILITY(U,$J,358.3,13331,1,4,0)
 ;;=4^I97.418
 ;;^UTILITY(U,$J,358.3,13331,2)
 ;;=^5008095
 ;;^UTILITY(U,$J,358.3,13332,0)
 ;;=I97.42^^53^582^113
 ;;^UTILITY(U,$J,358.3,13332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13332,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Circ Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13332,1,4,0)
 ;;=4^I97.42
 ;;^UTILITY(U,$J,358.3,13332,2)
 ;;=^5008096
 ;;^UTILITY(U,$J,358.3,13333,0)
 ;;=J95.61^^53^582^128
 ;;^UTILITY(U,$J,358.3,13333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13333,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Resp Sys Complicating Resp Sys Procedure
 ;;^UTILITY(U,$J,358.3,13333,1,4,0)
 ;;=4^J95.61
 ;;^UTILITY(U,$J,358.3,13333,2)
 ;;=^5008332
 ;;^UTILITY(U,$J,358.3,13334,0)
 ;;=J95.62^^53^582^129
 ;;^UTILITY(U,$J,358.3,13334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13334,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Resp Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13334,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,13334,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,13335,0)
 ;;=K91.61^^53^582^114
 ;;^UTILITY(U,$J,358.3,13335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13335,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Digestive Sys Complicating Digestive Sys Procedure
 ;;^UTILITY(U,$J,358.3,13335,1,4,0)
 ;;=4^K91.61
 ;;^UTILITY(U,$J,358.3,13335,2)
 ;;=^5008903
 ;;^UTILITY(U,$J,358.3,13336,0)
 ;;=K91.62^^53^582^115
 ;;^UTILITY(U,$J,358.3,13336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13336,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Digestive Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13336,1,4,0)
 ;;=4^K91.62
 ;;^UTILITY(U,$J,358.3,13336,2)
 ;;=^5008904
 ;;^UTILITY(U,$J,358.3,13337,0)
 ;;=L76.01^^53^582^132
 ;;^UTILITY(U,$J,358.3,13337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13337,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Skin Complicating Derm Procedure
 ;;^UTILITY(U,$J,358.3,13337,1,4,0)
 ;;=4^L76.01
 ;;^UTILITY(U,$J,358.3,13337,2)
 ;;=^5009302
 ;;^UTILITY(U,$J,358.3,13338,0)
 ;;=L76.02^^53^582^133
 ;;^UTILITY(U,$J,358.3,13338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13338,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of Skin Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,13338,1,4,0)
 ;;=4^L76.02
 ;;^UTILITY(U,$J,358.3,13338,2)
 ;;=^5009303
 ;;^UTILITY(U,$J,358.3,13339,0)
 ;;=M96.810^^53^582^124
 ;;^UTILITY(U,$J,358.3,13339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13339,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of MS Structure Complication MS Sys Procedure
 ;;^UTILITY(U,$J,358.3,13339,1,4,0)
 ;;=4^M96.810
 ;;^UTILITY(U,$J,358.3,13339,2)
 ;;=^5015393
 ;;^UTILITY(U,$J,358.3,13340,0)
 ;;=M96.811^^53^582^125
 ;;^UTILITY(U,$J,358.3,13340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13340,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of MS Structure Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,13340,1,4,0)
 ;;=4^M96.811
 ;;^UTILITY(U,$J,358.3,13340,2)
 ;;=^5015394
 ;;^UTILITY(U,$J,358.3,13341,0)
 ;;=N99.61^^53^582^120
 ;;^UTILITY(U,$J,358.3,13341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13341,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of GU Sys Complicating a GU Sys Procedure
 ;;^UTILITY(U,$J,358.3,13341,1,4,0)
 ;;=4^N99.61
 ;;^UTILITY(U,$J,358.3,13341,2)
 ;;=^5015963
 ;;^UTILITY(U,$J,358.3,13342,0)
 ;;=N99.62^^53^582^121
 ;;^UTILITY(U,$J,358.3,13342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13342,1,3,0)
 ;;=3^Intraop Hemor/Hemtom of GU Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,13342,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,13342,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,13343,0)
 ;;=G97.51^^53^582^200
 ;;^UTILITY(U,$J,358.3,13343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13343,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Nerv Sys After Nerv Sys Proc
 ;;^UTILITY(U,$J,358.3,13343,1,4,0)
 ;;=4^G97.51
 ;;^UTILITY(U,$J,358.3,13343,2)
 ;;=^5004209
 ;;^UTILITY(U,$J,358.3,13344,0)
 ;;=G97.52^^53^582^201
 ;;^UTILITY(U,$J,358.3,13344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13344,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Nerv Sys After Oth Proc
 ;;^UTILITY(U,$J,358.3,13344,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,13344,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,13345,0)
 ;;=H59.311^^53^582^204
 ;;^UTILITY(U,$J,358.3,13345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13345,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Rt Eye/Adnexa After Ophth Proc
 ;;^UTILITY(U,$J,358.3,13345,1,4,0)
 ;;=4^H59.311
 ;;^UTILITY(U,$J,358.3,13345,2)
 ;;=^5006417
 ;;^UTILITY(U,$J,358.3,13346,0)
 ;;=H59.312^^53^582^196
 ;;^UTILITY(U,$J,358.3,13346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13346,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Lt Eye/Adnexa After Ophth Proc
 ;;^UTILITY(U,$J,358.3,13346,1,4,0)
 ;;=4^H59.312
 ;;^UTILITY(U,$J,358.3,13346,2)
 ;;=^5006418
 ;;^UTILITY(U,$J,358.3,13347,0)
 ;;=H59.313^^53^582^186
 ;;^UTILITY(U,$J,358.3,13347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13347,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Bil Eyes/Adnexa After Ophth Proc
 ;;^UTILITY(U,$J,358.3,13347,1,4,0)
 ;;=4^H59.313
 ;;^UTILITY(U,$J,358.3,13347,2)
 ;;=^5006419
 ;;^UTILITY(U,$J,358.3,13348,0)
 ;;=H59.321^^53^582^205
 ;;^UTILITY(U,$J,358.3,13348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13348,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Rt Eye/Adnexa After Oth Proc
 ;;^UTILITY(U,$J,358.3,13348,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,13348,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,13349,0)
 ;;=H59.322^^53^582^197
 ;;^UTILITY(U,$J,358.3,13349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13349,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Lt Eye/Adnexa After Oth Proc
 ;;^UTILITY(U,$J,358.3,13349,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,13349,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,13350,0)
 ;;=H95.41^^53^582^192
 ;;^UTILITY(U,$J,358.3,13350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13350,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Ear/Mastoid After Ear/Mastoid Proc
 ;;^UTILITY(U,$J,358.3,13350,1,4,0)
 ;;=4^H95.41
 ;;^UTILITY(U,$J,358.3,13350,2)
 ;;=^5007030
 ;;^UTILITY(U,$J,358.3,13351,0)
 ;;=H95.42^^53^582^193
 ;;^UTILITY(U,$J,358.3,13351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13351,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Ear/Mastoid After Oth Proc
 ;;^UTILITY(U,$J,358.3,13351,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,13351,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,13352,0)
 ;;=I97.610^^53^582^187
 ;;^UTILITY(U,$J,358.3,13352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13352,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Circ Sys After Cardiac Cath
 ;;^UTILITY(U,$J,358.3,13352,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,13352,2)
 ;;=^5008099
 ;;^UTILITY(U,$J,358.3,13353,0)
 ;;=I97.611^^53^582^188
 ;;^UTILITY(U,$J,358.3,13353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13353,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Circ Sys After Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,13353,1,4,0)
 ;;=4^I97.611
 ;;^UTILITY(U,$J,358.3,13353,2)
 ;;=^5008100
 ;;^UTILITY(U,$J,358.3,13354,0)
 ;;=I97.618^^53^582^189
 ;;^UTILITY(U,$J,358.3,13354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13354,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Circ Sys After Oth Circ Sys Proc
 ;;^UTILITY(U,$J,358.3,13354,1,4,0)
 ;;=4^I97.618
 ;;^UTILITY(U,$J,358.3,13354,2)
 ;;=^5008101
 ;;^UTILITY(U,$J,358.3,13355,0)
 ;;=J95.830^^53^582^203
 ;;^UTILITY(U,$J,358.3,13355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13355,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Resp Sys After Resp Sys Proc
 ;;^UTILITY(U,$J,358.3,13355,1,4,0)
 ;;=4^J95.830
 ;;^UTILITY(U,$J,358.3,13355,2)
 ;;=^5008340
 ;;^UTILITY(U,$J,358.3,13356,0)
 ;;=J95.831^^53^582^202
 ;;^UTILITY(U,$J,358.3,13356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13356,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Resp Sys After Oth Proc
 ;;^UTILITY(U,$J,358.3,13356,1,4,0)
 ;;=4^J95.831
 ;;^UTILITY(U,$J,358.3,13356,2)
 ;;=^5008341
 ;;^UTILITY(U,$J,358.3,13357,0)
 ;;=K91.840^^53^582^190
 ;;^UTILITY(U,$J,358.3,13357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13357,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Dig Sys After Dig Sys Proc
 ;;^UTILITY(U,$J,358.3,13357,1,4,0)
 ;;=4^K91.840
 ;;^UTILITY(U,$J,358.3,13357,2)
 ;;=^5008910
 ;;^UTILITY(U,$J,358.3,13358,0)
 ;;=K91.841^^53^582^191
 ;;^UTILITY(U,$J,358.3,13358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13358,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Dig Sys After Oth Proc
 ;;^UTILITY(U,$J,358.3,13358,1,4,0)
 ;;=4^K91.841
 ;;^UTILITY(U,$J,358.3,13358,2)
 ;;=^5008911
 ;;^UTILITY(U,$J,358.3,13359,0)
 ;;=L76.21^^53^582^206
 ;;^UTILITY(U,$J,358.3,13359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13359,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Skin After Derm Proc
 ;;^UTILITY(U,$J,358.3,13359,1,4,0)
 ;;=4^L76.21
 ;;^UTILITY(U,$J,358.3,13359,2)
 ;;=^5009306
 ;;^UTILITY(U,$J,358.3,13360,0)
 ;;=L76.22^^53^582^207
 ;;^UTILITY(U,$J,358.3,13360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13360,1,3,0)
 ;;=3^Postproc Hemor/Hematom,Skin After Oth Proc
 ;;^UTILITY(U,$J,358.3,13360,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,13360,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,13361,0)
 ;;=M96.830^^53^582^198
 ;;^UTILITY(U,$J,358.3,13361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13361,1,3,0)
 ;;=3^Postproc Hemor/Hematom,MS Struct After MS Sys Proc
 ;;^UTILITY(U,$J,358.3,13361,1,4,0)
 ;;=4^M96.830
 ;;^UTILITY(U,$J,358.3,13361,2)
 ;;=^5015397
 ;;^UTILITY(U,$J,358.3,13362,0)
 ;;=M96.831^^53^582^199
 ;;^UTILITY(U,$J,358.3,13362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13362,1,3,0)
 ;;=3^Postproc Hemor/Hematom,MS Struct After Oth Proc
 ;;^UTILITY(U,$J,358.3,13362,1,4,0)
 ;;=4^M96.831
 ;;^UTILITY(U,$J,358.3,13362,2)
 ;;=^5015398
 ;;^UTILITY(U,$J,358.3,13363,0)
 ;;=N99.820^^53^582^194
 ;;^UTILITY(U,$J,358.3,13363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13363,1,3,0)
 ;;=3^Postproc Hemor/Hematom,GU Sys After GU Sys Proc

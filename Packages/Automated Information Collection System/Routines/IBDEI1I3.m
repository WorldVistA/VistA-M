IBDEI1I3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25081,2)
 ;;=^5008096
 ;;^UTILITY(U,$J,358.3,25082,0)
 ;;=J95.61^^124^1239^119
 ;;^UTILITY(U,$J,358.3,25082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25082,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Resp Sys Complicating Resp Sys Procedure
 ;;^UTILITY(U,$J,358.3,25082,1,4,0)
 ;;=4^J95.61
 ;;^UTILITY(U,$J,358.3,25082,2)
 ;;=^5008332
 ;;^UTILITY(U,$J,358.3,25083,0)
 ;;=J95.62^^124^1239^120
 ;;^UTILITY(U,$J,358.3,25083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25083,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Resp Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,25083,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,25083,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,25084,0)
 ;;=K91.61^^124^1239^105
 ;;^UTILITY(U,$J,358.3,25084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25084,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Digestive Sys Complicating Digestive Sys Procedure
 ;;^UTILITY(U,$J,358.3,25084,1,4,0)
 ;;=4^K91.61
 ;;^UTILITY(U,$J,358.3,25084,2)
 ;;=^5008903
 ;;^UTILITY(U,$J,358.3,25085,0)
 ;;=K91.62^^124^1239^106
 ;;^UTILITY(U,$J,358.3,25085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25085,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Digestive Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,25085,1,4,0)
 ;;=4^K91.62
 ;;^UTILITY(U,$J,358.3,25085,2)
 ;;=^5008904
 ;;^UTILITY(U,$J,358.3,25086,0)
 ;;=L76.01^^124^1239^123
 ;;^UTILITY(U,$J,358.3,25086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25086,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Skin Complicating Derm Procedure
 ;;^UTILITY(U,$J,358.3,25086,1,4,0)
 ;;=4^L76.01
 ;;^UTILITY(U,$J,358.3,25086,2)
 ;;=^5009302
 ;;^UTILITY(U,$J,358.3,25087,0)
 ;;=L76.02^^124^1239^124
 ;;^UTILITY(U,$J,358.3,25087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25087,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Skin Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,25087,1,4,0)
 ;;=4^L76.02
 ;;^UTILITY(U,$J,358.3,25087,2)
 ;;=^5009303
 ;;^UTILITY(U,$J,358.3,25088,0)
 ;;=M96.810^^124^1239^115
 ;;^UTILITY(U,$J,358.3,25088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25088,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of MS Structure Complication MS Sys Procedure
 ;;^UTILITY(U,$J,358.3,25088,1,4,0)
 ;;=4^M96.810
 ;;^UTILITY(U,$J,358.3,25088,2)
 ;;=^5015393
 ;;^UTILITY(U,$J,358.3,25089,0)
 ;;=M96.811^^124^1239^116
 ;;^UTILITY(U,$J,358.3,25089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25089,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of MS Structure Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,25089,1,4,0)
 ;;=4^M96.811
 ;;^UTILITY(U,$J,358.3,25089,2)
 ;;=^5015394
 ;;^UTILITY(U,$J,358.3,25090,0)
 ;;=N99.61^^124^1239^111
 ;;^UTILITY(U,$J,358.3,25090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25090,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of GU Sys Complicating a GU Sys Procedure
 ;;^UTILITY(U,$J,358.3,25090,1,4,0)
 ;;=4^N99.61
 ;;^UTILITY(U,$J,358.3,25090,2)
 ;;=^5015963
 ;;^UTILITY(U,$J,358.3,25091,0)
 ;;=N99.62^^124^1239^112
 ;;^UTILITY(U,$J,358.3,25091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25091,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of GU Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,25091,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,25091,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,25092,0)
 ;;=G97.51^^124^1239^182
 ;;^UTILITY(U,$J,358.3,25092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25092,1,3,0)
 ;;=3^Postprocedural Hemor/Hemtom of Nervous Sys Following a Nervous Sys Procedure
 ;;^UTILITY(U,$J,358.3,25092,1,4,0)
 ;;=4^G97.51
 ;;^UTILITY(U,$J,358.3,25092,2)
 ;;=^5004209
 ;;^UTILITY(U,$J,358.3,25093,0)
 ;;=G97.52^^124^1239^183

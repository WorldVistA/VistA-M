IBDEI1I1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25059,1,3,0)
 ;;=3^Postprocedural Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,25059,1,4,0)
 ;;=4^K91.83
 ;;^UTILITY(U,$J,358.3,25059,2)
 ;;=^5008909
 ;;^UTILITY(U,$J,358.3,25060,0)
 ;;=K91.89^^124^1239^164
 ;;^UTILITY(U,$J,358.3,25060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25060,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,25060,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,25060,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,25061,0)
 ;;=N99.89^^124^1239^165
 ;;^UTILITY(U,$J,358.3,25061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25061,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of GU System
 ;;^UTILITY(U,$J,358.3,25061,1,4,0)
 ;;=4^N99.89
 ;;^UTILITY(U,$J,358.3,25061,2)
 ;;=^5015971
 ;;^UTILITY(U,$J,358.3,25062,0)
 ;;=N99.81^^124^1239^97
 ;;^UTILITY(U,$J,358.3,25062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25062,1,3,0)
 ;;=3^Intraoperative Complications of GU System
 ;;^UTILITY(U,$J,358.3,25062,1,4,0)
 ;;=4^N99.81
 ;;^UTILITY(U,$J,358.3,25062,2)
 ;;=^5015967
 ;;^UTILITY(U,$J,358.3,25063,0)
 ;;=D78.01^^124^1239^125
 ;;^UTILITY(U,$J,358.3,25063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25063,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Spleen Complicating Spleen Procedure
 ;;^UTILITY(U,$J,358.3,25063,1,4,0)
 ;;=4^D78.01
 ;;^UTILITY(U,$J,358.3,25063,2)
 ;;=^5002397
 ;;^UTILITY(U,$J,358.3,25064,0)
 ;;=D78.21^^124^1239^190
 ;;^UTILITY(U,$J,358.3,25064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25064,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen Following Spleen Procedure
 ;;^UTILITY(U,$J,358.3,25064,1,4,0)
 ;;=4^D78.21
 ;;^UTILITY(U,$J,358.3,25064,2)
 ;;=^5002401
 ;;^UTILITY(U,$J,358.3,25065,0)
 ;;=D78.22^^124^1239^191
 ;;^UTILITY(U,$J,358.3,25065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25065,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,25065,1,4,0)
 ;;=4^D78.22
 ;;^UTILITY(U,$J,358.3,25065,2)
 ;;=^5002402
 ;;^UTILITY(U,$J,358.3,25066,0)
 ;;=E36.01^^124^1239^109
 ;;^UTILITY(U,$J,358.3,25066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25066,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Endo Sys Complicating Endo Sys Procedure
 ;;^UTILITY(U,$J,358.3,25066,1,4,0)
 ;;=4^E36.01
 ;;^UTILITY(U,$J,358.3,25066,2)
 ;;=^5002779
 ;;^UTILITY(U,$J,358.3,25067,0)
 ;;=E36.02^^124^1239^110
 ;;^UTILITY(U,$J,358.3,25067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25067,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Endo Sys Complicating Oth Procedure
 ;;^UTILITY(U,$J,358.3,25067,1,4,0)
 ;;=4^E36.02
 ;;^UTILITY(U,$J,358.3,25067,2)
 ;;=^5002780
 ;;^UTILITY(U,$J,358.3,25068,0)
 ;;=G97.31^^124^1239^117
 ;;^UTILITY(U,$J,358.3,25068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25068,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Nervous Sys Complicating Nervous Sys Procedure
 ;;^UTILITY(U,$J,358.3,25068,1,4,0)
 ;;=4^G97.31
 ;;^UTILITY(U,$J,358.3,25068,2)
 ;;=^5004204
 ;;^UTILITY(U,$J,358.3,25069,0)
 ;;=G97.32^^124^1239^118
 ;;^UTILITY(U,$J,358.3,25069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25069,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Nervous Sys Complication Oth Procedure
 ;;^UTILITY(U,$J,358.3,25069,1,4,0)
 ;;=4^G97.32
 ;;^UTILITY(U,$J,358.3,25069,2)
 ;;=^5004205
 ;;^UTILITY(U,$J,358.3,25070,0)
 ;;=H59.111^^124^1239^121
 ;;^UTILITY(U,$J,358.3,25070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25070,1,3,0)
 ;;=3^Intraoperative Hemor/Hemtom of Right Eye/Adnexa Complicating Ophth Procedure

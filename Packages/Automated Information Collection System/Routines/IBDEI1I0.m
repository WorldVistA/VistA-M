IBDEI1I0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25047,1,3,0)
 ;;=3^Postprocedure Cardiac Functn Disturb Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,25047,1,4,0)
 ;;=4^I97.190
 ;;^UTILITY(U,$J,358.3,25047,2)
 ;;=^5008089
 ;;^UTILITY(U,$J,358.3,25048,0)
 ;;=I97.191^^124^1239^199
 ;;^UTILITY(U,$J,358.3,25048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25048,1,3,0)
 ;;=3^Postprocedure Cardiac Functn Disturb Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,25048,1,4,0)
 ;;=4^I97.191
 ;;^UTILITY(U,$J,358.3,25048,2)
 ;;=^5008090
 ;;^UTILITY(U,$J,358.3,25049,0)
 ;;=I97.710^^124^1239^92
 ;;^UTILITY(U,$J,358.3,25049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25049,1,3,0)
 ;;=3^Intraoperative Cardiac Arrensst During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,25049,1,4,0)
 ;;=4^I97.710
 ;;^UTILITY(U,$J,358.3,25049,2)
 ;;=^5008103
 ;;^UTILITY(U,$J,358.3,25050,0)
 ;;=I97.711^^124^1239^93
 ;;^UTILITY(U,$J,358.3,25050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25050,1,3,0)
 ;;=3^Intraoperative Cardiac Arrest During Oth Surgery
 ;;^UTILITY(U,$J,358.3,25050,1,4,0)
 ;;=4^I97.711
 ;;^UTILITY(U,$J,358.3,25050,2)
 ;;=^5008104
 ;;^UTILITY(U,$J,358.3,25051,0)
 ;;=I97.790^^124^1239^94
 ;;^UTILITY(U,$J,358.3,25051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25051,1,3,0)
 ;;=3^Intraoperative Cardiac Functn Disturb During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,25051,1,4,0)
 ;;=4^I97.790
 ;;^UTILITY(U,$J,358.3,25051,2)
 ;;=^5008105
 ;;^UTILITY(U,$J,358.3,25052,0)
 ;;=I97.791^^124^1239^95
 ;;^UTILITY(U,$J,358.3,25052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25052,1,3,0)
 ;;=3^Intraoperative Cardiac Functn Disturb During Oth Surgery
 ;;^UTILITY(U,$J,358.3,25052,1,4,0)
 ;;=4^I97.791
 ;;^UTILITY(U,$J,358.3,25052,2)
 ;;=^5008106
 ;;^UTILITY(U,$J,358.3,25053,0)
 ;;=T81.72XA^^124^1239^25
 ;;^UTILITY(U,$J,358.3,25053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25053,1,3,0)
 ;;=3^Complication of Vein Following Procedure NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,25053,1,4,0)
 ;;=4^T81.72XA
 ;;^UTILITY(U,$J,358.3,25053,2)
 ;;=^5054650
 ;;^UTILITY(U,$J,358.3,25054,0)
 ;;=J95.88^^124^1239^98
 ;;^UTILITY(U,$J,358.3,25054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25054,1,3,0)
 ;;=3^Intraoperative Complications of Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,25054,1,4,0)
 ;;=4^J95.88
 ;;^UTILITY(U,$J,358.3,25054,2)
 ;;=^5008345
 ;;^UTILITY(U,$J,358.3,25055,0)
 ;;=J95.89^^124^1239^202
 ;;^UTILITY(U,$J,358.3,25055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25055,1,3,0)
 ;;=3^Postprocedure Complications/Disorders of Respiratory System NEC
 ;;^UTILITY(U,$J,358.3,25055,1,4,0)
 ;;=4^J95.89
 ;;^UTILITY(U,$J,358.3,25055,2)
 ;;=^5008346
 ;;^UTILITY(U,$J,358.3,25056,0)
 ;;=K91.3^^124^1239^194
 ;;^UTILITY(U,$J,358.3,25056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25056,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,25056,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,25056,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,25057,0)
 ;;=K91.81^^124^1239^96
 ;;^UTILITY(U,$J,358.3,25057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25057,1,3,0)
 ;;=3^Intraoperative Complications of Digestive System
 ;;^UTILITY(U,$J,358.3,25057,1,4,0)
 ;;=4^K91.81
 ;;^UTILITY(U,$J,358.3,25057,2)
 ;;=^5008907
 ;;^UTILITY(U,$J,358.3,25058,0)
 ;;=K91.82^^124^1239^192
 ;;^UTILITY(U,$J,358.3,25058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25058,1,3,0)
 ;;=3^Postprocedural Hepatic Failure
 ;;^UTILITY(U,$J,358.3,25058,1,4,0)
 ;;=4^K91.82
 ;;^UTILITY(U,$J,358.3,25058,2)
 ;;=^5008908
 ;;^UTILITY(U,$J,358.3,25059,0)
 ;;=K91.83^^124^1239^193

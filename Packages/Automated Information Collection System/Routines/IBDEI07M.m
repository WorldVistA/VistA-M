IBDEI07M ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2992,2)
 ;;=^5008605
 ;;^UTILITY(U,$J,358.3,2993,0)
 ;;=K42.9^^28^245^56
 ;;^UTILITY(U,$J,358.3,2993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2993,1,3,0)
 ;;=3^Hernia,Umbilical w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,2993,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,2993,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,2994,0)
 ;;=K41.30^^28^245^57
 ;;^UTILITY(U,$J,358.3,2994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2994,1,3,0)
 ;;=3^Hernia,Unil Femoral w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2994,1,4,0)
 ;;=4^K41.30
 ;;^UTILITY(U,$J,358.3,2994,2)
 ;;=^5008599
 ;;^UTILITY(U,$J,358.3,2995,0)
 ;;=K41.90^^28^245^58
 ;;^UTILITY(U,$J,358.3,2995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2995,1,3,0)
 ;;=3^Hernia,Unil Femoral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,2995,1,4,0)
 ;;=4^K41.90
 ;;^UTILITY(U,$J,358.3,2995,2)
 ;;=^5008603
 ;;^UTILITY(U,$J,358.3,2996,0)
 ;;=K40.30^^28^245^59
 ;;^UTILITY(U,$J,358.3,2996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2996,1,3,0)
 ;;=3^Hernia,Unil Inguinal w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2996,1,4,0)
 ;;=4^K40.30
 ;;^UTILITY(U,$J,358.3,2996,2)
 ;;=^5008587
 ;;^UTILITY(U,$J,358.3,2997,0)
 ;;=K40.90^^28^245^60
 ;;^UTILITY(U,$J,358.3,2997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2997,1,3,0)
 ;;=3^Hernia,Unil Inguinal w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,2997,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,2997,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,2998,0)
 ;;=K43.9^^28^245^61
 ;;^UTILITY(U,$J,358.3,2998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2998,1,3,0)
 ;;=3^Hernia,Ventral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,2998,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,2998,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,2999,0)
 ;;=K59.9^^28^245^65
 ;;^UTILITY(U,$J,358.3,2999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2999,1,3,0)
 ;;=3^Intestinal Disorder,Functional,Unspec
 ;;^UTILITY(U,$J,358.3,2999,1,4,0)
 ;;=4^K59.9
 ;;^UTILITY(U,$J,358.3,2999,2)
 ;;=^5008744
 ;;^UTILITY(U,$J,358.3,3000,0)
 ;;=K63.9^^28^245^64
 ;;^UTILITY(U,$J,358.3,3000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3000,1,3,0)
 ;;=3^Intestinal Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3000,1,4,0)
 ;;=4^K63.9
 ;;^UTILITY(U,$J,358.3,3000,2)
 ;;=^5008768
 ;;^UTILITY(U,$J,358.3,3001,0)
 ;;=K58.0^^28^245^62
 ;;^UTILITY(U,$J,358.3,3001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3001,1,3,0)
 ;;=3^IBS w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,3001,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,3001,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,3002,0)
 ;;=K58.9^^28^245^63
 ;;^UTILITY(U,$J,358.3,3002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3002,1,3,0)
 ;;=3^IBS w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,3002,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,3002,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,3003,0)
 ;;=K90.9^^28^245^66
 ;;^UTILITY(U,$J,358.3,3003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3003,1,3,0)
 ;;=3^Malabsorption,Intestinal,Unspec
 ;;^UTILITY(U,$J,358.3,3003,1,4,0)
 ;;=4^K90.9
 ;;^UTILITY(U,$J,358.3,3003,2)
 ;;=^5008899
 ;;^UTILITY(U,$J,358.3,3004,0)
 ;;=K86.9^^28^245^67
 ;;^UTILITY(U,$J,358.3,3004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3004,1,3,0)
 ;;=3^Pancreas Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3004,1,4,0)
 ;;=4^K86.9
 ;;^UTILITY(U,$J,358.3,3004,2)
 ;;=^5008892
 ;;^UTILITY(U,$J,358.3,3005,0)
 ;;=K85.9^^28^245^68
 ;;^UTILITY(U,$J,358.3,3005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3005,1,3,0)
 ;;=3^Pancreatitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,3005,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,3005,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,3006,0)
 ;;=Z87.11^^28^245^69

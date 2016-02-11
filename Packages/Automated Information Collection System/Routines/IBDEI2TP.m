IBDEI2TP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47390,1,3,0)
 ;;=3^Follicular Lymphoma NEC,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,47390,1,4,0)
 ;;=4^C82.86
 ;;^UTILITY(U,$J,358.3,47390,2)
 ;;=^5001537
 ;;^UTILITY(U,$J,358.3,47391,0)
 ;;=C82.87^^209^2346^198
 ;;^UTILITY(U,$J,358.3,47391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47391,1,3,0)
 ;;=3^Follicular Lymphoma NEC,Spleen
 ;;^UTILITY(U,$J,358.3,47391,1,4,0)
 ;;=4^C82.87
 ;;^UTILITY(U,$J,358.3,47391,2)
 ;;=^5001538
 ;;^UTILITY(U,$J,358.3,47392,0)
 ;;=C82.88^^209^2346^197
 ;;^UTILITY(U,$J,358.3,47392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47392,1,3,0)
 ;;=3^Follicular Lymphoma NEC,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,47392,1,4,0)
 ;;=4^C82.88
 ;;^UTILITY(U,$J,358.3,47392,2)
 ;;=^5001539
 ;;^UTILITY(U,$J,358.3,47393,0)
 ;;=C82.89^^209^2346^191
 ;;^UTILITY(U,$J,358.3,47393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47393,1,3,0)
 ;;=3^Follicular Lymphoma NEC,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,47393,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,47393,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,47394,0)
 ;;=C82.90^^209^2346^209
 ;;^UTILITY(U,$J,358.3,47394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47394,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,47394,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,47394,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,47395,0)
 ;;=C82.91^^209^2346^202
 ;;^UTILITY(U,$J,358.3,47395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47395,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,47395,1,4,0)
 ;;=4^C82.91
 ;;^UTILITY(U,$J,358.3,47395,2)
 ;;=^5001542
 ;;^UTILITY(U,$J,358.3,47396,0)
 ;;=C82.92^^209^2346^206
 ;;^UTILITY(U,$J,358.3,47396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47396,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,47396,1,4,0)
 ;;=4^C82.92
 ;;^UTILITY(U,$J,358.3,47396,2)
 ;;=^5001543
 ;;^UTILITY(U,$J,358.3,47397,0)
 ;;=C82.93^^209^2346^204
 ;;^UTILITY(U,$J,358.3,47397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47397,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,47397,1,4,0)
 ;;=4^C82.93
 ;;^UTILITY(U,$J,358.3,47397,2)
 ;;=^5001544
 ;;^UTILITY(U,$J,358.3,47398,0)
 ;;=C82.94^^209^2346^200
 ;;^UTILITY(U,$J,358.3,47398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47398,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,47398,1,4,0)
 ;;=4^C82.94
 ;;^UTILITY(U,$J,358.3,47398,2)
 ;;=^5001545
 ;;^UTILITY(U,$J,358.3,47399,0)
 ;;=C82.95^^209^2346^203
 ;;^UTILITY(U,$J,358.3,47399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47399,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Ing Region/Lower Limb Nodes
 ;;^UTILITY(U,$J,358.3,47399,1,4,0)
 ;;=4^C82.95
 ;;^UTILITY(U,$J,358.3,47399,2)
 ;;=^5001546
 ;;^UTILITY(U,$J,358.3,47400,0)
 ;;=C82.96^^209^2346^205
 ;;^UTILITY(U,$J,358.3,47400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47400,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,47400,1,4,0)
 ;;=4^C82.96
 ;;^UTILITY(U,$J,358.3,47400,2)
 ;;=^5001547
 ;;^UTILITY(U,$J,358.3,47401,0)
 ;;=C82.97^^209^2346^208
 ;;^UTILITY(U,$J,358.3,47401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47401,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Spleen
 ;;^UTILITY(U,$J,358.3,47401,1,4,0)
 ;;=4^C82.97
 ;;^UTILITY(U,$J,358.3,47401,2)
 ;;=^5001548
 ;;^UTILITY(U,$J,358.3,47402,0)
 ;;=C82.98^^209^2346^207
 ;;^UTILITY(U,$J,358.3,47402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47402,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Mult Site Nodes

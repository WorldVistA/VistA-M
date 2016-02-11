IBDEI2TS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47427,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,47427,1,4,0)
 ;;=4^C83.33
 ;;^UTILITY(U,$J,358.3,47427,2)
 ;;=^5001574
 ;;^UTILITY(U,$J,358.3,47428,0)
 ;;=C83.34^^209^2346^124
 ;;^UTILITY(U,$J,358.3,47428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47428,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,47428,1,4,0)
 ;;=4^C83.34
 ;;^UTILITY(U,$J,358.3,47428,2)
 ;;=^5001575
 ;;^UTILITY(U,$J,358.3,47429,0)
 ;;=C83.35^^209^2346^127
 ;;^UTILITY(U,$J,358.3,47429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47429,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Ing Region/Lower Limb
 ;;^UTILITY(U,$J,358.3,47429,1,4,0)
 ;;=4^C83.35
 ;;^UTILITY(U,$J,358.3,47429,2)
 ;;=^5001576
 ;;^UTILITY(U,$J,358.3,47430,0)
 ;;=C83.36^^209^2346^129
 ;;^UTILITY(U,$J,358.3,47430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47430,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Intrapelvic Nodes
 ;;^UTILITY(U,$J,358.3,47430,1,4,0)
 ;;=4^C83.36
 ;;^UTILITY(U,$J,358.3,47430,2)
 ;;=^5001577
 ;;^UTILITY(U,$J,358.3,47431,0)
 ;;=C83.37^^209^2346^132
 ;;^UTILITY(U,$J,358.3,47431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47431,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Spleen
 ;;^UTILITY(U,$J,358.3,47431,1,4,0)
 ;;=4^C83.37
 ;;^UTILITY(U,$J,358.3,47431,2)
 ;;=^5001578
 ;;^UTILITY(U,$J,358.3,47432,0)
 ;;=C83.38^^209^2346^131
 ;;^UTILITY(U,$J,358.3,47432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47432,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Mult Site Nodes
 ;;^UTILITY(U,$J,358.3,47432,1,4,0)
 ;;=4^C83.38
 ;;^UTILITY(U,$J,358.3,47432,2)
 ;;=^5001579
 ;;^UTILITY(U,$J,358.3,47433,0)
 ;;=C83.39^^209^2346^125
 ;;^UTILITY(U,$J,358.3,47433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47433,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,47433,1,4,0)
 ;;=4^C83.39
 ;;^UTILITY(U,$J,358.3,47433,2)
 ;;=^5001580
 ;;^UTILITY(U,$J,358.3,47434,0)
 ;;=C83.50^^209^2346^254
 ;;^UTILITY(U,$J,358.3,47434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47434,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,47434,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,47434,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,47435,0)
 ;;=C83.51^^209^2346^247
 ;;^UTILITY(U,$J,358.3,47435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47435,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Head/Face/Neck Nodes
 ;;^UTILITY(U,$J,358.3,47435,1,4,0)
 ;;=4^C83.51
 ;;^UTILITY(U,$J,358.3,47435,2)
 ;;=^5001582
 ;;^UTILITY(U,$J,358.3,47436,0)
 ;;=C83.52^^209^2346^251
 ;;^UTILITY(U,$J,358.3,47436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47436,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Intrathoracic Nodes
 ;;^UTILITY(U,$J,358.3,47436,1,4,0)
 ;;=4^C83.52
 ;;^UTILITY(U,$J,358.3,47436,2)
 ;;=^5001583
 ;;^UTILITY(U,$J,358.3,47437,0)
 ;;=C83.53^^209^2346^249
 ;;^UTILITY(U,$J,358.3,47437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47437,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Intra-Abdominal Nodes
 ;;^UTILITY(U,$J,358.3,47437,1,4,0)
 ;;=4^C83.53
 ;;^UTILITY(U,$J,358.3,47437,2)
 ;;=^5001584
 ;;^UTILITY(U,$J,358.3,47438,0)
 ;;=C83.54^^209^2346^245
 ;;^UTILITY(U,$J,358.3,47438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47438,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Axilla/Upper Limb Nodes
 ;;^UTILITY(U,$J,358.3,47438,1,4,0)
 ;;=4^C83.54
 ;;^UTILITY(U,$J,358.3,47438,2)
 ;;=^5001585
 ;;^UTILITY(U,$J,358.3,47439,0)
 ;;=C83.55^^209^2346^248
 ;;^UTILITY(U,$J,358.3,47439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47439,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Ing Region/Lower Limb Nodes

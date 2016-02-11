IBDEI0EY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6551,1,3,0)
 ;;=3^Shaving Epidermm Arm/Leg: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,6552,0)
 ;;=11303^^45^414^4^^^^1
 ;;^UTILITY(U,$J,358.3,6552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6552,1,2,0)
 ;;=2^11303
 ;;^UTILITY(U,$J,358.3,6552,1,3,0)
 ;;=3^Shaving Epidermm Arm/Leg > 2.0cm
 ;;^UTILITY(U,$J,358.3,6553,0)
 ;;=12001^^45^415^1^^^^1
 ;;^UTILITY(U,$J,358.3,6553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6553,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,6553,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,6554,0)
 ;;=12002^^45^415^2^^^^1
 ;;^UTILITY(U,$J,358.3,6554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6554,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,6554,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,6555,0)
 ;;=12004^^45^415^3^^^^1
 ;;^UTILITY(U,$J,358.3,6555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6555,1,2,0)
 ;;=2^12004
 ;;^UTILITY(U,$J,358.3,6555,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,6556,0)
 ;;=12005^^45^415^4^^^^1
 ;;^UTILITY(U,$J,358.3,6556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6556,1,2,0)
 ;;=2^12005
 ;;^UTILITY(U,$J,358.3,6556,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,6557,0)
 ;;=12006^^45^415^5^^^^1
 ;;^UTILITY(U,$J,358.3,6557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6557,1,2,0)
 ;;=2^12006
 ;;^UTILITY(U,$J,358.3,6557,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,6558,0)
 ;;=12007^^45^415^6^^^^1
 ;;^UTILITY(U,$J,358.3,6558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6558,1,2,0)
 ;;=2^12007
 ;;^UTILITY(U,$J,358.3,6558,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,6559,0)
 ;;=12031^^45^416^1^^^^1
 ;;^UTILITY(U,$J,358.3,6559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6559,1,2,0)
 ;;=2^12031
 ;;^UTILITY(U,$J,358.3,6559,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,6560,0)
 ;;=12032^^45^416^2^^^^1
 ;;^UTILITY(U,$J,358.3,6560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6560,1,2,0)
 ;;=2^12032
 ;;^UTILITY(U,$J,358.3,6560,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,6561,0)
 ;;=12034^^45^416^3^^^^1
 ;;^UTILITY(U,$J,358.3,6561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6561,1,2,0)
 ;;=2^12034
 ;;^UTILITY(U,$J,358.3,6561,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,6562,0)
 ;;=12035^^45^416^4^^^^1
 ;;^UTILITY(U,$J,358.3,6562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6562,1,2,0)
 ;;=2^12035
 ;;^UTILITY(U,$J,358.3,6562,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,6563,0)
 ;;=12036^^45^416^5^^^^1
 ;;^UTILITY(U,$J,358.3,6563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6563,1,2,0)
 ;;=2^12036
 ;;^UTILITY(U,$J,358.3,6563,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,6564,0)
 ;;=12037^^45^416^6^^^^1
 ;;^UTILITY(U,$J,358.3,6564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6564,1,2,0)
 ;;=2^12037
 ;;^UTILITY(U,$J,358.3,6564,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,6565,0)
 ;;=17270^^45^417^1^^^^1
 ;;^UTILITY(U,$J,358.3,6565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6565,1,2,0)
 ;;=2^17270
 ;;^UTILITY(U,$J,358.3,6565,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,6566,0)
 ;;=17271^^45^417^2^^^^1
 ;;^UTILITY(U,$J,358.3,6566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6566,1,2,0)
 ;;=2^17271

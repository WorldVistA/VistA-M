IBDEI2B8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36885,1,2,0)
 ;;=2^11302
 ;;^UTILITY(U,$J,358.3,36885,1,3,0)
 ;;=3^Shaving Epiderm Arm/Leg: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,36886,0)
 ;;=11303^^143^1874^4^^^^1
 ;;^UTILITY(U,$J,358.3,36886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36886,1,2,0)
 ;;=2^11303
 ;;^UTILITY(U,$J,358.3,36886,1,3,0)
 ;;=3^Shaving Epiderm Arm/Leg > 2.0cm
 ;;^UTILITY(U,$J,358.3,36887,0)
 ;;=12001^^143^1875^1^^^^1
 ;;^UTILITY(U,$J,358.3,36887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36887,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,36887,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,36888,0)
 ;;=12002^^143^1875^2^^^^1
 ;;^UTILITY(U,$J,358.3,36888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36888,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,36888,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,36889,0)
 ;;=12004^^143^1875^3^^^^1
 ;;^UTILITY(U,$J,358.3,36889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36889,1,2,0)
 ;;=2^12004
 ;;^UTILITY(U,$J,358.3,36889,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,36890,0)
 ;;=12005^^143^1875^4^^^^1
 ;;^UTILITY(U,$J,358.3,36890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36890,1,2,0)
 ;;=2^12005
 ;;^UTILITY(U,$J,358.3,36890,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,36891,0)
 ;;=12006^^143^1875^5^^^^1
 ;;^UTILITY(U,$J,358.3,36891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36891,1,2,0)
 ;;=2^12006
 ;;^UTILITY(U,$J,358.3,36891,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,36892,0)
 ;;=12007^^143^1875^6^^^^1
 ;;^UTILITY(U,$J,358.3,36892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36892,1,2,0)
 ;;=2^12007
 ;;^UTILITY(U,$J,358.3,36892,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,36893,0)
 ;;=12031^^143^1876^1^^^^1
 ;;^UTILITY(U,$J,358.3,36893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36893,1,2,0)
 ;;=2^12031
 ;;^UTILITY(U,$J,358.3,36893,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,36894,0)
 ;;=12032^^143^1876^2^^^^1
 ;;^UTILITY(U,$J,358.3,36894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36894,1,2,0)
 ;;=2^12032
 ;;^UTILITY(U,$J,358.3,36894,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,36895,0)
 ;;=12034^^143^1876^3^^^^1
 ;;^UTILITY(U,$J,358.3,36895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36895,1,2,0)
 ;;=2^12034
 ;;^UTILITY(U,$J,358.3,36895,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,36896,0)
 ;;=12035^^143^1876^4^^^^1
 ;;^UTILITY(U,$J,358.3,36896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36896,1,2,0)
 ;;=2^12035
 ;;^UTILITY(U,$J,358.3,36896,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,36897,0)
 ;;=12036^^143^1876^5^^^^1
 ;;^UTILITY(U,$J,358.3,36897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36897,1,2,0)
 ;;=2^12036
 ;;^UTILITY(U,$J,358.3,36897,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,36898,0)
 ;;=12037^^143^1876^6^^^^1
 ;;^UTILITY(U,$J,358.3,36898,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36898,1,2,0)
 ;;=2^12037
 ;;^UTILITY(U,$J,358.3,36898,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,36899,0)
 ;;=17270^^143^1877^1^^^^1
 ;;^UTILITY(U,$J,358.3,36899,1,0)
 ;;=^358.31IA^3^2

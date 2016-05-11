IBDEI09E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4125,1,3,0)
 ;;=3^Shaving Epidermm Arm/Leg > 2.0cm
 ;;^UTILITY(U,$J,358.3,4126,0)
 ;;=12001^^20^241^1^^^^1
 ;;^UTILITY(U,$J,358.3,4126,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4126,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,4126,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,4127,0)
 ;;=12002^^20^241^2^^^^1
 ;;^UTILITY(U,$J,358.3,4127,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4127,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,4127,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,4128,0)
 ;;=12004^^20^241^3^^^^1
 ;;^UTILITY(U,$J,358.3,4128,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4128,1,2,0)
 ;;=2^12004
 ;;^UTILITY(U,$J,358.3,4128,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,4129,0)
 ;;=12005^^20^241^4^^^^1
 ;;^UTILITY(U,$J,358.3,4129,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4129,1,2,0)
 ;;=2^12005
 ;;^UTILITY(U,$J,358.3,4129,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,4130,0)
 ;;=12006^^20^241^5^^^^1
 ;;^UTILITY(U,$J,358.3,4130,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4130,1,2,0)
 ;;=2^12006
 ;;^UTILITY(U,$J,358.3,4130,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,4131,0)
 ;;=12007^^20^241^6^^^^1
 ;;^UTILITY(U,$J,358.3,4131,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4131,1,2,0)
 ;;=2^12007
 ;;^UTILITY(U,$J,358.3,4131,1,3,0)
 ;;=3^Simple repair Scalp/Nk/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,4132,0)
 ;;=12031^^20^242^1^^^^1
 ;;^UTILITY(U,$J,358.3,4132,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4132,1,2,0)
 ;;=2^12031
 ;;^UTILITY(U,$J,358.3,4132,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,4133,0)
 ;;=12032^^20^242^2^^^^1
 ;;^UTILITY(U,$J,358.3,4133,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4133,1,2,0)
 ;;=2^12032
 ;;^UTILITY(U,$J,358.3,4133,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,4134,0)
 ;;=12034^^20^242^3^^^^1
 ;;^UTILITY(U,$J,358.3,4134,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4134,1,2,0)
 ;;=2^12034
 ;;^UTILITY(U,$J,358.3,4134,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,4135,0)
 ;;=12035^^20^242^4^^^^1
 ;;^UTILITY(U,$J,358.3,4135,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4135,1,2,0)
 ;;=2^12035
 ;;^UTILITY(U,$J,358.3,4135,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,4136,0)
 ;;=12036^^20^242^5^^^^1
 ;;^UTILITY(U,$J,358.3,4136,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4136,1,2,0)
 ;;=2^12036
 ;;^UTILITY(U,$J,358.3,4136,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,4137,0)
 ;;=12037^^20^242^6^^^^1
 ;;^UTILITY(U,$J,358.3,4137,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4137,1,2,0)
 ;;=2^12037
 ;;^UTILITY(U,$J,358.3,4137,1,3,0)
 ;;=3^Interm Repair Scalp/Trunk; over 30 cm
 ;;^UTILITY(U,$J,358.3,4138,0)
 ;;=17270^^20^243^1^^^^1
 ;;^UTILITY(U,$J,358.3,4138,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4138,1,2,0)
 ;;=2^17270
 ;;^UTILITY(U,$J,358.3,4138,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,4139,0)
 ;;=17271^^20^243^2^^^^1
 ;;^UTILITY(U,$J,358.3,4139,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4139,1,2,0)
 ;;=2^17271
 ;;^UTILITY(U,$J,358.3,4139,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,4140,0)
 ;;=17272^^20^243^3^^^^1
 ;;^UTILITY(U,$J,358.3,4140,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4140,1,2,0)
 ;;=2^17272

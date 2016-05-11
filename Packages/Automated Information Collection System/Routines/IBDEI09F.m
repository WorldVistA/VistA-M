IBDEI09F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4140,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,4141,0)
 ;;=17273^^20^243^4^^^^1
 ;;^UTILITY(U,$J,358.3,4141,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4141,1,2,0)
 ;;=2^17273
 ;;^UTILITY(U,$J,358.3,4141,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,4142,0)
 ;;=17274^^20^243^5^^^^1
 ;;^UTILITY(U,$J,358.3,4142,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4142,1,2,0)
 ;;=2^17274
 ;;^UTILITY(U,$J,358.3,4142,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,4143,0)
 ;;=17276^^20^243^6^^^^1
 ;;^UTILITY(U,$J,358.3,4143,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4143,1,2,0)
 ;;=2^17276
 ;;^UTILITY(U,$J,358.3,4143,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,4144,0)
 ;;=17280^^20^244^1^^^^1
 ;;^UTILITY(U,$J,358.3,4144,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4144,1,2,0)
 ;;=2^17280
 ;;^UTILITY(U,$J,358.3,4144,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,4145,0)
 ;;=17281^^20^244^2^^^^1
 ;;^UTILITY(U,$J,358.3,4145,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4145,1,2,0)
 ;;=2^17281
 ;;^UTILITY(U,$J,358.3,4145,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,4146,0)
 ;;=17282^^20^244^3^^^^1
 ;;^UTILITY(U,$J,358.3,4146,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4146,1,2,0)
 ;;=2^17282
 ;;^UTILITY(U,$J,358.3,4146,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,4147,0)
 ;;=17283^^20^244^4^^^^1
 ;;^UTILITY(U,$J,358.3,4147,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4147,1,2,0)
 ;;=2^17283
 ;;^UTILITY(U,$J,358.3,4147,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,4148,0)
 ;;=17284^^20^244^5^^^^1
 ;;^UTILITY(U,$J,358.3,4148,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4148,1,2,0)
 ;;=2^17284
 ;;^UTILITY(U,$J,358.3,4148,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,4149,0)
 ;;=17286^^20^244^6^^^^1
 ;;^UTILITY(U,$J,358.3,4149,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4149,1,2,0)
 ;;=2^17286
 ;;^UTILITY(U,$J,358.3,4149,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,4150,0)
 ;;=11420^^20^245^1^^^^1
 ;;^UTILITY(U,$J,358.3,4150,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4150,1,2,0)
 ;;=2^11420
 ;;^UTILITY(U,$J,358.3,4150,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,4151,0)
 ;;=11421^^20^245^2^^^^1
 ;;^UTILITY(U,$J,358.3,4151,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4151,1,2,0)
 ;;=2^11421
 ;;^UTILITY(U,$J,358.3,4151,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,4152,0)
 ;;=11422^^20^245^3^^^^1
 ;;^UTILITY(U,$J,358.3,4152,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4152,1,2,0)
 ;;=2^11422
 ;;^UTILITY(U,$J,358.3,4152,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,4153,0)
 ;;=11423^^20^245^4^^^^1
 ;;^UTILITY(U,$J,358.3,4153,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4153,1,2,0)
 ;;=2^11423
 ;;^UTILITY(U,$J,358.3,4153,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,4154,0)
 ;;=11424^^20^245^5^^^^1
 ;;^UTILITY(U,$J,358.3,4154,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4154,1,2,0)
 ;;=2^11424
 ;;^UTILITY(U,$J,358.3,4154,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,4155,0)
 ;;=11426^^20^245^6^^^^1
 ;;^UTILITY(U,$J,358.3,4155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4155,1,2,0)
 ;;=2^11426
 ;;^UTILITY(U,$J,358.3,4155,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm

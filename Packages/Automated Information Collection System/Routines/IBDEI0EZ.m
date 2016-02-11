IBDEI0EZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6566,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,6567,0)
 ;;=17272^^45^417^3^^^^1
 ;;^UTILITY(U,$J,358.3,6567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6567,1,2,0)
 ;;=2^17272
 ;;^UTILITY(U,$J,358.3,6567,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,6568,0)
 ;;=17273^^45^417^4^^^^1
 ;;^UTILITY(U,$J,358.3,6568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6568,1,2,0)
 ;;=2^17273
 ;;^UTILITY(U,$J,358.3,6568,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,6569,0)
 ;;=17274^^45^417^5^^^^1
 ;;^UTILITY(U,$J,358.3,6569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6569,1,2,0)
 ;;=2^17274
 ;;^UTILITY(U,$J,358.3,6569,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,6570,0)
 ;;=17276^^45^417^6^^^^1
 ;;^UTILITY(U,$J,358.3,6570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6570,1,2,0)
 ;;=2^17276
 ;;^UTILITY(U,$J,358.3,6570,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,6571,0)
 ;;=17280^^45^418^1^^^^1
 ;;^UTILITY(U,$J,358.3,6571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6571,1,2,0)
 ;;=2^17280
 ;;^UTILITY(U,$J,358.3,6571,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,6572,0)
 ;;=17281^^45^418^2^^^^1
 ;;^UTILITY(U,$J,358.3,6572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6572,1,2,0)
 ;;=2^17281
 ;;^UTILITY(U,$J,358.3,6572,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,6573,0)
 ;;=17282^^45^418^3^^^^1
 ;;^UTILITY(U,$J,358.3,6573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6573,1,2,0)
 ;;=2^17282
 ;;^UTILITY(U,$J,358.3,6573,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,6574,0)
 ;;=17283^^45^418^4^^^^1
 ;;^UTILITY(U,$J,358.3,6574,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6574,1,2,0)
 ;;=2^17283
 ;;^UTILITY(U,$J,358.3,6574,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,6575,0)
 ;;=17284^^45^418^5^^^^1
 ;;^UTILITY(U,$J,358.3,6575,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6575,1,2,0)
 ;;=2^17284
 ;;^UTILITY(U,$J,358.3,6575,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,6576,0)
 ;;=17286^^45^418^6^^^^1
 ;;^UTILITY(U,$J,358.3,6576,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6576,1,2,0)
 ;;=2^17286
 ;;^UTILITY(U,$J,358.3,6576,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,6577,0)
 ;;=11420^^45^419^1^^^^1
 ;;^UTILITY(U,$J,358.3,6577,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6577,1,2,0)
 ;;=2^11420
 ;;^UTILITY(U,$J,358.3,6577,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,6578,0)
 ;;=11421^^45^419^2^^^^1
 ;;^UTILITY(U,$J,358.3,6578,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6578,1,2,0)
 ;;=2^11421
 ;;^UTILITY(U,$J,358.3,6578,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,6579,0)
 ;;=11422^^45^419^3^^^^1
 ;;^UTILITY(U,$J,358.3,6579,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6579,1,2,0)
 ;;=2^11422
 ;;^UTILITY(U,$J,358.3,6579,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,6580,0)
 ;;=11423^^45^419^4^^^^1
 ;;^UTILITY(U,$J,358.3,6580,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6580,1,2,0)
 ;;=2^11423
 ;;^UTILITY(U,$J,358.3,6580,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,6581,0)
 ;;=11424^^45^419^5^^^^1
 ;;^UTILITY(U,$J,358.3,6581,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6581,1,2,0)
 ;;=2^11424
 ;;^UTILITY(U,$J,358.3,6581,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm

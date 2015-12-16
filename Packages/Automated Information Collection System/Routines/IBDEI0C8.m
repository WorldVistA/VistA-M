IBDEI0C8 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5431,0)
 ;;=17273^^26^336^4^^^^1
 ;;^UTILITY(U,$J,358.3,5431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5431,1,2,0)
 ;;=2^17273
 ;;^UTILITY(U,$J,358.3,5431,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5432,0)
 ;;=17274^^26^336^5^^^^1
 ;;^UTILITY(U,$J,358.3,5432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5432,1,2,0)
 ;;=2^17274
 ;;^UTILITY(U,$J,358.3,5432,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5433,0)
 ;;=17276^^26^336^6^^^^1
 ;;^UTILITY(U,$J,358.3,5433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5433,1,2,0)
 ;;=2^17276
 ;;^UTILITY(U,$J,358.3,5433,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5434,0)
 ;;=17280^^26^337^1^^^^1
 ;;^UTILITY(U,$J,358.3,5434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5434,1,2,0)
 ;;=2^17280
 ;;^UTILITY(U,$J,358.3,5434,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5435,0)
 ;;=17281^^26^337^2^^^^1
 ;;^UTILITY(U,$J,358.3,5435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5435,1,2,0)
 ;;=2^17281
 ;;^UTILITY(U,$J,358.3,5435,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5436,0)
 ;;=17282^^26^337^3^^^^1
 ;;^UTILITY(U,$J,358.3,5436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5436,1,2,0)
 ;;=2^17282
 ;;^UTILITY(U,$J,358.3,5436,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5437,0)
 ;;=17283^^26^337^4^^^^1
 ;;^UTILITY(U,$J,358.3,5437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5437,1,2,0)
 ;;=2^17283
 ;;^UTILITY(U,$J,358.3,5437,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5438,0)
 ;;=17284^^26^337^5^^^^1
 ;;^UTILITY(U,$J,358.3,5438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5438,1,2,0)
 ;;=2^17284
 ;;^UTILITY(U,$J,358.3,5438,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5439,0)
 ;;=17286^^26^337^6^^^^1
 ;;^UTILITY(U,$J,358.3,5439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5439,1,2,0)
 ;;=2^17286
 ;;^UTILITY(U,$J,358.3,5439,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5440,0)
 ;;=11420^^26^338^1^^^^1
 ;;^UTILITY(U,$J,358.3,5440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5440,1,2,0)
 ;;=2^11420
 ;;^UTILITY(U,$J,358.3,5440,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5441,0)
 ;;=11421^^26^338^2^^^^1
 ;;^UTILITY(U,$J,358.3,5441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5441,1,2,0)
 ;;=2^11421
 ;;^UTILITY(U,$J,358.3,5441,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5442,0)
 ;;=11422^^26^338^3^^^^1
 ;;^UTILITY(U,$J,358.3,5442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5442,1,2,0)
 ;;=2^11422
 ;;^UTILITY(U,$J,358.3,5442,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5443,0)
 ;;=11423^^26^338^4^^^^1
 ;;^UTILITY(U,$J,358.3,5443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5443,1,2,0)
 ;;=2^11423
 ;;^UTILITY(U,$J,358.3,5443,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5444,0)
 ;;=11424^^26^338^5^^^^1
 ;;^UTILITY(U,$J,358.3,5444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5444,1,2,0)
 ;;=2^11424
 ;;^UTILITY(U,$J,358.3,5444,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5445,0)
 ;;=11426^^26^338^6^^^^1
 ;;^UTILITY(U,$J,358.3,5445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5445,1,2,0)
 ;;=2^11426
 ;;^UTILITY(U,$J,358.3,5445,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5446,0)
 ;;=11440^^26^339^1^^^^1

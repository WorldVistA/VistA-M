IBDEI02P ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,714,1,4,0)
 ;;=4^Z20.01
 ;;^UTILITY(U,$J,358.3,714,2)
 ;;=^5062761
 ;;^UTILITY(U,$J,358.3,715,0)
 ;;=Z20.811^^3^31^4
 ;;^UTILITY(U,$J,358.3,715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,715,1,3,0)
 ;;=3^Contact/Exposure to Meningococcus
 ;;^UTILITY(U,$J,358.3,715,1,4,0)
 ;;=4^Z20.811
 ;;^UTILITY(U,$J,358.3,715,2)
 ;;=^5062771
 ;;^UTILITY(U,$J,358.3,716,0)
 ;;=Z20.89^^3^31^1
 ;;^UTILITY(U,$J,358.3,716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,716,1,3,0)
 ;;=3^Contact/Exposure to Communicable Diseases NEC
 ;;^UTILITY(U,$J,358.3,716,1,4,0)
 ;;=4^Z20.89
 ;;^UTILITY(U,$J,358.3,716,2)
 ;;=^5062775
 ;;^UTILITY(U,$J,358.3,717,0)
 ;;=B07.9^^3^32^151
 ;;^UTILITY(U,$J,358.3,717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,717,1,3,0)
 ;;=3^Viral wart, unspecified
 ;;^UTILITY(U,$J,358.3,717,1,4,0)
 ;;=4^B07.9
 ;;^UTILITY(U,$J,358.3,717,2)
 ;;=^5000519
 ;;^UTILITY(U,$J,358.3,718,0)
 ;;=A63.0^^3^32^6
 ;;^UTILITY(U,$J,358.3,718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,718,1,3,0)
 ;;=3^Anogenital (venereal) warts
 ;;^UTILITY(U,$J,358.3,718,1,4,0)
 ;;=4^A63.0
 ;;^UTILITY(U,$J,358.3,718,2)
 ;;=^5000360
 ;;^UTILITY(U,$J,358.3,719,0)
 ;;=B35.0^^3^32^144
 ;;^UTILITY(U,$J,358.3,719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,719,1,3,0)
 ;;=3^Tinea barbae and tinea capitis
 ;;^UTILITY(U,$J,358.3,719,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,719,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,720,0)
 ;;=B35.1^^3^32^148
 ;;^UTILITY(U,$J,358.3,720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,720,1,3,0)
 ;;=3^Tinea unguium
 ;;^UTILITY(U,$J,358.3,720,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,720,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,721,0)
 ;;=B35.6^^3^32^145
 ;;^UTILITY(U,$J,358.3,721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,721,1,3,0)
 ;;=3^Tinea cruris
 ;;^UTILITY(U,$J,358.3,721,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,721,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,722,0)
 ;;=B35.3^^3^32^147
 ;;^UTILITY(U,$J,358.3,722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,722,1,3,0)
 ;;=3^Tinea pedis
 ;;^UTILITY(U,$J,358.3,722,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,722,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,723,0)
 ;;=B35.5^^3^32^146
 ;;^UTILITY(U,$J,358.3,723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,723,1,3,0)
 ;;=3^Tinea imbricata
 ;;^UTILITY(U,$J,358.3,723,1,4,0)
 ;;=4^B35.5
 ;;^UTILITY(U,$J,358.3,723,2)
 ;;=^119725
 ;;^UTILITY(U,$J,358.3,724,0)
 ;;=B35.8^^3^32^30
 ;;^UTILITY(U,$J,358.3,724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,724,1,3,0)
 ;;=3^Dermatophytoses NEC
 ;;^UTILITY(U,$J,358.3,724,1,4,0)
 ;;=4^B35.8
 ;;^UTILITY(U,$J,358.3,724,2)
 ;;=^5000606
 ;;^UTILITY(U,$J,358.3,725,0)
 ;;=B36.9^^3^32^142
 ;;^UTILITY(U,$J,358.3,725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,725,1,3,0)
 ;;=3^Superficial mycosis, unspecified
 ;;^UTILITY(U,$J,358.3,725,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,725,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,726,0)
 ;;=B17.9^^3^32^4
 ;;^UTILITY(U,$J,358.3,726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,726,1,3,0)
 ;;=3^Acute viral hepatitis, unspecified
 ;;^UTILITY(U,$J,358.3,726,1,4,0)
 ;;=4^B17.9
 ;;^UTILITY(U,$J,358.3,726,2)
 ;;=^5000545
 ;;^UTILITY(U,$J,358.3,727,0)
 ;;=D69.0^^3^32^5
 ;;^UTILITY(U,$J,358.3,727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,727,1,3,0)
 ;;=3^Allergic purpura
 ;;^UTILITY(U,$J,358.3,727,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,727,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,728,0)
 ;;=H05.011^^3^32^23
 ;;^UTILITY(U,$J,358.3,728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,728,1,3,0)
 ;;=3^Cellulitis of right orbit
 ;;^UTILITY(U,$J,358.3,728,1,4,0)
 ;;=4^H05.011

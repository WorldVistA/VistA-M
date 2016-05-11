IBDEI06L ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2758,1,3,0)
 ;;=3^Breast Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2758,1,4,0)
 ;;=4^N64.9
 ;;^UTILITY(U,$J,358.3,2758,2)
 ;;=^5015799
 ;;^UTILITY(U,$J,358.3,2759,0)
 ;;=N65.1^^18^208^15
 ;;^UTILITY(U,$J,358.3,2759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2759,1,3,0)
 ;;=3^Breast Reconstructed Disproportion
 ;;^UTILITY(U,$J,358.3,2759,1,4,0)
 ;;=4^N65.1
 ;;^UTILITY(U,$J,358.3,2759,2)
 ;;=^5015801
 ;;^UTILITY(U,$J,358.3,2760,0)
 ;;=N60.92^^18^208^10
 ;;^UTILITY(U,$J,358.3,2760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2760,1,3,0)
 ;;=3^Breast Dysplasia,Benign Mammary,Left
 ;;^UTILITY(U,$J,358.3,2760,1,4,0)
 ;;=4^N60.92
 ;;^UTILITY(U,$J,358.3,2760,2)
 ;;=^5134091
 ;;^UTILITY(U,$J,358.3,2761,0)
 ;;=N60.91^^18^208^11
 ;;^UTILITY(U,$J,358.3,2761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2761,1,3,0)
 ;;=3^Breast Dysplasia,Benign Mammary,Right
 ;;^UTILITY(U,$J,358.3,2761,1,4,0)
 ;;=4^N60.91
 ;;^UTILITY(U,$J,358.3,2761,2)
 ;;=^5015788
 ;;^UTILITY(U,$J,358.3,2762,0)
 ;;=N62.^^18^208^12
 ;;^UTILITY(U,$J,358.3,2762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2762,1,3,0)
 ;;=3^Breast Hypertrophy
 ;;^UTILITY(U,$J,358.3,2762,1,4,0)
 ;;=4^N62.
 ;;^UTILITY(U,$J,358.3,2762,2)
 ;;=^5015790
 ;;^UTILITY(U,$J,358.3,2763,0)
 ;;=N61.^^18^208^13
 ;;^UTILITY(U,$J,358.3,2763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2763,1,3,0)
 ;;=3^Breast Inflammatory Disorders
 ;;^UTILITY(U,$J,358.3,2763,1,4,0)
 ;;=4^N61.
 ;;^UTILITY(U,$J,358.3,2763,2)
 ;;=^5015789
 ;;^UTILITY(U,$J,358.3,2764,0)
 ;;=N63.^^18^208^14
 ;;^UTILITY(U,$J,358.3,2764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2764,1,3,0)
 ;;=3^Breast Lump,Unspec
 ;;^UTILITY(U,$J,358.3,2764,1,4,0)
 ;;=4^N63.
 ;;^UTILITY(U,$J,358.3,2764,2)
 ;;=^5015791
 ;;^UTILITY(U,$J,358.3,2765,0)
 ;;=L13.9^^18^208^17
 ;;^UTILITY(U,$J,358.3,2765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2765,1,3,0)
 ;;=3^Bullous Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2765,1,4,0)
 ;;=4^L13.9
 ;;^UTILITY(U,$J,358.3,2765,2)
 ;;=^5009105
 ;;^UTILITY(U,$J,358.3,2766,0)
 ;;=L02.93^^18^208^18
 ;;^UTILITY(U,$J,358.3,2766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2766,1,3,0)
 ;;=3^Carbuncle,Unspec
 ;;^UTILITY(U,$J,358.3,2766,1,4,0)
 ;;=4^L02.93
 ;;^UTILITY(U,$J,358.3,2766,2)
 ;;=^5009018
 ;;^UTILITY(U,$J,358.3,2767,0)
 ;;=L03.90^^18^208^19
 ;;^UTILITY(U,$J,358.3,2767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2767,1,3,0)
 ;;=3^Cellulitis,Unspec
 ;;^UTILITY(U,$J,358.3,2767,1,4,0)
 ;;=4^L03.90
 ;;^UTILITY(U,$J,358.3,2767,2)
 ;;=^5009067
 ;;^UTILITY(U,$J,358.3,2768,0)
 ;;=L94.9^^18^208^20
 ;;^UTILITY(U,$J,358.3,2768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2768,1,3,0)
 ;;=3^Connective Tissue Disorder,Localized,Unspec
 ;;^UTILITY(U,$J,358.3,2768,1,4,0)
 ;;=4^L94.9
 ;;^UTILITY(U,$J,358.3,2768,2)
 ;;=^5009475
 ;;^UTILITY(U,$J,358.3,2769,0)
 ;;=L84.^^18^208^21
 ;;^UTILITY(U,$J,358.3,2769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2769,1,3,0)
 ;;=3^Corns & Callosities
 ;;^UTILITY(U,$J,358.3,2769,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,2769,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,2770,0)
 ;;=L27.0^^18^208^23
 ;;^UTILITY(U,$J,358.3,2770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2770,1,3,0)
 ;;=3^Dermatitis d/t Drugs/Meds Taken Internally,General
 ;;^UTILITY(U,$J,358.3,2770,1,4,0)
 ;;=4^L27.0
 ;;^UTILITY(U,$J,358.3,2770,2)
 ;;=^5009144
 ;;^UTILITY(U,$J,358.3,2771,0)
 ;;=L27.1^^18^208^24
 ;;^UTILITY(U,$J,358.3,2771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2771,1,3,0)
 ;;=3^Dermatitis d/t Drugs/Meds Taken Internally,Local
 ;;^UTILITY(U,$J,358.3,2771,1,4,0)
 ;;=4^L27.1

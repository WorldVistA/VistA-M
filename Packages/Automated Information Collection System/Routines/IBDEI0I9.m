IBDEI0I9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8472,1,3,0)
 ;;=3^Hypertrophy of salivary gland
 ;;^UTILITY(U,$J,358.3,8472,1,4,0)
 ;;=4^K11.1
 ;;^UTILITY(U,$J,358.3,8472,2)
 ;;=^60462
 ;;^UTILITY(U,$J,358.3,8473,0)
 ;;=K11.20^^39^458^13
 ;;^UTILITY(U,$J,358.3,8473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8473,1,3,0)
 ;;=3^Sialoadenitis, unspecified
 ;;^UTILITY(U,$J,358.3,8473,1,4,0)
 ;;=4^K11.20
 ;;^UTILITY(U,$J,358.3,8473,2)
 ;;=^5008473
 ;;^UTILITY(U,$J,358.3,8474,0)
 ;;=K11.5^^39^458^14
 ;;^UTILITY(U,$J,358.3,8474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8474,1,3,0)
 ;;=3^Sialolithiasis
 ;;^UTILITY(U,$J,358.3,8474,1,4,0)
 ;;=4^K11.5
 ;;^UTILITY(U,$J,358.3,8474,2)
 ;;=^5008478
 ;;^UTILITY(U,$J,358.3,8475,0)
 ;;=K11.6^^39^458^11
 ;;^UTILITY(U,$J,358.3,8475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8475,1,3,0)
 ;;=3^Mucocele of salivary gland
 ;;^UTILITY(U,$J,358.3,8475,1,4,0)
 ;;=4^K11.6
 ;;^UTILITY(U,$J,358.3,8475,2)
 ;;=^5008479
 ;;^UTILITY(U,$J,358.3,8476,0)
 ;;=K11.7^^39^458^1
 ;;^UTILITY(U,$J,358.3,8476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8476,1,3,0)
 ;;=3^Disturbances of salivary secretion
 ;;^UTILITY(U,$J,358.3,8476,1,4,0)
 ;;=4^K11.7
 ;;^UTILITY(U,$J,358.3,8476,2)
 ;;=^5008480
 ;;^UTILITY(U,$J,358.3,8477,0)
 ;;=K11.8^^39^458^12
 ;;^UTILITY(U,$J,358.3,8477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8477,1,3,0)
 ;;=3^Salivary Gland Diseases NEC
 ;;^UTILITY(U,$J,358.3,8477,1,4,0)
 ;;=4^K11.8
 ;;^UTILITY(U,$J,358.3,8477,2)
 ;;=^5008481
 ;;^UTILITY(U,$J,358.3,8478,0)
 ;;=K13.21^^39^458^10
 ;;^UTILITY(U,$J,358.3,8478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8478,1,3,0)
 ;;=3^Leukoplakia of oral mucosa, including tongue
 ;;^UTILITY(U,$J,358.3,8478,1,4,0)
 ;;=4^K13.21
 ;;^UTILITY(U,$J,358.3,8478,2)
 ;;=^270054
 ;;^UTILITY(U,$J,358.3,8479,0)
 ;;=K14.0^^39^458^7
 ;;^UTILITY(U,$J,358.3,8479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8479,1,3,0)
 ;;=3^Glossitis
 ;;^UTILITY(U,$J,358.3,8479,1,4,0)
 ;;=4^K14.0
 ;;^UTILITY(U,$J,358.3,8479,2)
 ;;=^51478
 ;;^UTILITY(U,$J,358.3,8480,0)
 ;;=K14.1^^39^458^6
 ;;^UTILITY(U,$J,358.3,8480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8480,1,3,0)
 ;;=3^Geographic tongue
 ;;^UTILITY(U,$J,358.3,8480,1,4,0)
 ;;=4^K14.1
 ;;^UTILITY(U,$J,358.3,8480,2)
 ;;=^5008498
 ;;^UTILITY(U,$J,358.3,8481,0)
 ;;=K14.3^^39^458^9
 ;;^UTILITY(U,$J,358.3,8481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8481,1,3,0)
 ;;=3^Hypertrophy of tongue papillae
 ;;^UTILITY(U,$J,358.3,8481,1,4,0)
 ;;=4^K14.3
 ;;^UTILITY(U,$J,358.3,8481,2)
 ;;=^5008499
 ;;^UTILITY(U,$J,358.3,8482,0)
 ;;=K14.8^^39^458^16
 ;;^UTILITY(U,$J,358.3,8482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8482,1,3,0)
 ;;=3^Tongue Diseases NEC
 ;;^UTILITY(U,$J,358.3,8482,1,4,0)
 ;;=4^K14.8
 ;;^UTILITY(U,$J,358.3,8482,2)
 ;;=^5008502
 ;;^UTILITY(U,$J,358.3,8483,0)
 ;;=R13.10^^39^458^5
 ;;^UTILITY(U,$J,358.3,8483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8483,1,3,0)
 ;;=3^Dysphagia, unspecified
 ;;^UTILITY(U,$J,358.3,8483,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,8483,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,8484,0)
 ;;=R13.12^^39^458^2
 ;;^UTILITY(U,$J,358.3,8484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8484,1,3,0)
 ;;=3^Dysphagia, oropharyngeal phase
 ;;^UTILITY(U,$J,358.3,8484,1,4,0)
 ;;=4^R13.12
 ;;^UTILITY(U,$J,358.3,8484,2)
 ;;=^335277
 ;;^UTILITY(U,$J,358.3,8485,0)
 ;;=R13.13^^39^458^3
 ;;^UTILITY(U,$J,358.3,8485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8485,1,3,0)
 ;;=3^Dysphagia, pharyngeal phase
 ;;^UTILITY(U,$J,358.3,8485,1,4,0)
 ;;=4^R13.13
 ;;^UTILITY(U,$J,358.3,8485,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,8486,0)
 ;;=R13.14^^39^458^4

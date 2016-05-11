IBDEI0OY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11656,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,11656,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,11657,0)
 ;;=G62.81^^47^534^92
 ;;^UTILITY(U,$J,358.3,11657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11657,1,3,0)
 ;;=3^Neuropathy,Critical Illness Polyneuropathy
 ;;^UTILITY(U,$J,358.3,11657,1,4,0)
 ;;=4^G62.81
 ;;^UTILITY(U,$J,358.3,11657,2)
 ;;=^328481
 ;;^UTILITY(U,$J,358.3,11658,0)
 ;;=G62.1^^47^534^87
 ;;^UTILITY(U,$J,358.3,11658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11658,1,3,0)
 ;;=3^Neuropathy,Alcoholic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,11658,1,4,0)
 ;;=4^G62.1
 ;;^UTILITY(U,$J,358.3,11658,2)
 ;;=^5004076
 ;;^UTILITY(U,$J,358.3,11659,0)
 ;;=G51.0^^47^534^88
 ;;^UTILITY(U,$J,358.3,11659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11659,1,3,0)
 ;;=3^Neuropathy,Bell's Palsy
 ;;^UTILITY(U,$J,358.3,11659,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,11659,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,11660,0)
 ;;=G56.01^^47^534^90
 ;;^UTILITY(U,$J,358.3,11660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11660,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Rt Upper Limb
 ;;^UTILITY(U,$J,358.3,11660,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,11660,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,11661,0)
 ;;=G56.02^^47^534^89
 ;;^UTILITY(U,$J,358.3,11661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11661,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Lt Upper Limb
 ;;^UTILITY(U,$J,358.3,11661,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,11661,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,11662,0)
 ;;=G52.9^^47^534^91
 ;;^UTILITY(U,$J,358.3,11662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11662,1,3,0)
 ;;=3^Neuropathy,Cranial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11662,1,4,0)
 ;;=4^G52.9
 ;;^UTILITY(U,$J,358.3,11662,2)
 ;;=^5004005
 ;;^UTILITY(U,$J,358.3,11663,0)
 ;;=G51.9^^47^534^95
 ;;^UTILITY(U,$J,358.3,11663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11663,1,3,0)
 ;;=3^Neuropathy,Facial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11663,1,4,0)
 ;;=4^G51.9
 ;;^UTILITY(U,$J,358.3,11663,2)
 ;;=^5003998
 ;;^UTILITY(U,$J,358.3,11664,0)
 ;;=G62.0^^47^534^93
 ;;^UTILITY(U,$J,358.3,11664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11664,1,3,0)
 ;;=3^Neuropathy,Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,11664,1,4,0)
 ;;=4^G62.0
 ;;^UTILITY(U,$J,358.3,11664,2)
 ;;=^5004075
 ;;^UTILITY(U,$J,358.3,11665,0)
 ;;=G61.0^^47^534^96
 ;;^UTILITY(U,$J,358.3,11665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11665,1,3,0)
 ;;=3^Neuropathy,Guillain-Barre Syndrome
 ;;^UTILITY(U,$J,358.3,11665,1,4,0)
 ;;=4^G61.0
 ;;^UTILITY(U,$J,358.3,11665,2)
 ;;=^53405
 ;;^UTILITY(U,$J,358.3,11666,0)
 ;;=G60.9^^47^534^97
 ;;^UTILITY(U,$J,358.3,11666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11666,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,11666,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,11666,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,11667,0)
 ;;=G61.9^^47^534^98
 ;;^UTILITY(U,$J,358.3,11667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11667,1,3,0)
 ;;=3^Neuropathy,Inflammatory Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,11667,1,4,0)
 ;;=4^G61.9
 ;;^UTILITY(U,$J,358.3,11667,2)
 ;;=^5004074
 ;;^UTILITY(U,$J,358.3,11668,0)
 ;;=G58.9^^47^534^100
 ;;^UTILITY(U,$J,358.3,11668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11668,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,11668,1,4,0)
 ;;=4^G58.9
 ;;^UTILITY(U,$J,358.3,11668,2)
 ;;=^5004065
 ;;^UTILITY(U,$J,358.3,11669,0)
 ;;=G54.9^^47^534^102
 ;;^UTILITY(U,$J,358.3,11669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11669,1,3,0)
 ;;=3^Neuropathy,Nerve Root/Plexus Disorder,Unspec

IBDEI0W0 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14248,0)
 ;;=G56.01^^83^822^104
 ;;^UTILITY(U,$J,358.3,14248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14248,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Rt Upper Limb
 ;;^UTILITY(U,$J,358.3,14248,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,14248,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,14249,0)
 ;;=G56.02^^83^822^103
 ;;^UTILITY(U,$J,358.3,14249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14249,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Lt Upper Limb
 ;;^UTILITY(U,$J,358.3,14249,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,14249,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,14250,0)
 ;;=G52.9^^83^822^105
 ;;^UTILITY(U,$J,358.3,14250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14250,1,3,0)
 ;;=3^Neuropathy,Cranial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,14250,1,4,0)
 ;;=4^G52.9
 ;;^UTILITY(U,$J,358.3,14250,2)
 ;;=^5004005
 ;;^UTILITY(U,$J,358.3,14251,0)
 ;;=G51.9^^83^822^109
 ;;^UTILITY(U,$J,358.3,14251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14251,1,3,0)
 ;;=3^Neuropathy,Facial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,14251,1,4,0)
 ;;=4^G51.9
 ;;^UTILITY(U,$J,358.3,14251,2)
 ;;=^5003998
 ;;^UTILITY(U,$J,358.3,14252,0)
 ;;=G62.0^^83^822^107
 ;;^UTILITY(U,$J,358.3,14252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14252,1,3,0)
 ;;=3^Neuropathy,Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,14252,1,4,0)
 ;;=4^G62.0
 ;;^UTILITY(U,$J,358.3,14252,2)
 ;;=^5004075
 ;;^UTILITY(U,$J,358.3,14253,0)
 ;;=G61.0^^83^822^110
 ;;^UTILITY(U,$J,358.3,14253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14253,1,3,0)
 ;;=3^Neuropathy,Guillain-Barre Syndrome
 ;;^UTILITY(U,$J,358.3,14253,1,4,0)
 ;;=4^G61.0
 ;;^UTILITY(U,$J,358.3,14253,2)
 ;;=^53405
 ;;^UTILITY(U,$J,358.3,14254,0)
 ;;=G60.9^^83^822^111
 ;;^UTILITY(U,$J,358.3,14254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14254,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,14254,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,14254,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,14255,0)
 ;;=G61.9^^83^822^112
 ;;^UTILITY(U,$J,358.3,14255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14255,1,3,0)
 ;;=3^Neuropathy,Inflammatory Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,14255,1,4,0)
 ;;=4^G61.9
 ;;^UTILITY(U,$J,358.3,14255,2)
 ;;=^5004074
 ;;^UTILITY(U,$J,358.3,14256,0)
 ;;=G58.9^^83^822^114
 ;;^UTILITY(U,$J,358.3,14256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14256,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,14256,1,4,0)
 ;;=4^G58.9
 ;;^UTILITY(U,$J,358.3,14256,2)
 ;;=^5004065
 ;;^UTILITY(U,$J,358.3,14257,0)
 ;;=G54.9^^83^822^116
 ;;^UTILITY(U,$J,358.3,14257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14257,1,3,0)
 ;;=3^Neuropathy,Nerve Root/Plexus Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,14257,1,4,0)
 ;;=4^G54.9
 ;;^UTILITY(U,$J,358.3,14257,2)
 ;;=^5004015
 ;;^UTILITY(U,$J,358.3,14258,0)
 ;;=G54.6^^83^822^117
 ;;^UTILITY(U,$J,358.3,14258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14258,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/ Pain
 ;;^UTILITY(U,$J,358.3,14258,1,4,0)
 ;;=4^G54.6
 ;;^UTILITY(U,$J,358.3,14258,2)
 ;;=^5004013
 ;;^UTILITY(U,$J,358.3,14259,0)
 ;;=G54.7^^83^822^118
 ;;^UTILITY(U,$J,358.3,14259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14259,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/o Pain
 ;;^UTILITY(U,$J,358.3,14259,1,4,0)
 ;;=4^G54.7
 ;;^UTILITY(U,$J,358.3,14259,2)
 ;;=^5004014

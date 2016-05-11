IBDEI08B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3590,1,4,0)
 ;;=4^G25.70
 ;;^UTILITY(U,$J,358.3,3590,2)
 ;;=^5003798
 ;;^UTILITY(U,$J,358.3,3591,0)
 ;;=G35.^^18^220^81
 ;;^UTILITY(U,$J,358.3,3591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3591,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,3591,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,3591,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,3592,0)
 ;;=G25.3^^18^220^82
 ;;^UTILITY(U,$J,358.3,3592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3592,1,3,0)
 ;;=3^Myoclonus
 ;;^UTILITY(U,$J,358.3,3592,1,4,0)
 ;;=4^G25.3
 ;;^UTILITY(U,$J,358.3,3592,2)
 ;;=^80620
 ;;^UTILITY(U,$J,358.3,3593,0)
 ;;=G70.9^^18^220^83
 ;;^UTILITY(U,$J,358.3,3593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3593,1,3,0)
 ;;=3^Myoneural Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3593,1,4,0)
 ;;=4^G70.9
 ;;^UTILITY(U,$J,358.3,3593,2)
 ;;=^5004087
 ;;^UTILITY(U,$J,358.3,3594,0)
 ;;=G31.9^^18^220^84
 ;;^UTILITY(U,$J,358.3,3594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3594,1,3,0)
 ;;=3^Nervous System Degenerative Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3594,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,3594,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,3595,0)
 ;;=G50.0^^18^220^86
 ;;^UTILITY(U,$J,358.3,3595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3595,1,3,0)
 ;;=3^Neuralgia,Trigeminal
 ;;^UTILITY(U,$J,358.3,3595,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,3595,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,3596,0)
 ;;=G62.81^^18^220^92
 ;;^UTILITY(U,$J,358.3,3596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3596,1,3,0)
 ;;=3^Neuropathy,Critical Illness Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3596,1,4,0)
 ;;=4^G62.81
 ;;^UTILITY(U,$J,358.3,3596,2)
 ;;=^328481
 ;;^UTILITY(U,$J,358.3,3597,0)
 ;;=G62.1^^18^220^87
 ;;^UTILITY(U,$J,358.3,3597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3597,1,3,0)
 ;;=3^Neuropathy,Alcoholic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3597,1,4,0)
 ;;=4^G62.1
 ;;^UTILITY(U,$J,358.3,3597,2)
 ;;=^5004076
 ;;^UTILITY(U,$J,358.3,3598,0)
 ;;=G51.0^^18^220^88
 ;;^UTILITY(U,$J,358.3,3598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3598,1,3,0)
 ;;=3^Neuropathy,Bell's Palsy
 ;;^UTILITY(U,$J,358.3,3598,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,3598,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,3599,0)
 ;;=G56.01^^18^220^90
 ;;^UTILITY(U,$J,358.3,3599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3599,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Rt Upper Limb
 ;;^UTILITY(U,$J,358.3,3599,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,3599,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,3600,0)
 ;;=G56.02^^18^220^89
 ;;^UTILITY(U,$J,358.3,3600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3600,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Lt Upper Limb
 ;;^UTILITY(U,$J,358.3,3600,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,3600,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,3601,0)
 ;;=G52.9^^18^220^91
 ;;^UTILITY(U,$J,358.3,3601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3601,1,3,0)
 ;;=3^Neuropathy,Cranial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3601,1,4,0)
 ;;=4^G52.9
 ;;^UTILITY(U,$J,358.3,3601,2)
 ;;=^5004005
 ;;^UTILITY(U,$J,358.3,3602,0)
 ;;=G51.9^^18^220^95
 ;;^UTILITY(U,$J,358.3,3602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3602,1,3,0)
 ;;=3^Neuropathy,Facial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3602,1,4,0)
 ;;=4^G51.9
 ;;^UTILITY(U,$J,358.3,3602,2)
 ;;=^5003998
 ;;^UTILITY(U,$J,358.3,3603,0)
 ;;=G62.0^^18^220^93
 ;;^UTILITY(U,$J,358.3,3603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3603,1,3,0)
 ;;=3^Neuropathy,Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3603,1,4,0)
 ;;=4^G62.0
 ;;^UTILITY(U,$J,358.3,3603,2)
 ;;=^5004075

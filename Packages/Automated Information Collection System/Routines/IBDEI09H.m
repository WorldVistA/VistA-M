IBDEI09H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3893,1,3,0)
 ;;=3^Neuropathy,Alcoholic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3893,1,4,0)
 ;;=4^G62.1
 ;;^UTILITY(U,$J,358.3,3893,2)
 ;;=^5004076
 ;;^UTILITY(U,$J,358.3,3894,0)
 ;;=G51.0^^28^259^88
 ;;^UTILITY(U,$J,358.3,3894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3894,1,3,0)
 ;;=3^Neuropathy,Bell's Palsy
 ;;^UTILITY(U,$J,358.3,3894,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,3894,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,3895,0)
 ;;=G56.01^^28^259^90
 ;;^UTILITY(U,$J,358.3,3895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3895,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Rt Upper Limb
 ;;^UTILITY(U,$J,358.3,3895,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,3895,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,3896,0)
 ;;=G56.02^^28^259^89
 ;;^UTILITY(U,$J,358.3,3896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3896,1,3,0)
 ;;=3^Neuropathy,Carpal Tunnel Syndrome,Lt Upper Limb
 ;;^UTILITY(U,$J,358.3,3896,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,3896,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,3897,0)
 ;;=G52.9^^28^259^91
 ;;^UTILITY(U,$J,358.3,3897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3897,1,3,0)
 ;;=3^Neuropathy,Cranial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3897,1,4,0)
 ;;=4^G52.9
 ;;^UTILITY(U,$J,358.3,3897,2)
 ;;=^5004005
 ;;^UTILITY(U,$J,358.3,3898,0)
 ;;=G51.9^^28^259^95
 ;;^UTILITY(U,$J,358.3,3898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3898,1,3,0)
 ;;=3^Neuropathy,Facial Nerve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3898,1,4,0)
 ;;=4^G51.9
 ;;^UTILITY(U,$J,358.3,3898,2)
 ;;=^5003998
 ;;^UTILITY(U,$J,358.3,3899,0)
 ;;=G62.0^^28^259^93
 ;;^UTILITY(U,$J,358.3,3899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3899,1,3,0)
 ;;=3^Neuropathy,Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3899,1,4,0)
 ;;=4^G62.0
 ;;^UTILITY(U,$J,358.3,3899,2)
 ;;=^5004075
 ;;^UTILITY(U,$J,358.3,3900,0)
 ;;=G61.0^^28^259^96
 ;;^UTILITY(U,$J,358.3,3900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3900,1,3,0)
 ;;=3^Neuropathy,Guillain-Barre Syndrome
 ;;^UTILITY(U,$J,358.3,3900,1,4,0)
 ;;=4^G61.0
 ;;^UTILITY(U,$J,358.3,3900,2)
 ;;=^53405
 ;;^UTILITY(U,$J,358.3,3901,0)
 ;;=G60.9^^28^259^97
 ;;^UTILITY(U,$J,358.3,3901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3901,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,3901,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,3901,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,3902,0)
 ;;=G61.9^^28^259^98
 ;;^UTILITY(U,$J,358.3,3902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3902,1,3,0)
 ;;=3^Neuropathy,Inflammatory Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3902,1,4,0)
 ;;=4^G61.9
 ;;^UTILITY(U,$J,358.3,3902,2)
 ;;=^5004074
 ;;^UTILITY(U,$J,358.3,3903,0)
 ;;=G58.9^^28^259^100
 ;;^UTILITY(U,$J,358.3,3903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3903,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3903,1,4,0)
 ;;=4^G58.9
 ;;^UTILITY(U,$J,358.3,3903,2)
 ;;=^5004065
 ;;^UTILITY(U,$J,358.3,3904,0)
 ;;=G54.9^^28^259^102
 ;;^UTILITY(U,$J,358.3,3904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3904,1,3,0)
 ;;=3^Neuropathy,Nerve Root/Plexus Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3904,1,4,0)
 ;;=4^G54.9
 ;;^UTILITY(U,$J,358.3,3904,2)
 ;;=^5004015
 ;;^UTILITY(U,$J,358.3,3905,0)
 ;;=G54.6^^28^259^103
 ;;^UTILITY(U,$J,358.3,3905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3905,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/ Pain
 ;;^UTILITY(U,$J,358.3,3905,1,4,0)
 ;;=4^G54.6
 ;;^UTILITY(U,$J,358.3,3905,2)
 ;;=^5004013
 ;;^UTILITY(U,$J,358.3,3906,0)
 ;;=G54.7^^28^259^104
 ;;^UTILITY(U,$J,358.3,3906,1,0)
 ;;=^358.31IA^4^2

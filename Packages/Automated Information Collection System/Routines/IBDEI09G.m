IBDEI09G ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3880,1,3,0)
 ;;=3^Involuntary Movements,Abnormal,Unspec
 ;;^UTILITY(U,$J,358.3,3880,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,3880,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,3881,0)
 ;;=G43.911^^28^259^75
 ;;^UTILITY(U,$J,358.3,3881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3881,1,3,0)
 ;;=3^Migraine,Intractable w/ Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,3881,1,4,0)
 ;;=4^G43.911
 ;;^UTILITY(U,$J,358.3,3881,2)
 ;;=^5003910
 ;;^UTILITY(U,$J,358.3,3882,0)
 ;;=G43.919^^28^259^76
 ;;^UTILITY(U,$J,358.3,3882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3882,1,3,0)
 ;;=3^Migraine,Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,3882,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,3882,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,3883,0)
 ;;=G43.901^^28^259^77
 ;;^UTILITY(U,$J,358.3,3883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3883,1,3,0)
 ;;=3^Migraine,Not Intractable w/ Status Migrainosis,Unspec
 ;;^UTILITY(U,$J,358.3,3883,1,4,0)
 ;;=4^G43.901
 ;;^UTILITY(U,$J,358.3,3883,2)
 ;;=^5003908
 ;;^UTILITY(U,$J,358.3,3884,0)
 ;;=G43.909^^28^259^78
 ;;^UTILITY(U,$J,358.3,3884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3884,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosis,Unspec
 ;;^UTILITY(U,$J,358.3,3884,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,3884,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,3885,0)
 ;;=G12.20^^28^259^79
 ;;^UTILITY(U,$J,358.3,3885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3885,1,3,0)
 ;;=3^Motor Neuron Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3885,1,4,0)
 ;;=4^G12.20
 ;;^UTILITY(U,$J,358.3,3885,2)
 ;;=^5003761
 ;;^UTILITY(U,$J,358.3,3886,0)
 ;;=G25.70^^28^259^80
 ;;^UTILITY(U,$J,358.3,3886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3886,1,3,0)
 ;;=3^Movement Disorder,Drug-Induced,Unspec
 ;;^UTILITY(U,$J,358.3,3886,1,4,0)
 ;;=4^G25.70
 ;;^UTILITY(U,$J,358.3,3886,2)
 ;;=^5003798
 ;;^UTILITY(U,$J,358.3,3887,0)
 ;;=G35.^^28^259^81
 ;;^UTILITY(U,$J,358.3,3887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3887,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,3887,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,3887,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,3888,0)
 ;;=G25.3^^28^259^82
 ;;^UTILITY(U,$J,358.3,3888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3888,1,3,0)
 ;;=3^Myoclonus
 ;;^UTILITY(U,$J,358.3,3888,1,4,0)
 ;;=4^G25.3
 ;;^UTILITY(U,$J,358.3,3888,2)
 ;;=^80620
 ;;^UTILITY(U,$J,358.3,3889,0)
 ;;=G70.9^^28^259^83
 ;;^UTILITY(U,$J,358.3,3889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3889,1,3,0)
 ;;=3^Myoneural Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3889,1,4,0)
 ;;=4^G70.9
 ;;^UTILITY(U,$J,358.3,3889,2)
 ;;=^5004087
 ;;^UTILITY(U,$J,358.3,3890,0)
 ;;=G31.9^^28^259^84
 ;;^UTILITY(U,$J,358.3,3890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3890,1,3,0)
 ;;=3^Nervous System Degenerative Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3890,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,3890,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,3891,0)
 ;;=G50.0^^28^259^86
 ;;^UTILITY(U,$J,358.3,3891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3891,1,3,0)
 ;;=3^Neuralgia,Trigeminal
 ;;^UTILITY(U,$J,358.3,3891,1,4,0)
 ;;=4^G50.0
 ;;^UTILITY(U,$J,358.3,3891,2)
 ;;=^121978
 ;;^UTILITY(U,$J,358.3,3892,0)
 ;;=G62.81^^28^259^92
 ;;^UTILITY(U,$J,358.3,3892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3892,1,3,0)
 ;;=3^Neuropathy,Critical Illness Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3892,1,4,0)
 ;;=4^G62.81
 ;;^UTILITY(U,$J,358.3,3892,2)
 ;;=^328481
 ;;^UTILITY(U,$J,358.3,3893,0)
 ;;=G62.1^^28^259^87
 ;;^UTILITY(U,$J,358.3,3893,1,0)
 ;;=^358.31IA^4^2

IBDEI09I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3906,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/o Pain
 ;;^UTILITY(U,$J,358.3,3906,1,4,0)
 ;;=4^G54.7
 ;;^UTILITY(U,$J,358.3,3906,2)
 ;;=^5004014
 ;;^UTILITY(U,$J,358.3,3907,0)
 ;;=G62.2^^28^259^105
 ;;^UTILITY(U,$J,358.3,3907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3907,1,3,0)
 ;;=3^Neuropathy,Polyneuropathy d/t Toxic Agents
 ;;^UTILITY(U,$J,358.3,3907,1,4,0)
 ;;=4^G62.2
 ;;^UTILITY(U,$J,358.3,3907,2)
 ;;=^268531
 ;;^UTILITY(U,$J,358.3,3908,0)
 ;;=G62.82^^28^259^94
 ;;^UTILITY(U,$J,358.3,3908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3908,1,3,0)
 ;;=3^Neuropathy,Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3908,1,4,0)
 ;;=4^G62.82
 ;;^UTILITY(U,$J,358.3,3908,2)
 ;;=^5004077
 ;;^UTILITY(U,$J,358.3,3909,0)
 ;;=G62.9^^28^259^106
 ;;^UTILITY(U,$J,358.3,3909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3909,1,3,0)
 ;;=3^Neuropathy,Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3909,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,3909,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,3910,0)
 ;;=G57.90^^28^259^99
 ;;^UTILITY(U,$J,358.3,3910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3910,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,3910,1,4,0)
 ;;=4^G57.90
 ;;^UTILITY(U,$J,358.3,3910,2)
 ;;=^5004061
 ;;^UTILITY(U,$J,358.3,3911,0)
 ;;=G56.90^^28^259^101
 ;;^UTILITY(U,$J,358.3,3911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3911,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Upper Limb,Unspec
 ;;^UTILITY(U,$J,358.3,3911,1,4,0)
 ;;=4^G56.90
 ;;^UTILITY(U,$J,358.3,3911,2)
 ;;=^5004035
 ;;^UTILITY(U,$J,358.3,3912,0)
 ;;=R29.5^^28^259^107
 ;;^UTILITY(U,$J,358.3,3912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3912,1,3,0)
 ;;=3^Paralysis,Transient
 ;;^UTILITY(U,$J,358.3,3912,1,4,0)
 ;;=4^R29.5
 ;;^UTILITY(U,$J,358.3,3912,2)
 ;;=^5019316
 ;;^UTILITY(U,$J,358.3,3913,0)
 ;;=G83.9^^28^259^108
 ;;^UTILITY(U,$J,358.3,3913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3913,1,3,0)
 ;;=3^Paralytic Syndrome,Unspec
 ;;^UTILITY(U,$J,358.3,3913,1,4,0)
 ;;=4^G83.9
 ;;^UTILITY(U,$J,358.3,3913,2)
 ;;=^5004151
 ;;^UTILITY(U,$J,358.3,3914,0)
 ;;=G82.20^^28^259^109
 ;;^UTILITY(U,$J,358.3,3914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3914,1,3,0)
 ;;=3^Paraplegia,Unspec
 ;;^UTILITY(U,$J,358.3,3914,1,4,0)
 ;;=4^G82.20
 ;;^UTILITY(U,$J,358.3,3914,2)
 ;;=^5004125
 ;;^UTILITY(U,$J,358.3,3915,0)
 ;;=G21.9^^28^259^111
 ;;^UTILITY(U,$J,358.3,3915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3915,1,3,0)
 ;;=3^Parkinsonism,Secondary,Unspec
 ;;^UTILITY(U,$J,358.3,3915,1,4,0)
 ;;=4^G21.9
 ;;^UTILITY(U,$J,358.3,3915,2)
 ;;=^5003778
 ;;^UTILITY(U,$J,358.3,3916,0)
 ;;=G20.^^28^259^110
 ;;^UTILITY(U,$J,358.3,3916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3916,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,3916,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,3916,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,3917,0)
 ;;=G14.^^28^259^114
 ;;^UTILITY(U,$J,358.3,3917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3917,1,3,0)
 ;;=3^Postpolio Syndrome
 ;;^UTILITY(U,$J,358.3,3917,1,4,0)
 ;;=4^G14.
 ;;^UTILITY(U,$J,358.3,3917,2)
 ;;=^5003769
 ;;^UTILITY(U,$J,358.3,3918,0)
 ;;=G45.2^^28^259^115
 ;;^UTILITY(U,$J,358.3,3918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3918,1,3,0)
 ;;=3^Precerebral Artery Syndromes,Multiple/Bilateral
 ;;^UTILITY(U,$J,358.3,3918,1,4,0)
 ;;=4^G45.2
 ;;^UTILITY(U,$J,358.3,3918,2)
 ;;=^5003957
 ;;^UTILITY(U,$J,358.3,3919,0)
 ;;=G12.22^^28^259^116
 ;;^UTILITY(U,$J,358.3,3919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3919,1,3,0)
 ;;=3^Progressive Bulbar Palsy
 ;;^UTILITY(U,$J,358.3,3919,1,4,0)
 ;;=4^G12.22

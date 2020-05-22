IBDEI31V ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48700,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,48700,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,48700,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,48701,0)
 ;;=G61.9^^185^2424^112
 ;;^UTILITY(U,$J,358.3,48701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48701,1,3,0)
 ;;=3^Neuropathy,Inflammatory Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,48701,1,4,0)
 ;;=4^G61.9
 ;;^UTILITY(U,$J,358.3,48701,2)
 ;;=^5004074
 ;;^UTILITY(U,$J,358.3,48702,0)
 ;;=G58.9^^185^2424^114
 ;;^UTILITY(U,$J,358.3,48702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48702,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,48702,1,4,0)
 ;;=4^G58.9
 ;;^UTILITY(U,$J,358.3,48702,2)
 ;;=^5004065
 ;;^UTILITY(U,$J,358.3,48703,0)
 ;;=G54.9^^185^2424^116
 ;;^UTILITY(U,$J,358.3,48703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48703,1,3,0)
 ;;=3^Neuropathy,Nerve Root/Plexus Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,48703,1,4,0)
 ;;=4^G54.9
 ;;^UTILITY(U,$J,358.3,48703,2)
 ;;=^5004015
 ;;^UTILITY(U,$J,358.3,48704,0)
 ;;=G54.6^^185^2424^117
 ;;^UTILITY(U,$J,358.3,48704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48704,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/ Pain
 ;;^UTILITY(U,$J,358.3,48704,1,4,0)
 ;;=4^G54.6
 ;;^UTILITY(U,$J,358.3,48704,2)
 ;;=^5004013
 ;;^UTILITY(U,$J,358.3,48705,0)
 ;;=G54.7^^185^2424^118
 ;;^UTILITY(U,$J,358.3,48705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48705,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/o Pain
 ;;^UTILITY(U,$J,358.3,48705,1,4,0)
 ;;=4^G54.7
 ;;^UTILITY(U,$J,358.3,48705,2)
 ;;=^5004014
 ;;^UTILITY(U,$J,358.3,48706,0)
 ;;=G62.2^^185^2424^119
 ;;^UTILITY(U,$J,358.3,48706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48706,1,3,0)
 ;;=3^Neuropathy,Polyneuropathy d/t Toxic Agents
 ;;^UTILITY(U,$J,358.3,48706,1,4,0)
 ;;=4^G62.2
 ;;^UTILITY(U,$J,358.3,48706,2)
 ;;=^268531
 ;;^UTILITY(U,$J,358.3,48707,0)
 ;;=G62.82^^185^2424^108
 ;;^UTILITY(U,$J,358.3,48707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48707,1,3,0)
 ;;=3^Neuropathy,Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,48707,1,4,0)
 ;;=4^G62.82
 ;;^UTILITY(U,$J,358.3,48707,2)
 ;;=^5004077
 ;;^UTILITY(U,$J,358.3,48708,0)
 ;;=G62.9^^185^2424^120
 ;;^UTILITY(U,$J,358.3,48708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48708,1,3,0)
 ;;=3^Neuropathy,Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,48708,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,48708,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,48709,0)
 ;;=G57.90^^185^2424^113
 ;;^UTILITY(U,$J,358.3,48709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48709,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,48709,1,4,0)
 ;;=4^G57.90
 ;;^UTILITY(U,$J,358.3,48709,2)
 ;;=^5004061
 ;;^UTILITY(U,$J,358.3,48710,0)
 ;;=G56.90^^185^2424^115
 ;;^UTILITY(U,$J,358.3,48710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48710,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Upper Limb,Unspec
 ;;^UTILITY(U,$J,358.3,48710,1,4,0)
 ;;=4^G56.90
 ;;^UTILITY(U,$J,358.3,48710,2)
 ;;=^5004035
 ;;^UTILITY(U,$J,358.3,48711,0)
 ;;=R29.5^^185^2424^121
 ;;^UTILITY(U,$J,358.3,48711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48711,1,3,0)
 ;;=3^Paralysis,Transient
 ;;^UTILITY(U,$J,358.3,48711,1,4,0)
 ;;=4^R29.5
 ;;^UTILITY(U,$J,358.3,48711,2)
 ;;=^5019316
 ;;^UTILITY(U,$J,358.3,48712,0)
 ;;=G83.9^^185^2424^122

IBDEI08C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3604,0)
 ;;=G61.0^^18^220^96
 ;;^UTILITY(U,$J,358.3,3604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3604,1,3,0)
 ;;=3^Neuropathy,Guillain-Barre Syndrome
 ;;^UTILITY(U,$J,358.3,3604,1,4,0)
 ;;=4^G61.0
 ;;^UTILITY(U,$J,358.3,3604,2)
 ;;=^53405
 ;;^UTILITY(U,$J,358.3,3605,0)
 ;;=G60.9^^18^220^97
 ;;^UTILITY(U,$J,358.3,3605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3605,1,3,0)
 ;;=3^Neuropathy,Hereditary/Idiopathic,Unspec
 ;;^UTILITY(U,$J,358.3,3605,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,3605,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,3606,0)
 ;;=G61.9^^18^220^98
 ;;^UTILITY(U,$J,358.3,3606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3606,1,3,0)
 ;;=3^Neuropathy,Inflammatory Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3606,1,4,0)
 ;;=4^G61.9
 ;;^UTILITY(U,$J,358.3,3606,2)
 ;;=^5004074
 ;;^UTILITY(U,$J,358.3,3607,0)
 ;;=G58.9^^18^220^100
 ;;^UTILITY(U,$J,358.3,3607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3607,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3607,1,4,0)
 ;;=4^G58.9
 ;;^UTILITY(U,$J,358.3,3607,2)
 ;;=^5004065
 ;;^UTILITY(U,$J,358.3,3608,0)
 ;;=G54.9^^18^220^102
 ;;^UTILITY(U,$J,358.3,3608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3608,1,3,0)
 ;;=3^Neuropathy,Nerve Root/Plexus Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3608,1,4,0)
 ;;=4^G54.9
 ;;^UTILITY(U,$J,358.3,3608,2)
 ;;=^5004015
 ;;^UTILITY(U,$J,358.3,3609,0)
 ;;=G54.6^^18^220^103
 ;;^UTILITY(U,$J,358.3,3609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3609,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/ Pain
 ;;^UTILITY(U,$J,358.3,3609,1,4,0)
 ;;=4^G54.6
 ;;^UTILITY(U,$J,358.3,3609,2)
 ;;=^5004013
 ;;^UTILITY(U,$J,358.3,3610,0)
 ;;=G54.7^^18^220^104
 ;;^UTILITY(U,$J,358.3,3610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3610,1,3,0)
 ;;=3^Neuropathy,Phantom Limb Syndrome w/o Pain
 ;;^UTILITY(U,$J,358.3,3610,1,4,0)
 ;;=4^G54.7
 ;;^UTILITY(U,$J,358.3,3610,2)
 ;;=^5004014
 ;;^UTILITY(U,$J,358.3,3611,0)
 ;;=G62.2^^18^220^105
 ;;^UTILITY(U,$J,358.3,3611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3611,1,3,0)
 ;;=3^Neuropathy,Polyneuropathy d/t Toxic Agents
 ;;^UTILITY(U,$J,358.3,3611,1,4,0)
 ;;=4^G62.2
 ;;^UTILITY(U,$J,358.3,3611,2)
 ;;=^268531
 ;;^UTILITY(U,$J,358.3,3612,0)
 ;;=G62.82^^18^220^94
 ;;^UTILITY(U,$J,358.3,3612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3612,1,3,0)
 ;;=3^Neuropathy,Drug-Induced Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3612,1,4,0)
 ;;=4^G62.82
 ;;^UTILITY(U,$J,358.3,3612,2)
 ;;=^5004077
 ;;^UTILITY(U,$J,358.3,3613,0)
 ;;=G62.9^^18^220^106
 ;;^UTILITY(U,$J,358.3,3613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3613,1,3,0)
 ;;=3^Neuropathy,Polyneuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3613,1,4,0)
 ;;=4^G62.9
 ;;^UTILITY(U,$J,358.3,3613,2)
 ;;=^5004079
 ;;^UTILITY(U,$J,358.3,3614,0)
 ;;=G57.90^^18^220^99
 ;;^UTILITY(U,$J,358.3,3614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3614,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,3614,1,4,0)
 ;;=4^G57.90
 ;;^UTILITY(U,$J,358.3,3614,2)
 ;;=^5004061
 ;;^UTILITY(U,$J,358.3,3615,0)
 ;;=G56.90^^18^220^101
 ;;^UTILITY(U,$J,358.3,3615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3615,1,3,0)
 ;;=3^Neuropathy,Mononeuropathy,Upper Limb,Unspec
 ;;^UTILITY(U,$J,358.3,3615,1,4,0)
 ;;=4^G56.90
 ;;^UTILITY(U,$J,358.3,3615,2)
 ;;=^5004035
 ;;^UTILITY(U,$J,358.3,3616,0)
 ;;=R29.5^^18^220^107
 ;;^UTILITY(U,$J,358.3,3616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3616,1,3,0)
 ;;=3^Paralysis,Transient
 ;;^UTILITY(U,$J,358.3,3616,1,4,0)
 ;;=4^R29.5
 ;;^UTILITY(U,$J,358.3,3616,2)
 ;;=^5019316

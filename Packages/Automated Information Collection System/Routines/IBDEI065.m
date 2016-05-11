IBDEI065 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2544,1,3,0)
 ;;=3^99379
 ;;^UTILITY(U,$J,358.3,2545,0)
 ;;=99380^^17^202^2^^^^1
 ;;^UTILITY(U,$J,358.3,2545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2545,1,2,0)
 ;;=2^Phys Nurs Fac Spvn,Comp w/o Pt > 29 min
 ;;^UTILITY(U,$J,358.3,2545,1,3,0)
 ;;=3^99380
 ;;^UTILITY(U,$J,358.3,2546,0)
 ;;=99497^^17^203^1^^^^1
 ;;^UTILITY(U,$J,358.3,2546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2546,1,2,0)
 ;;=2^Advance Care Planning;First 30 min
 ;;^UTILITY(U,$J,358.3,2546,1,3,0)
 ;;=3^99497
 ;;^UTILITY(U,$J,358.3,2547,0)
 ;;=99498^^17^203^2^^^^1
 ;;^UTILITY(U,$J,358.3,2547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2547,1,2,0)
 ;;=2^Advance Care Planning;Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,2547,1,3,0)
 ;;=3^99498
 ;;^UTILITY(U,$J,358.3,2548,0)
 ;;=G30.9^^18^204^4
 ;;^UTILITY(U,$J,358.3,2548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2548,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2548,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,2548,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,2549,0)
 ;;=G30.0^^18^204^2
 ;;^UTILITY(U,$J,358.3,2549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2549,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,2549,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,2549,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,2550,0)
 ;;=G30.1^^18^204^3
 ;;^UTILITY(U,$J,358.3,2550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2550,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,2550,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,2550,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,2551,0)
 ;;=F05.^^18^204^16
 ;;^UTILITY(U,$J,358.3,2551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2551,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2551,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,2551,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,2552,0)
 ;;=F02.81^^18^204^17
 ;;^UTILITY(U,$J,358.3,2552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2552,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2552,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,2552,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,2553,0)
 ;;=F02.80^^18^204^20
 ;;^UTILITY(U,$J,358.3,2553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2553,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2553,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,2553,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,2554,0)
 ;;=F04.^^18^204^5
 ;;^UTILITY(U,$J,358.3,2554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2554,1,3,0)
 ;;=3^Amnestic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2554,1,4,0)
 ;;=4^F04.
 ;;^UTILITY(U,$J,358.3,2554,2)
 ;;=^5003051
 ;;^UTILITY(U,$J,358.3,2555,0)
 ;;=R41.81^^18^204^7
 ;;^UTILITY(U,$J,358.3,2555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2555,1,3,0)
 ;;=3^Cognitive Decline,Age-Related
 ;;^UTILITY(U,$J,358.3,2555,1,4,0)
 ;;=4^R41.81
 ;;^UTILITY(U,$J,358.3,2555,2)
 ;;=^5019440
 ;;^UTILITY(U,$J,358.3,2556,0)
 ;;=R41.82^^18^204^8
 ;;^UTILITY(U,$J,358.3,2556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2556,1,3,0)
 ;;=3^Cognitive Decline,Altered Mental Status
 ;;^UTILITY(U,$J,358.3,2556,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,2556,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,2557,0)
 ;;=R41.841^^18^204^9
 ;;^UTILITY(U,$J,358.3,2557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2557,1,3,0)
 ;;=3^Cognitive Decline,Communication Deficit
 ;;^UTILITY(U,$J,358.3,2557,1,4,0)
 ;;=4^R41.841
 ;;^UTILITY(U,$J,358.3,2557,2)
 ;;=^5019444
 ;;^UTILITY(U,$J,358.3,2558,0)
 ;;=R41.0^^18^204^10
 ;;^UTILITY(U,$J,358.3,2558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2558,1,3,0)
 ;;=3^Cognitive Decline,Disorientation,Unspec

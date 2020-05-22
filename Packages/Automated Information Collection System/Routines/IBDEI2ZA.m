IBDEI2ZA ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47559,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,47559,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,47560,0)
 ;;=G30.1^^185^2408^3
 ;;^UTILITY(U,$J,358.3,47560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47560,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,47560,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,47560,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,47561,0)
 ;;=F05.^^185^2408^16
 ;;^UTILITY(U,$J,358.3,47561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47561,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,47561,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,47561,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,47562,0)
 ;;=F02.81^^185^2408^17
 ;;^UTILITY(U,$J,358.3,47562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47562,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,47562,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,47562,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,47563,0)
 ;;=F02.80^^185^2408^20
 ;;^UTILITY(U,$J,358.3,47563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47563,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,47563,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,47563,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,47564,0)
 ;;=F04.^^185^2408^5
 ;;^UTILITY(U,$J,358.3,47564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47564,1,3,0)
 ;;=3^Amnestic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,47564,1,4,0)
 ;;=4^F04.
 ;;^UTILITY(U,$J,358.3,47564,2)
 ;;=^5003051
 ;;^UTILITY(U,$J,358.3,47565,0)
 ;;=R41.81^^185^2408^7
 ;;^UTILITY(U,$J,358.3,47565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47565,1,3,0)
 ;;=3^Cognitive Decline,Age-Related
 ;;^UTILITY(U,$J,358.3,47565,1,4,0)
 ;;=4^R41.81
 ;;^UTILITY(U,$J,358.3,47565,2)
 ;;=^5019440
 ;;^UTILITY(U,$J,358.3,47566,0)
 ;;=R41.82^^185^2408^8
 ;;^UTILITY(U,$J,358.3,47566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47566,1,3,0)
 ;;=3^Cognitive Decline,Altered Mental Status
 ;;^UTILITY(U,$J,358.3,47566,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,47566,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,47567,0)
 ;;=R41.841^^185^2408^9
 ;;^UTILITY(U,$J,358.3,47567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47567,1,3,0)
 ;;=3^Cognitive Decline,Communication Deficit
 ;;^UTILITY(U,$J,358.3,47567,1,4,0)
 ;;=4^R41.841
 ;;^UTILITY(U,$J,358.3,47567,2)
 ;;=^5019444
 ;;^UTILITY(U,$J,358.3,47568,0)
 ;;=R41.0^^185^2408^10
 ;;^UTILITY(U,$J,358.3,47568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47568,1,3,0)
 ;;=3^Cognitive Decline,Disorientation,Unspec
 ;;^UTILITY(U,$J,358.3,47568,1,4,0)
 ;;=4^R41.0
 ;;^UTILITY(U,$J,358.3,47568,2)
 ;;=^5019436
 ;;^UTILITY(U,$J,358.3,47569,0)
 ;;=R41.844^^185^2408^11
 ;;^UTILITY(U,$J,358.3,47569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47569,1,3,0)
 ;;=3^Cognitive Decline,Frontal Lobe/Executive Function Deficit
 ;;^UTILITY(U,$J,358.3,47569,1,4,0)
 ;;=4^R41.844
 ;;^UTILITY(U,$J,358.3,47569,2)
 ;;=^5019447
 ;;^UTILITY(U,$J,358.3,47570,0)
 ;;=R41.843^^185^2408^12
 ;;^UTILITY(U,$J,358.3,47570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47570,1,3,0)
 ;;=3^Cognitive Decline,Psychomotor Deficit
 ;;^UTILITY(U,$J,358.3,47570,1,4,0)
 ;;=4^R41.843
 ;;^UTILITY(U,$J,358.3,47570,2)
 ;;=^5019446
 ;;^UTILITY(U,$J,358.3,47571,0)
 ;;=R41.9^^185^2408^13
 ;;^UTILITY(U,$J,358.3,47571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47571,1,3,0)
 ;;=3^Cognitive Decline,Unspec

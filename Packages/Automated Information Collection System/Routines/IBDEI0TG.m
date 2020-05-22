IBDEI0TG ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13111,1,3,0)
 ;;=3^36415
 ;;^UTILITY(U,$J,358.3,13112,0)
 ;;=G30.9^^83^806^4
 ;;^UTILITY(U,$J,358.3,13112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13112,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13112,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,13112,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,13113,0)
 ;;=G30.0^^83^806^2
 ;;^UTILITY(U,$J,358.3,13113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13113,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,13113,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,13113,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,13114,0)
 ;;=G30.1^^83^806^3
 ;;^UTILITY(U,$J,358.3,13114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13114,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,13114,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,13114,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,13115,0)
 ;;=F05.^^83^806^16
 ;;^UTILITY(U,$J,358.3,13115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13115,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,13115,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,13115,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,13116,0)
 ;;=F02.81^^83^806^17
 ;;^UTILITY(U,$J,358.3,13116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13116,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,13116,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,13116,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,13117,0)
 ;;=F02.80^^83^806^20
 ;;^UTILITY(U,$J,358.3,13117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13117,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,13117,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,13117,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,13118,0)
 ;;=F04.^^83^806^5
 ;;^UTILITY(U,$J,358.3,13118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13118,1,3,0)
 ;;=3^Amnestic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,13118,1,4,0)
 ;;=4^F04.
 ;;^UTILITY(U,$J,358.3,13118,2)
 ;;=^5003051
 ;;^UTILITY(U,$J,358.3,13119,0)
 ;;=R41.81^^83^806^7
 ;;^UTILITY(U,$J,358.3,13119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13119,1,3,0)
 ;;=3^Cognitive Decline,Age-Related
 ;;^UTILITY(U,$J,358.3,13119,1,4,0)
 ;;=4^R41.81
 ;;^UTILITY(U,$J,358.3,13119,2)
 ;;=^5019440
 ;;^UTILITY(U,$J,358.3,13120,0)
 ;;=R41.82^^83^806^8
 ;;^UTILITY(U,$J,358.3,13120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13120,1,3,0)
 ;;=3^Cognitive Decline,Altered Mental Status
 ;;^UTILITY(U,$J,358.3,13120,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,13120,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,13121,0)
 ;;=R41.841^^83^806^9
 ;;^UTILITY(U,$J,358.3,13121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13121,1,3,0)
 ;;=3^Cognitive Decline,Communication Deficit
 ;;^UTILITY(U,$J,358.3,13121,1,4,0)
 ;;=4^R41.841
 ;;^UTILITY(U,$J,358.3,13121,2)
 ;;=^5019444
 ;;^UTILITY(U,$J,358.3,13122,0)
 ;;=R41.0^^83^806^10
 ;;^UTILITY(U,$J,358.3,13122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13122,1,3,0)
 ;;=3^Cognitive Decline,Disorientation,Unspec
 ;;^UTILITY(U,$J,358.3,13122,1,4,0)
 ;;=4^R41.0
 ;;^UTILITY(U,$J,358.3,13122,2)
 ;;=^5019436
 ;;^UTILITY(U,$J,358.3,13123,0)
 ;;=R41.844^^83^806^11
 ;;^UTILITY(U,$J,358.3,13123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13123,1,3,0)
 ;;=3^Cognitive Decline,Frontal Lobe/Executive Function Deficit
 ;;^UTILITY(U,$J,358.3,13123,1,4,0)
 ;;=4^R41.844
 ;;^UTILITY(U,$J,358.3,13123,2)
 ;;=^5019447

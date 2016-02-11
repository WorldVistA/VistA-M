IBDEI0ER ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6450,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturb in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6450,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,6450,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,6451,0)
 ;;=F02.80^^43^399^3
 ;;^UTILITY(U,$J,358.3,6451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6451,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturb in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6451,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,6451,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,6452,0)
 ;;=F05.^^43^400^1
 ;;^UTILITY(U,$J,358.3,6452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6452,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,6452,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,6452,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,6453,0)
 ;;=I60.9^^43^401^21
 ;;^UTILITY(U,$J,358.3,6453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6453,1,3,0)
 ;;=3^Nontraumatic Subarachnoid Hemorrhage w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6453,1,4,0)
 ;;=4^I60.9
 ;;^UTILITY(U,$J,358.3,6453,2)
 ;;=^5007279^F01.51
 ;;^UTILITY(U,$J,358.3,6454,0)
 ;;=I60.9^^43^401^22
 ;;^UTILITY(U,$J,358.3,6454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6454,1,3,0)
 ;;=3^Nontraumatic Subarachnoid Hemorrhage w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6454,1,4,0)
 ;;=4^I60.9
 ;;^UTILITY(U,$J,358.3,6454,2)
 ;;=^5007279^F01.50
 ;;^UTILITY(U,$J,358.3,6455,0)
 ;;=I61.9^^43^401^17
 ;;^UTILITY(U,$J,358.3,6455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6455,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6455,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,6455,2)
 ;;=^5007288^F01.50
 ;;^UTILITY(U,$J,358.3,6456,0)
 ;;=I61.9^^43^401^18
 ;;^UTILITY(U,$J,358.3,6456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6456,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6456,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,6456,2)
 ;;=^5007288^F01.51
 ;;^UTILITY(U,$J,358.3,6457,0)
 ;;=I62.1^^43^401^16
 ;;^UTILITY(U,$J,358.3,6457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6457,1,3,0)
 ;;=3^Nontraumatic Extradural Hemorrhage w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6457,1,4,0)
 ;;=4^I62.1
 ;;^UTILITY(U,$J,358.3,6457,2)
 ;;=^269743^F01.50
 ;;^UTILITY(U,$J,358.3,6458,0)
 ;;=I62.1^^43^401^15
 ;;^UTILITY(U,$J,358.3,6458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6458,1,3,0)
 ;;=3^Nontraumatic Extradural Hemorrhage w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6458,1,4,0)
 ;;=4^I62.1
 ;;^UTILITY(U,$J,358.3,6458,2)
 ;;=^269743^F01.51
 ;;^UTILITY(U,$J,358.3,6459,0)
 ;;=I62.9^^43^401^19
 ;;^UTILITY(U,$J,358.3,6459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6459,1,3,0)
 ;;=3^Nontraumatic Intracranial Hemorrhage w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6459,1,4,0)
 ;;=4^I62.9
 ;;^UTILITY(U,$J,358.3,6459,2)
 ;;=^5007293^F01.50
 ;;^UTILITY(U,$J,358.3,6460,0)
 ;;=I62.9^^43^401^20
 ;;^UTILITY(U,$J,358.3,6460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6460,1,3,0)
 ;;=3^Nontraumatic Intracranial Hemorrhage w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6460,1,4,0)
 ;;=4^I62.9
 ;;^UTILITY(U,$J,358.3,6460,2)
 ;;=^5007293^F01.51
 ;;^UTILITY(U,$J,358.3,6461,0)
 ;;=I63.9^^43^401^6
 ;;^UTILITY(U,$J,358.3,6461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6461,1,3,0)
 ;;=3^Cerebral Infarction w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6461,1,4,0)
 ;;=4^I63.9
 ;;^UTILITY(U,$J,358.3,6461,2)
 ;;=^5007355^F01.50

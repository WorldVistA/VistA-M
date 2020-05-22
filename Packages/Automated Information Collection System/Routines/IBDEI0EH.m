IBDEI0EH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6226,1,3,0)
 ;;=3^Cardiac Arrest,Cause Unspec
 ;;^UTILITY(U,$J,358.3,6226,1,4,0)
 ;;=4^I46.9
 ;;^UTILITY(U,$J,358.3,6226,2)
 ;;=^5007221
 ;;^UTILITY(U,$J,358.3,6227,0)
 ;;=I46.8^^53^404^19
 ;;^UTILITY(U,$J,358.3,6227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6227,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Condition
 ;;^UTILITY(U,$J,358.3,6227,1,4,0)
 ;;=4^I46.8
 ;;^UTILITY(U,$J,358.3,6227,2)
 ;;=^5007220
 ;;^UTILITY(U,$J,358.3,6228,0)
 ;;=I46.2^^53^404^18
 ;;^UTILITY(U,$J,358.3,6228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6228,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Cardiac Condition
 ;;^UTILITY(U,$J,358.3,6228,1,4,0)
 ;;=4^I46.2
 ;;^UTILITY(U,$J,358.3,6228,2)
 ;;=^5007219
 ;;^UTILITY(U,$J,358.3,6229,0)
 ;;=I49.40^^53^404^40
 ;;^UTILITY(U,$J,358.3,6229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6229,1,3,0)
 ;;=3^Premature Depolarization,Unspec
 ;;^UTILITY(U,$J,358.3,6229,1,4,0)
 ;;=4^I49.40
 ;;^UTILITY(U,$J,358.3,6229,2)
 ;;=^5007234
 ;;^UTILITY(U,$J,358.3,6230,0)
 ;;=I49.1^^53^404^13
 ;;^UTILITY(U,$J,358.3,6230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6230,1,3,0)
 ;;=3^Atrial Premature Depolarization
 ;;^UTILITY(U,$J,358.3,6230,1,4,0)
 ;;=4^I49.1
 ;;^UTILITY(U,$J,358.3,6230,2)
 ;;=^5007231
 ;;^UTILITY(U,$J,358.3,6231,0)
 ;;=I49.49^^53^404^39
 ;;^UTILITY(U,$J,358.3,6231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6231,1,3,0)
 ;;=3^Premature Depolarization NEC
 ;;^UTILITY(U,$J,358.3,6231,1,4,0)
 ;;=4^I49.49
 ;;^UTILITY(U,$J,358.3,6231,2)
 ;;=^5007235
 ;;^UTILITY(U,$J,358.3,6232,0)
 ;;=I49.5^^53^404^47
 ;;^UTILITY(U,$J,358.3,6232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6232,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,6232,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,6232,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,6233,0)
 ;;=R00.1^^53^404^15
 ;;^UTILITY(U,$J,358.3,6233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6233,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,6233,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,6233,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,6234,0)
 ;;=T82.110A^^53^404^16
 ;;^UTILITY(U,$J,358.3,6234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6234,1,3,0)
 ;;=3^Breakdown of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,6234,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,6234,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,6235,0)
 ;;=T82.111A^^53^404^17
 ;;^UTILITY(U,$J,358.3,6235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6235,1,3,0)
 ;;=3^Breakdown of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,6235,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,6235,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,6236,0)
 ;;=T82.120A^^53^404^25
 ;;^UTILITY(U,$J,358.3,6236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6236,1,3,0)
 ;;=3^Displacement of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,6236,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,6236,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,6237,0)
 ;;=T82.121A^^53^404^26
 ;;^UTILITY(U,$J,358.3,6237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6237,1,3,0)
 ;;=3^Displacement of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,6237,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,6237,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,6238,0)
 ;;=T82.190A^^53^404^34
 ;;^UTILITY(U,$J,358.3,6238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6238,1,3,0)
 ;;=3^Mech Compl of Cardiac Electrode,Init Encntr

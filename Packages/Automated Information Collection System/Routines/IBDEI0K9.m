IBDEI0K9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9148,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9148,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,9148,1,2,0)
 ;;=2^99253
 ;;^UTILITY(U,$J,358.3,9149,0)
 ;;=99254^^56^568^4
 ;;^UTILITY(U,$J,358.3,9149,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9149,1,1,0)
 ;;=1^Comprehensive, Mod
 ;;^UTILITY(U,$J,358.3,9149,1,2,0)
 ;;=2^99254
 ;;^UTILITY(U,$J,358.3,9150,0)
 ;;=99255^^56^568^5
 ;;^UTILITY(U,$J,358.3,9150,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9150,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,9150,1,2,0)
 ;;=2^99255
 ;;^UTILITY(U,$J,358.3,9151,0)
 ;;=99234^^56^569^1
 ;;^UTILITY(U,$J,358.3,9151,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9151,1,1,0)
 ;;=1^Admit/Discharge,Low
 ;;^UTILITY(U,$J,358.3,9151,1,2,0)
 ;;=2^99234
 ;;^UTILITY(U,$J,358.3,9152,0)
 ;;=99235^^56^569^2
 ;;^UTILITY(U,$J,358.3,9152,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9152,1,1,0)
 ;;=1^Admit/Discharge,Mod
 ;;^UTILITY(U,$J,358.3,9152,1,2,0)
 ;;=2^99235
 ;;^UTILITY(U,$J,358.3,9153,0)
 ;;=99236^^56^569^3
 ;;^UTILITY(U,$J,358.3,9153,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9153,1,1,0)
 ;;=1^Admit/Discharge,High
 ;;^UTILITY(U,$J,358.3,9153,1,2,0)
 ;;=2^99236
 ;;^UTILITY(U,$J,358.3,9154,0)
 ;;=99238^^56^570^1
 ;;^UTILITY(U,$J,358.3,9154,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9154,1,1,0)
 ;;=1^Discharge Day,30 min
 ;;^UTILITY(U,$J,358.3,9154,1,2,0)
 ;;=2^99238
 ;;^UTILITY(U,$J,358.3,9155,0)
 ;;=99239^^56^570^2
 ;;^UTILITY(U,$J,358.3,9155,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9155,1,1,0)
 ;;=1^Discharge Day,> 30 min
 ;;^UTILITY(U,$J,358.3,9155,1,2,0)
 ;;=2^99239
 ;;^UTILITY(U,$J,358.3,9156,0)
 ;;=95974^^57^571^1^^^^1
 ;;^UTILITY(U,$J,358.3,9156,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9156,1,2,0)
 ;;=2^VNS Analysis/Program,1st Hr
 ;;^UTILITY(U,$J,358.3,9156,1,3,0)
 ;;=3^95974
 ;;^UTILITY(U,$J,358.3,9157,0)
 ;;=95975^^57^571^2^^^^1
 ;;^UTILITY(U,$J,358.3,9157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9157,1,2,0)
 ;;=2^VNS Analysis/Program,Ea Add 30min
 ;;^UTILITY(U,$J,358.3,9157,1,3,0)
 ;;=3^95975
 ;;^UTILITY(U,$J,358.3,9158,0)
 ;;=G40.A01^^58^572^3
 ;;^UTILITY(U,$J,358.3,9158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9158,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9158,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,9158,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,9159,0)
 ;;=G40.A09^^58^572^4
 ;;^UTILITY(U,$J,358.3,9159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9159,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9159,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,9159,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,9160,0)
 ;;=G40.A11^^58^572^1
 ;;^UTILITY(U,$J,358.3,9160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9160,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9160,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,9160,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,9161,0)
 ;;=G40.A19^^58^572^2
 ;;^UTILITY(U,$J,358.3,9161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9161,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9161,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,9161,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,9162,0)
 ;;=G40.309^^58^572^16
 ;;^UTILITY(U,$J,358.3,9162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9162,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9162,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,9162,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,9163,0)
 ;;=G40.311^^58^572^14

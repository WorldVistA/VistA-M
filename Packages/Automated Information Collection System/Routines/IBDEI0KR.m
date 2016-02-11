IBDEI0KR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9392,1,2,0)
 ;;=2^EEG,Over 1 Hour
 ;;^UTILITY(U,$J,358.3,9392,1,3,0)
 ;;=3^95813
 ;;^UTILITY(U,$J,358.3,9393,0)
 ;;=95816^^62^601^3^^^^1
 ;;^UTILITY(U,$J,358.3,9393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9393,1,2,0)
 ;;=2^EEG,Awake and Drowsy
 ;;^UTILITY(U,$J,358.3,9393,1,3,0)
 ;;=3^95816
 ;;^UTILITY(U,$J,358.3,9394,0)
 ;;=95819^^62^601^4^^^^1
 ;;^UTILITY(U,$J,358.3,9394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9394,1,2,0)
 ;;=2^EEG,Awake and Asleep
 ;;^UTILITY(U,$J,358.3,9394,1,3,0)
 ;;=3^95819
 ;;^UTILITY(U,$J,358.3,9395,0)
 ;;=95822^^62^601^5^^^^1
 ;;^UTILITY(U,$J,358.3,9395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9395,1,2,0)
 ;;=2^EEG,Sleep or Coma Only
 ;;^UTILITY(U,$J,358.3,9395,1,3,0)
 ;;=3^95822
 ;;^UTILITY(U,$J,358.3,9396,0)
 ;;=3650F^^62^601^6^^^^1
 ;;^UTILITY(U,$J,358.3,9396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9396,1,2,0)
 ;;=2^EEG Store and Forward
 ;;^UTILITY(U,$J,358.3,9396,1,3,0)
 ;;=3^3650F
 ;;^UTILITY(U,$J,358.3,9397,0)
 ;;=95926^^62^602^4^^^^1
 ;;^UTILITY(U,$J,358.3,9397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9397,1,2,0)
 ;;=2^Short Latency SSEP,Periph Nerve,Lower
 ;;^UTILITY(U,$J,358.3,9397,1,3,0)
 ;;=3^95926
 ;;^UTILITY(U,$J,358.3,9398,0)
 ;;=95925^^62^602^5^^^^1
 ;;^UTILITY(U,$J,358.3,9398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9398,1,2,0)
 ;;=2^Short Latency SSEP,Periph Nerve,Upper
 ;;^UTILITY(U,$J,358.3,9398,1,3,0)
 ;;=3^95925
 ;;^UTILITY(U,$J,358.3,9399,0)
 ;;=95938^^62^602^6^^^^1
 ;;^UTILITY(U,$J,358.3,9399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9399,1,2,0)
 ;;=2^Short Latency SSEP,Periph Nerve,Uppr&Lwr
 ;;^UTILITY(U,$J,358.3,9399,1,3,0)
 ;;=3^95938
 ;;^UTILITY(U,$J,358.3,9400,0)
 ;;=95928^^62^602^2^^^^1
 ;;^UTILITY(U,$J,358.3,9400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9400,1,2,0)
 ;;=2^C Motor Evoked Upper Limbs
 ;;^UTILITY(U,$J,358.3,9400,1,3,0)
 ;;=3^95928
 ;;^UTILITY(U,$J,358.3,9401,0)
 ;;=95929^^62^602^1^^^^1
 ;;^UTILITY(U,$J,358.3,9401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9401,1,2,0)
 ;;=2^C Motor Evoked Lower Limbs
 ;;^UTILITY(U,$J,358.3,9401,1,3,0)
 ;;=3^95929
 ;;^UTILITY(U,$J,358.3,9402,0)
 ;;=95939^^62^602^3^^^^1
 ;;^UTILITY(U,$J,358.3,9402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9402,1,2,0)
 ;;=2^C Motor Evoked Uppr&Lwr Limbs
 ;;^UTILITY(U,$J,358.3,9402,1,3,0)
 ;;=3^95939
 ;;^UTILITY(U,$J,358.3,9403,0)
 ;;=95974^^62^603^1^^^^1
 ;;^UTILITY(U,$J,358.3,9403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9403,1,2,0)
 ;;=2^VNS Analysis/Program,1st Hr
 ;;^UTILITY(U,$J,358.3,9403,1,3,0)
 ;;=3^95974
 ;;^UTILITY(U,$J,358.3,9404,0)
 ;;=95975^^62^603^2^^^^1
 ;;^UTILITY(U,$J,358.3,9404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9404,1,2,0)
 ;;=2^VNS Analysis/Program,Ea Add 30min
 ;;^UTILITY(U,$J,358.3,9404,1,3,0)
 ;;=3^95975
 ;;^UTILITY(U,$J,358.3,9405,0)
 ;;=G40.A01^^63^604^3
 ;;^UTILITY(U,$J,358.3,9405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9405,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9405,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,9405,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,9406,0)
 ;;=G40.A09^^63^604^4
 ;;^UTILITY(U,$J,358.3,9406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9406,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,9406,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,9406,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,9407,0)
 ;;=G40.A11^^63^604^1
 ;;^UTILITY(U,$J,358.3,9407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9407,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus

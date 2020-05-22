IBDEI1BT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21191,0)
 ;;=F45.0^^95^1052^14
 ;;^UTILITY(U,$J,358.3,21191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21191,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,21191,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,21191,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,21192,0)
 ;;=F45.9^^95^1052^15
 ;;^UTILITY(U,$J,358.3,21192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21192,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21192,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,21192,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,21193,0)
 ;;=F45.1^^95^1052^13
 ;;^UTILITY(U,$J,358.3,21193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21193,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,21193,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,21193,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,21194,0)
 ;;=F44.4^^95^1052^2
 ;;^UTILITY(U,$J,358.3,21194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21194,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,21194,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,21194,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,21195,0)
 ;;=F44.6^^95^1052^3
 ;;^UTILITY(U,$J,358.3,21195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21195,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,21195,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,21195,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,21196,0)
 ;;=F44.5^^95^1052^4
 ;;^UTILITY(U,$J,358.3,21196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21196,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,21196,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,21196,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,21197,0)
 ;;=F44.7^^95^1052^5
 ;;^UTILITY(U,$J,358.3,21197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21197,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,21197,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,21197,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,21198,0)
 ;;=F68.10^^95^1052^10
 ;;^UTILITY(U,$J,358.3,21198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21198,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,21198,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,21198,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,21199,0)
 ;;=F54.^^95^1052^12
 ;;^UTILITY(U,$J,358.3,21199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21199,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,21199,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,21199,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,21200,0)
 ;;=F44.6^^95^1052^6
 ;;^UTILITY(U,$J,358.3,21200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21200,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,21200,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,21200,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,21201,0)
 ;;=F44.4^^95^1052^7
 ;;^UTILITY(U,$J,358.3,21201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21201,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,21201,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,21201,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,21202,0)
 ;;=F44.4^^95^1052^8
 ;;^UTILITY(U,$J,358.3,21202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21202,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,21202,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,21202,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,21203,0)
 ;;=F44.4^^95^1052^9

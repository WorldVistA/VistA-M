IBDEI0OJ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11024,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,11024,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,11025,0)
 ;;=F45.9^^42^500^15
 ;;^UTILITY(U,$J,358.3,11025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11025,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11025,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,11025,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,11026,0)
 ;;=F45.1^^42^500^13
 ;;^UTILITY(U,$J,358.3,11026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11026,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,11026,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,11026,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,11027,0)
 ;;=F44.4^^42^500^2
 ;;^UTILITY(U,$J,358.3,11027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11027,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,11027,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,11027,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,11028,0)
 ;;=F44.6^^42^500^3
 ;;^UTILITY(U,$J,358.3,11028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11028,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,11028,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,11028,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,11029,0)
 ;;=F44.5^^42^500^4
 ;;^UTILITY(U,$J,358.3,11029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11029,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,11029,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,11029,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,11030,0)
 ;;=F44.7^^42^500^5
 ;;^UTILITY(U,$J,358.3,11030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11030,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,11030,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,11030,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,11031,0)
 ;;=F68.10^^42^500^10
 ;;^UTILITY(U,$J,358.3,11031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11031,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,11031,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,11031,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,11032,0)
 ;;=F54.^^42^500^12
 ;;^UTILITY(U,$J,358.3,11032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11032,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,11032,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,11032,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,11033,0)
 ;;=F44.6^^42^500^6
 ;;^UTILITY(U,$J,358.3,11033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11033,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,11033,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,11033,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,11034,0)
 ;;=F44.4^^42^500^7
 ;;^UTILITY(U,$J,358.3,11034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11034,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,11034,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,11034,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,11035,0)
 ;;=F44.4^^42^500^8
 ;;^UTILITY(U,$J,358.3,11035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11035,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,11035,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,11035,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,11036,0)
 ;;=F44.4^^42^500^9
 ;;^UTILITY(U,$J,358.3,11036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11036,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,11036,1,4,0)
 ;;=4^F44.4

IBDEI1U8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31204,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,31205,0)
 ;;=F45.41^^123^1568^10
 ;;^UTILITY(U,$J,358.3,31205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31205,1,3,0)
 ;;=3^Pain Disorder Exclusively Related to Psychological Factors
 ;;^UTILITY(U,$J,358.3,31205,1,4,0)
 ;;=4^F45.41
 ;;^UTILITY(U,$J,358.3,31205,2)
 ;;=^5003590
 ;;^UTILITY(U,$J,358.3,31206,0)
 ;;=F45.42^^123^1568^11
 ;;^UTILITY(U,$J,358.3,31206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31206,1,3,0)
 ;;=3^Pain Disorder w/ Related Psychological Factors
 ;;^UTILITY(U,$J,358.3,31206,1,4,0)
 ;;=4^F45.42
 ;;^UTILITY(U,$J,358.3,31206,2)
 ;;=^5003591
 ;;^UTILITY(U,$J,358.3,31207,0)
 ;;=F45.0^^123^1568^13
 ;;^UTILITY(U,$J,358.3,31207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31207,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,31207,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,31207,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,31208,0)
 ;;=F45.9^^123^1568^14
 ;;^UTILITY(U,$J,358.3,31208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31208,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31208,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,31208,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,31209,0)
 ;;=F45.1^^123^1568^16
 ;;^UTILITY(U,$J,358.3,31209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31209,1,3,0)
 ;;=3^Undifferntiated Somatoform Disorder
 ;;^UTILITY(U,$J,358.3,31209,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,31209,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,31210,0)
 ;;=F44.4^^123^1568^2
 ;;^UTILITY(U,$J,358.3,31210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31210,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,31210,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,31210,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,31211,0)
 ;;=F44.6^^123^1568^3
 ;;^UTILITY(U,$J,358.3,31211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31211,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,31211,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,31211,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,31212,0)
 ;;=F44.5^^123^1568^4
 ;;^UTILITY(U,$J,358.3,31212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31212,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,31212,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,31212,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,31213,0)
 ;;=F44.7^^123^1568^5
 ;;^UTILITY(U,$J,358.3,31213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31213,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,31213,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,31213,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,31214,0)
 ;;=F68.10^^123^1568^6
 ;;^UTILITY(U,$J,358.3,31214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31214,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,31214,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,31214,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,31215,0)
 ;;=F54.^^123^1568^12
 ;;^UTILITY(U,$J,358.3,31215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31215,1,3,0)
 ;;=3^Psychological Factors Affecting Oth Med Conditions
 ;;^UTILITY(U,$J,358.3,31215,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,31215,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,31216,0)
 ;;=F91.2^^123^1569^1
 ;;^UTILITY(U,$J,358.3,31216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31216,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,31216,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,31216,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,31217,0)
 ;;=F91.1^^123^1569^2
 ;;^UTILITY(U,$J,358.3,31217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31217,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type

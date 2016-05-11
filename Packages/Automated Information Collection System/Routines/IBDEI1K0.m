IBDEI1K0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26354,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,26354,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,26355,0)
 ;;=F45.29^^98^1248^8
 ;;^UTILITY(U,$J,358.3,26355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26355,1,3,0)
 ;;=3^Hypochondriacal Disorders NEC
 ;;^UTILITY(U,$J,358.3,26355,1,4,0)
 ;;=4^F45.29
 ;;^UTILITY(U,$J,358.3,26355,2)
 ;;=^5003589
 ;;^UTILITY(U,$J,358.3,26356,0)
 ;;=F45.8^^98^1248^15
 ;;^UTILITY(U,$J,358.3,26356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26356,1,3,0)
 ;;=3^Somatoform Disorders NEC
 ;;^UTILITY(U,$J,358.3,26356,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,26356,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,26357,0)
 ;;=F45.41^^98^1248^10
 ;;^UTILITY(U,$J,358.3,26357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26357,1,3,0)
 ;;=3^Pain Disorder Exclusively Related to Psychological Factors
 ;;^UTILITY(U,$J,358.3,26357,1,4,0)
 ;;=4^F45.41
 ;;^UTILITY(U,$J,358.3,26357,2)
 ;;=^5003590
 ;;^UTILITY(U,$J,358.3,26358,0)
 ;;=F45.42^^98^1248^11
 ;;^UTILITY(U,$J,358.3,26358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26358,1,3,0)
 ;;=3^Pain Disorder w/ Related Psychological Factors
 ;;^UTILITY(U,$J,358.3,26358,1,4,0)
 ;;=4^F45.42
 ;;^UTILITY(U,$J,358.3,26358,2)
 ;;=^5003591
 ;;^UTILITY(U,$J,358.3,26359,0)
 ;;=F45.0^^98^1248^13
 ;;^UTILITY(U,$J,358.3,26359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26359,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,26359,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,26359,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,26360,0)
 ;;=F45.9^^98^1248^14
 ;;^UTILITY(U,$J,358.3,26360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26360,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26360,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,26360,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,26361,0)
 ;;=F45.1^^98^1248^16
 ;;^UTILITY(U,$J,358.3,26361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26361,1,3,0)
 ;;=3^Undifferntiated Somatoform Disorder
 ;;^UTILITY(U,$J,358.3,26361,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,26361,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,26362,0)
 ;;=F44.4^^98^1248^2
 ;;^UTILITY(U,$J,358.3,26362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26362,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,26362,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,26362,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,26363,0)
 ;;=F44.6^^98^1248^3
 ;;^UTILITY(U,$J,358.3,26363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26363,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,26363,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,26363,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,26364,0)
 ;;=F44.5^^98^1248^4
 ;;^UTILITY(U,$J,358.3,26364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26364,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,26364,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,26364,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,26365,0)
 ;;=F44.7^^98^1248^5
 ;;^UTILITY(U,$J,358.3,26365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26365,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,26365,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,26365,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,26366,0)
 ;;=F68.10^^98^1248^6
 ;;^UTILITY(U,$J,358.3,26366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26366,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,26366,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,26366,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,26367,0)
 ;;=F54.^^98^1248^12
 ;;^UTILITY(U,$J,358.3,26367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26367,1,3,0)
 ;;=3^Psychological Factors Affecting Oth Med Conditions

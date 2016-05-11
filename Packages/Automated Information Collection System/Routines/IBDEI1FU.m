IBDEI1FU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24432,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,24432,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,24433,0)
 ;;=F45.29^^90^1074^8
 ;;^UTILITY(U,$J,358.3,24433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24433,1,3,0)
 ;;=3^Hypochondriacal Disorders NEC
 ;;^UTILITY(U,$J,358.3,24433,1,4,0)
 ;;=4^F45.29
 ;;^UTILITY(U,$J,358.3,24433,2)
 ;;=^5003589
 ;;^UTILITY(U,$J,358.3,24434,0)
 ;;=F45.8^^90^1074^15
 ;;^UTILITY(U,$J,358.3,24434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24434,1,3,0)
 ;;=3^Somatoform Disorders NEC
 ;;^UTILITY(U,$J,358.3,24434,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,24434,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,24435,0)
 ;;=F45.41^^90^1074^10
 ;;^UTILITY(U,$J,358.3,24435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24435,1,3,0)
 ;;=3^Pain Disorder Exclusively Related to Psychological Factors
 ;;^UTILITY(U,$J,358.3,24435,1,4,0)
 ;;=4^F45.41
 ;;^UTILITY(U,$J,358.3,24435,2)
 ;;=^5003590
 ;;^UTILITY(U,$J,358.3,24436,0)
 ;;=F45.42^^90^1074^11
 ;;^UTILITY(U,$J,358.3,24436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24436,1,3,0)
 ;;=3^Pain Disorder w/ Related Psychological Factors
 ;;^UTILITY(U,$J,358.3,24436,1,4,0)
 ;;=4^F45.42
 ;;^UTILITY(U,$J,358.3,24436,2)
 ;;=^5003591
 ;;^UTILITY(U,$J,358.3,24437,0)
 ;;=F45.0^^90^1074^13
 ;;^UTILITY(U,$J,358.3,24437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24437,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,24437,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,24437,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,24438,0)
 ;;=F45.9^^90^1074^14
 ;;^UTILITY(U,$J,358.3,24438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24438,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24438,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,24438,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,24439,0)
 ;;=F45.1^^90^1074^16
 ;;^UTILITY(U,$J,358.3,24439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24439,1,3,0)
 ;;=3^Undifferntiated Somatoform Disorder
 ;;^UTILITY(U,$J,358.3,24439,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,24439,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,24440,0)
 ;;=F44.4^^90^1074^2
 ;;^UTILITY(U,$J,358.3,24440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24440,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,24440,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,24440,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,24441,0)
 ;;=F44.6^^90^1074^3
 ;;^UTILITY(U,$J,358.3,24441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24441,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,24441,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,24441,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,24442,0)
 ;;=F44.5^^90^1074^4
 ;;^UTILITY(U,$J,358.3,24442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24442,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,24442,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,24442,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,24443,0)
 ;;=F44.7^^90^1074^5
 ;;^UTILITY(U,$J,358.3,24443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24443,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,24443,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,24443,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,24444,0)
 ;;=F68.10^^90^1074^6
 ;;^UTILITY(U,$J,358.3,24444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24444,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,24444,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,24444,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,24445,0)
 ;;=F54.^^90^1074^12
 ;;^UTILITY(U,$J,358.3,24445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24445,1,3,0)
 ;;=3^Psychological Factors Affecting Oth Med Conditions

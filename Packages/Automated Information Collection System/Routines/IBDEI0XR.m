IBDEI0XR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15825,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,15825,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,15826,0)
 ;;=Z00.6^^58^696^1
 ;;^UTILITY(U,$J,358.3,15826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15826,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,15826,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,15826,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,15827,0)
 ;;=F45.22^^58^697^1
 ;;^UTILITY(U,$J,358.3,15827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15827,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,15827,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,15827,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,15828,0)
 ;;=F45.20^^58^697^7
 ;;^UTILITY(U,$J,358.3,15828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15828,1,3,0)
 ;;=3^Hypochondiacal Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15828,1,4,0)
 ;;=4^F45.20
 ;;^UTILITY(U,$J,358.3,15828,2)
 ;;=^5003586
 ;;^UTILITY(U,$J,358.3,15829,0)
 ;;=F45.21^^58^697^9
 ;;^UTILITY(U,$J,358.3,15829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15829,1,3,0)
 ;;=3^Hypochondriasis
 ;;^UTILITY(U,$J,358.3,15829,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,15829,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,15830,0)
 ;;=F45.29^^58^697^8
 ;;^UTILITY(U,$J,358.3,15830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15830,1,3,0)
 ;;=3^Hypochondriacal Disorders NEC
 ;;^UTILITY(U,$J,358.3,15830,1,4,0)
 ;;=4^F45.29
 ;;^UTILITY(U,$J,358.3,15830,2)
 ;;=^5003589
 ;;^UTILITY(U,$J,358.3,15831,0)
 ;;=F45.8^^58^697^15
 ;;^UTILITY(U,$J,358.3,15831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15831,1,3,0)
 ;;=3^Somatoform Disorders NEC
 ;;^UTILITY(U,$J,358.3,15831,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,15831,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,15832,0)
 ;;=F45.41^^58^697^10
 ;;^UTILITY(U,$J,358.3,15832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15832,1,3,0)
 ;;=3^Pain Disorder Exclusively Related to Psychological Factors
 ;;^UTILITY(U,$J,358.3,15832,1,4,0)
 ;;=4^F45.41
 ;;^UTILITY(U,$J,358.3,15832,2)
 ;;=^5003590
 ;;^UTILITY(U,$J,358.3,15833,0)
 ;;=F45.42^^58^697^11
 ;;^UTILITY(U,$J,358.3,15833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15833,1,3,0)
 ;;=3^Pain Disorder w/ Related Psychological Factors
 ;;^UTILITY(U,$J,358.3,15833,1,4,0)
 ;;=4^F45.42
 ;;^UTILITY(U,$J,358.3,15833,2)
 ;;=^5003591
 ;;^UTILITY(U,$J,358.3,15834,0)
 ;;=F45.0^^58^697^13
 ;;^UTILITY(U,$J,358.3,15834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15834,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,15834,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,15834,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,15835,0)
 ;;=F45.9^^58^697^14
 ;;^UTILITY(U,$J,358.3,15835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15835,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15835,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,15835,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,15836,0)
 ;;=F45.1^^58^697^16
 ;;^UTILITY(U,$J,358.3,15836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15836,1,3,0)
 ;;=3^Undifferntiated Somatoform Disorder
 ;;^UTILITY(U,$J,358.3,15836,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,15836,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,15837,0)
 ;;=F44.4^^58^697^2
 ;;^UTILITY(U,$J,358.3,15837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15837,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,15837,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,15837,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,15838,0)
 ;;=F44.6^^58^697^3
 ;;^UTILITY(U,$J,358.3,15838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15838,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss

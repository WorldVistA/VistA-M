IBDEI02E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,627,1,4,0)
 ;;=4^F45.20
 ;;^UTILITY(U,$J,358.3,627,2)
 ;;=^5003586
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=F45.21^^3^62^9
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,628,1,3,0)
 ;;=3^Hypochondriasis
 ;;^UTILITY(U,$J,358.3,628,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,628,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=F45.29^^3^62^8
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,629,1,3,0)
 ;;=3^Hypochondriacal Disorders NEC
 ;;^UTILITY(U,$J,358.3,629,1,4,0)
 ;;=4^F45.29
 ;;^UTILITY(U,$J,358.3,629,2)
 ;;=^5003589
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=F45.8^^3^62^15
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,630,1,3,0)
 ;;=3^Somatoform Disorders NEC
 ;;^UTILITY(U,$J,358.3,630,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,630,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=F45.41^^3^62^10
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,631,1,3,0)
 ;;=3^Pain Disorder Exclusively Related to Psychological Factors
 ;;^UTILITY(U,$J,358.3,631,1,4,0)
 ;;=4^F45.41
 ;;^UTILITY(U,$J,358.3,631,2)
 ;;=^5003590
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=F45.42^^3^62^11
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,632,1,3,0)
 ;;=3^Pain Disorder w/ Related Psychological Factors
 ;;^UTILITY(U,$J,358.3,632,1,4,0)
 ;;=4^F45.42
 ;;^UTILITY(U,$J,358.3,632,2)
 ;;=^5003591
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=F45.0^^3^62^13
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,633,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,633,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,633,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,634,0)
 ;;=F45.9^^3^62^14
 ;;^UTILITY(U,$J,358.3,634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,634,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,634,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,634,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,635,0)
 ;;=F45.1^^3^62^16
 ;;^UTILITY(U,$J,358.3,635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,635,1,3,0)
 ;;=3^Undifferntiated Somatoform Disorder
 ;;^UTILITY(U,$J,358.3,635,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,635,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,636,0)
 ;;=F44.4^^3^62^2
 ;;^UTILITY(U,$J,358.3,636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,636,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,636,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,636,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,637,0)
 ;;=F44.6^^3^62^3
 ;;^UTILITY(U,$J,358.3,637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,637,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,637,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,637,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,638,0)
 ;;=F44.5^^3^62^4
 ;;^UTILITY(U,$J,358.3,638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,638,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,638,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,638,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,639,0)
 ;;=F44.7^^3^62^5
 ;;^UTILITY(U,$J,358.3,639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,639,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,639,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,639,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,640,0)
 ;;=F68.10^^3^62^6
 ;;^UTILITY(U,$J,358.3,640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,640,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,640,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,640,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,641,0)
 ;;=F54.^^3^62^12
 ;;^UTILITY(U,$J,358.3,641,1,0)
 ;;=^358.31IA^4^2

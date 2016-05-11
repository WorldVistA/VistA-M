IBDEI1H7 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25057,0)
 ;;=F44.4^^93^1129^2
 ;;^UTILITY(U,$J,358.3,25057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25057,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,25057,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25057,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25058,0)
 ;;=F44.6^^93^1129^3
 ;;^UTILITY(U,$J,358.3,25058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25058,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,25058,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,25058,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,25059,0)
 ;;=F44.5^^93^1129^4
 ;;^UTILITY(U,$J,358.3,25059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25059,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,25059,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,25059,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,25060,0)
 ;;=F44.7^^93^1129^5
 ;;^UTILITY(U,$J,358.3,25060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25060,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,25060,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,25060,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,25061,0)
 ;;=F68.10^^93^1129^6
 ;;^UTILITY(U,$J,358.3,25061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25061,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,25061,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,25061,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,25062,0)
 ;;=F54.^^93^1129^12
 ;;^UTILITY(U,$J,358.3,25062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25062,1,3,0)
 ;;=3^Psychological Factors Affecting Oth Med Conditions
 ;;^UTILITY(U,$J,358.3,25062,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,25062,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,25063,0)
 ;;=F91.2^^93^1130^1
 ;;^UTILITY(U,$J,358.3,25063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25063,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,25063,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,25063,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,25064,0)
 ;;=F91.1^^93^1130^2
 ;;^UTILITY(U,$J,358.3,25064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25064,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,25064,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,25064,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,25065,0)
 ;;=F91.9^^93^1130^3
 ;;^UTILITY(U,$J,358.3,25065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25065,1,3,0)
 ;;=3^Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25065,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,25065,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,25066,0)
 ;;=F63.81^^93^1130^5
 ;;^UTILITY(U,$J,358.3,25066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25066,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,25066,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,25066,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,25067,0)
 ;;=F63.2^^93^1130^6
 ;;^UTILITY(U,$J,358.3,25067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25067,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,25067,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,25067,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,25068,0)
 ;;=F91.3^^93^1130^7
 ;;^UTILITY(U,$J,358.3,25068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25068,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,25068,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,25068,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,25069,0)
 ;;=F91.8^^93^1130^4
 ;;^UTILITY(U,$J,358.3,25069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25069,1,3,0)
 ;;=3^Disruptive,Impulse-Control,Conduct Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25069,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,25069,2)
 ;;=^5003700

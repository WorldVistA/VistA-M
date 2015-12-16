IBDEI02O ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,700,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,700,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,701,0)
 ;;=R00.2^^3^29^21
 ;;^UTILITY(U,$J,358.3,701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,701,1,3,0)
 ;;=3^Palpitations
 ;;^UTILITY(U,$J,358.3,701,1,4,0)
 ;;=4^R00.2
 ;;^UTILITY(U,$J,358.3,701,2)
 ;;=^5019165
 ;;^UTILITY(U,$J,358.3,702,0)
 ;;=R01.1^^3^29^9
 ;;^UTILITY(U,$J,358.3,702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,702,1,3,0)
 ;;=3^Cardiac murmur, unspecified
 ;;^UTILITY(U,$J,358.3,702,1,4,0)
 ;;=4^R01.1
 ;;^UTILITY(U,$J,358.3,702,2)
 ;;=^5019169
 ;;^UTILITY(U,$J,358.3,703,0)
 ;;=R07.9^^3^29^11
 ;;^UTILITY(U,$J,358.3,703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,703,1,3,0)
 ;;=3^Chest pain, unspecified
 ;;^UTILITY(U,$J,358.3,703,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,703,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,704,0)
 ;;=N18.1^^3^30^1
 ;;^UTILITY(U,$J,358.3,704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,704,1,3,0)
 ;;=3^Chronic kidney disease, stage 1
 ;;^UTILITY(U,$J,358.3,704,1,4,0)
 ;;=4^N18.1
 ;;^UTILITY(U,$J,358.3,704,2)
 ;;=^5015602
 ;;^UTILITY(U,$J,358.3,705,0)
 ;;=N18.2^^3^30^2
 ;;^UTILITY(U,$J,358.3,705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,705,1,3,0)
 ;;=3^Chronic kidney disease, stage 2 (mild)
 ;;^UTILITY(U,$J,358.3,705,1,4,0)
 ;;=4^N18.2
 ;;^UTILITY(U,$J,358.3,705,2)
 ;;=^5015603
 ;;^UTILITY(U,$J,358.3,706,0)
 ;;=N18.3^^3^30^3
 ;;^UTILITY(U,$J,358.3,706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,706,1,3,0)
 ;;=3^Chronic kidney disease, stage 3 (moderate)
 ;;^UTILITY(U,$J,358.3,706,1,4,0)
 ;;=4^N18.3
 ;;^UTILITY(U,$J,358.3,706,2)
 ;;=^5015604
 ;;^UTILITY(U,$J,358.3,707,0)
 ;;=N18.4^^3^30^4
 ;;^UTILITY(U,$J,358.3,707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,707,1,3,0)
 ;;=3^Chronic kidney disease, stage 4 (severe)
 ;;^UTILITY(U,$J,358.3,707,1,4,0)
 ;;=4^N18.4
 ;;^UTILITY(U,$J,358.3,707,2)
 ;;=^5015605
 ;;^UTILITY(U,$J,358.3,708,0)
 ;;=N18.5^^3^30^5
 ;;^UTILITY(U,$J,358.3,708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,708,1,3,0)
 ;;=3^Chronic kidney disease, stage 5
 ;;^UTILITY(U,$J,358.3,708,1,4,0)
 ;;=4^N18.5
 ;;^UTILITY(U,$J,358.3,708,2)
 ;;=^5015606
 ;;^UTILITY(U,$J,358.3,709,0)
 ;;=N18.6^^3^30^6
 ;;^UTILITY(U,$J,358.3,709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,709,1,3,0)
 ;;=3^End stage renal disease
 ;;^UTILITY(U,$J,358.3,709,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,709,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,710,0)
 ;;=N19.^^3^30^7
 ;;^UTILITY(U,$J,358.3,710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,710,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,710,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,710,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,711,0)
 ;;=Z20.820^^3^31^5
 ;;^UTILITY(U,$J,358.3,711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,711,1,3,0)
 ;;=3^Contact/Exposure to Varicella
 ;;^UTILITY(U,$J,358.3,711,1,4,0)
 ;;=4^Z20.820
 ;;^UTILITY(U,$J,358.3,711,2)
 ;;=^5062773
 ;;^UTILITY(U,$J,358.3,712,0)
 ;;=Z20.828^^3^31^6
 ;;^UTILITY(U,$J,358.3,712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,712,1,3,0)
 ;;=3^Contact/Exposure to Viral Communicable Diseases NEC
 ;;^UTILITY(U,$J,358.3,712,1,4,0)
 ;;=4^Z20.828
 ;;^UTILITY(U,$J,358.3,712,2)
 ;;=^5062774
 ;;^UTILITY(U,$J,358.3,713,0)
 ;;=Z20.6^^3^31^2
 ;;^UTILITY(U,$J,358.3,713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,713,1,3,0)
 ;;=3^Contact/Exposure to HIV
 ;;^UTILITY(U,$J,358.3,713,1,4,0)
 ;;=4^Z20.6
 ;;^UTILITY(U,$J,358.3,713,2)
 ;;=^5062768
 ;;^UTILITY(U,$J,358.3,714,0)
 ;;=Z20.01^^3^31^3
 ;;^UTILITY(U,$J,358.3,714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,714,1,3,0)
 ;;=3^Contact/Exposure to Intestnl Infct Dis d/t E Coli

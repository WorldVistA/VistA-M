IBDEI0HH ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7823,1,3,0)
 ;;=3^End stage renal disease
 ;;^UTILITY(U,$J,358.3,7823,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,7823,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,7824,0)
 ;;=N19.^^55^529^7
 ;;^UTILITY(U,$J,358.3,7824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7824,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,7824,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,7824,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,7825,0)
 ;;=Z20.820^^55^530^5
 ;;^UTILITY(U,$J,358.3,7825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7825,1,3,0)
 ;;=3^Contact/Exposure to Varicella
 ;;^UTILITY(U,$J,358.3,7825,1,4,0)
 ;;=4^Z20.820
 ;;^UTILITY(U,$J,358.3,7825,2)
 ;;=^5062773
 ;;^UTILITY(U,$J,358.3,7826,0)
 ;;=Z20.828^^55^530^6
 ;;^UTILITY(U,$J,358.3,7826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7826,1,3,0)
 ;;=3^Contact/Exposure to Viral Communicable Diseases NEC
 ;;^UTILITY(U,$J,358.3,7826,1,4,0)
 ;;=4^Z20.828
 ;;^UTILITY(U,$J,358.3,7826,2)
 ;;=^5062774
 ;;^UTILITY(U,$J,358.3,7827,0)
 ;;=Z20.6^^55^530^2
 ;;^UTILITY(U,$J,358.3,7827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7827,1,3,0)
 ;;=3^Contact/Exposure to HIV
 ;;^UTILITY(U,$J,358.3,7827,1,4,0)
 ;;=4^Z20.6
 ;;^UTILITY(U,$J,358.3,7827,2)
 ;;=^5062768
 ;;^UTILITY(U,$J,358.3,7828,0)
 ;;=Z20.01^^55^530^3
 ;;^UTILITY(U,$J,358.3,7828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7828,1,3,0)
 ;;=3^Contact/Exposure to Intestnl Infct Dis d/t E Coli
 ;;^UTILITY(U,$J,358.3,7828,1,4,0)
 ;;=4^Z20.01
 ;;^UTILITY(U,$J,358.3,7828,2)
 ;;=^5062761
 ;;^UTILITY(U,$J,358.3,7829,0)
 ;;=Z20.811^^55^530^4
 ;;^UTILITY(U,$J,358.3,7829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7829,1,3,0)
 ;;=3^Contact/Exposure to Meningococcus
 ;;^UTILITY(U,$J,358.3,7829,1,4,0)
 ;;=4^Z20.811
 ;;^UTILITY(U,$J,358.3,7829,2)
 ;;=^5062771
 ;;^UTILITY(U,$J,358.3,7830,0)
 ;;=Z20.89^^55^530^1
 ;;^UTILITY(U,$J,358.3,7830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7830,1,3,0)
 ;;=3^Contact/Exposure to Communicable Diseases NEC
 ;;^UTILITY(U,$J,358.3,7830,1,4,0)
 ;;=4^Z20.89
 ;;^UTILITY(U,$J,358.3,7830,2)
 ;;=^5062775
 ;;^UTILITY(U,$J,358.3,7831,0)
 ;;=B07.9^^55^531^151
 ;;^UTILITY(U,$J,358.3,7831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7831,1,3,0)
 ;;=3^Viral wart, unspecified
 ;;^UTILITY(U,$J,358.3,7831,1,4,0)
 ;;=4^B07.9
 ;;^UTILITY(U,$J,358.3,7831,2)
 ;;=^5000519
 ;;^UTILITY(U,$J,358.3,7832,0)
 ;;=A63.0^^55^531^6
 ;;^UTILITY(U,$J,358.3,7832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7832,1,3,0)
 ;;=3^Anogenital (venereal) warts
 ;;^UTILITY(U,$J,358.3,7832,1,4,0)
 ;;=4^A63.0
 ;;^UTILITY(U,$J,358.3,7832,2)
 ;;=^5000360
 ;;^UTILITY(U,$J,358.3,7833,0)
 ;;=B35.0^^55^531^144
 ;;^UTILITY(U,$J,358.3,7833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7833,1,3,0)
 ;;=3^Tinea barbae and tinea capitis
 ;;^UTILITY(U,$J,358.3,7833,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,7833,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,7834,0)
 ;;=B35.1^^55^531^148
 ;;^UTILITY(U,$J,358.3,7834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7834,1,3,0)
 ;;=3^Tinea unguium
 ;;^UTILITY(U,$J,358.3,7834,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,7834,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,7835,0)
 ;;=B35.6^^55^531^145
 ;;^UTILITY(U,$J,358.3,7835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7835,1,3,0)
 ;;=3^Tinea cruris
 ;;^UTILITY(U,$J,358.3,7835,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,7835,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,7836,0)
 ;;=B35.3^^55^531^147
 ;;^UTILITY(U,$J,358.3,7836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7836,1,3,0)
 ;;=3^Tinea pedis
 ;;^UTILITY(U,$J,358.3,7836,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,7836,2)
 ;;=^119732

IBDEI0KC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8975,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,8975,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,8975,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,8976,0)
 ;;=N10.^^69^615^5
 ;;^UTILITY(U,$J,358.3,8976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8976,1,3,0)
 ;;=3^Acute Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,8976,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,8976,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,8977,0)
 ;;=N17.1^^69^615^1
 ;;^UTILITY(U,$J,358.3,8977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8977,1,3,0)
 ;;=3^AKI w/ Acute Cortical Necrosis
 ;;^UTILITY(U,$J,358.3,8977,1,4,0)
 ;;=4^N17.1
 ;;^UTILITY(U,$J,358.3,8977,2)
 ;;=^5015599
 ;;^UTILITY(U,$J,358.3,8978,0)
 ;;=N17.0^^69^615^3
 ;;^UTILITY(U,$J,358.3,8978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8978,1,3,0)
 ;;=3^AKI w/ Tubular Necrosis
 ;;^UTILITY(U,$J,358.3,8978,1,4,0)
 ;;=4^N17.0
 ;;^UTILITY(U,$J,358.3,8978,2)
 ;;=^5015598
 ;;^UTILITY(U,$J,358.3,8979,0)
 ;;=N17.2^^69^615^2
 ;;^UTILITY(U,$J,358.3,8979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8979,1,3,0)
 ;;=3^AKI w/ Medullary Necrosis
 ;;^UTILITY(U,$J,358.3,8979,1,4,0)
 ;;=4^N17.2
 ;;^UTILITY(U,$J,358.3,8979,2)
 ;;=^5015600
 ;;^UTILITY(U,$J,358.3,8980,0)
 ;;=N17.9^^69^615^4
 ;;^UTILITY(U,$J,358.3,8980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8980,1,3,0)
 ;;=3^AKI,Unspec
 ;;^UTILITY(U,$J,358.3,8980,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,8980,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,8981,0)
 ;;=K76.7^^69^615^10
 ;;^UTILITY(U,$J,358.3,8981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8981,1,3,0)
 ;;=3^Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,8981,1,4,0)
 ;;=4^K76.7
 ;;^UTILITY(U,$J,358.3,8981,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,8982,0)
 ;;=Z99.2^^69^615^7
 ;;^UTILITY(U,$J,358.3,8982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8982,1,3,0)
 ;;=3^Dependence on Renal Dialysis
 ;;^UTILITY(U,$J,358.3,8982,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,8982,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,8983,0)
 ;;=Z49.31^^69^615^8
 ;;^UTILITY(U,$J,358.3,8983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8983,1,3,0)
 ;;=3^Encounter for Adequacy Testing for Hemodialysis
 ;;^UTILITY(U,$J,358.3,8983,1,4,0)
 ;;=4^Z49.31
 ;;^UTILITY(U,$J,358.3,8983,2)
 ;;=^5063058
 ;;^UTILITY(U,$J,358.3,8984,0)
 ;;=Z49.01^^69^615^9
 ;;^UTILITY(U,$J,358.3,8984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8984,1,3,0)
 ;;=3^Fitting/Adjustment of Extracorporeal Dialysis Catheter
 ;;^UTILITY(U,$J,358.3,8984,1,4,0)
 ;;=4^Z49.01
 ;;^UTILITY(U,$J,358.3,8984,2)
 ;;=^5063056
 ;;^UTILITY(U,$J,358.3,8985,0)
 ;;=Z48.00^^69^615^6
 ;;^UTILITY(U,$J,358.3,8985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8985,1,3,0)
 ;;=3^Change/Removal of Nonsurgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,8985,1,4,0)
 ;;=4^Z48.00
 ;;^UTILITY(U,$J,358.3,8985,2)
 ;;=^5063033
 ;;^UTILITY(U,$J,358.3,8986,0)
 ;;=N17.0^^69^616^3
 ;;^UTILITY(U,$J,358.3,8986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8986,1,3,0)
 ;;=3^AKI w/ Tubular Necrosis
 ;;^UTILITY(U,$J,358.3,8986,1,4,0)
 ;;=4^N17.0
 ;;^UTILITY(U,$J,358.3,8986,2)
 ;;=^5015598
 ;;^UTILITY(U,$J,358.3,8987,0)
 ;;=N17.1^^69^616^1
 ;;^UTILITY(U,$J,358.3,8987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8987,1,3,0)
 ;;=3^AKI w/ Acute Cortical Necrosis
 ;;^UTILITY(U,$J,358.3,8987,1,4,0)
 ;;=4^N17.1
 ;;^UTILITY(U,$J,358.3,8987,2)
 ;;=^5015599

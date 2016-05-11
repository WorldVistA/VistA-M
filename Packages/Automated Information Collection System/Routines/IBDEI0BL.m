IBDEI0BL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5242,1,3,0)
 ;;=3^Chr Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,5242,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,5242,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,5243,0)
 ;;=N18.6^^27^341^7
 ;;^UTILITY(U,$J,358.3,5243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5243,1,3,0)
 ;;=3^ESRD
 ;;^UTILITY(U,$J,358.3,5243,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,5243,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,5244,0)
 ;;=N19.^^27^341^8
 ;;^UTILITY(U,$J,358.3,5244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5244,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,5244,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,5244,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,5245,0)
 ;;=N10.^^27^342^5
 ;;^UTILITY(U,$J,358.3,5245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5245,1,3,0)
 ;;=3^Acute Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,5245,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,5245,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,5246,0)
 ;;=N17.1^^27^342^1
 ;;^UTILITY(U,$J,358.3,5246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5246,1,3,0)
 ;;=3^AKI w/ Acute Cortical Necrosis
 ;;^UTILITY(U,$J,358.3,5246,1,4,0)
 ;;=4^N17.1
 ;;^UTILITY(U,$J,358.3,5246,2)
 ;;=^5015599
 ;;^UTILITY(U,$J,358.3,5247,0)
 ;;=N17.0^^27^342^3
 ;;^UTILITY(U,$J,358.3,5247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5247,1,3,0)
 ;;=3^AKI w/ Tubular Necrosis
 ;;^UTILITY(U,$J,358.3,5247,1,4,0)
 ;;=4^N17.0
 ;;^UTILITY(U,$J,358.3,5247,2)
 ;;=^5015598
 ;;^UTILITY(U,$J,358.3,5248,0)
 ;;=N17.2^^27^342^2
 ;;^UTILITY(U,$J,358.3,5248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5248,1,3,0)
 ;;=3^AKI w/ Medullary Necrosis
 ;;^UTILITY(U,$J,358.3,5248,1,4,0)
 ;;=4^N17.2
 ;;^UTILITY(U,$J,358.3,5248,2)
 ;;=^5015600
 ;;^UTILITY(U,$J,358.3,5249,0)
 ;;=N17.9^^27^342^4
 ;;^UTILITY(U,$J,358.3,5249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5249,1,3,0)
 ;;=3^AKI,Unspec
 ;;^UTILITY(U,$J,358.3,5249,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,5249,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,5250,0)
 ;;=K76.7^^27^342^10
 ;;^UTILITY(U,$J,358.3,5250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5250,1,3,0)
 ;;=3^Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,5250,1,4,0)
 ;;=4^K76.7
 ;;^UTILITY(U,$J,358.3,5250,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,5251,0)
 ;;=Z99.2^^27^342^7
 ;;^UTILITY(U,$J,358.3,5251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5251,1,3,0)
 ;;=3^Dependence on Renal Dialysis
 ;;^UTILITY(U,$J,358.3,5251,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,5251,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,5252,0)
 ;;=Z49.31^^27^342^8
 ;;^UTILITY(U,$J,358.3,5252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5252,1,3,0)
 ;;=3^Encounter for Adequacy Testing for Hemodialysis
 ;;^UTILITY(U,$J,358.3,5252,1,4,0)
 ;;=4^Z49.31
 ;;^UTILITY(U,$J,358.3,5252,2)
 ;;=^5063058
 ;;^UTILITY(U,$J,358.3,5253,0)
 ;;=Z49.01^^27^342^9
 ;;^UTILITY(U,$J,358.3,5253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5253,1,3,0)
 ;;=3^Fitting/Adjustment of Extracorporeal Dialysis Catheter
 ;;^UTILITY(U,$J,358.3,5253,1,4,0)
 ;;=4^Z49.01
 ;;^UTILITY(U,$J,358.3,5253,2)
 ;;=^5063056
 ;;^UTILITY(U,$J,358.3,5254,0)
 ;;=Z48.00^^27^342^6
 ;;^UTILITY(U,$J,358.3,5254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5254,1,3,0)
 ;;=3^Change/Removal of Nonsurgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,5254,1,4,0)
 ;;=4^Z48.00
 ;;^UTILITY(U,$J,358.3,5254,2)
 ;;=^5063033
 ;;^UTILITY(U,$J,358.3,5255,0)
 ;;=N17.0^^27^343^3
 ;;^UTILITY(U,$J,358.3,5255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5255,1,3,0)
 ;;=3^AKI w/ Tubular Necrosis
 ;;^UTILITY(U,$J,358.3,5255,1,4,0)
 ;;=4^N17.0

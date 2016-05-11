IBDEI0BW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5383,1,3,0)
 ;;=3^Adequacy Testing for Hemodialysis
 ;;^UTILITY(U,$J,358.3,5383,1,4,0)
 ;;=4^Z49.31
 ;;^UTILITY(U,$J,358.3,5383,2)
 ;;=^5063058
 ;;^UTILITY(U,$J,358.3,5384,0)
 ;;=Z49.32^^27^348^2
 ;;^UTILITY(U,$J,358.3,5384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5384,1,3,0)
 ;;=3^Adequacy Testing for Peritoneal Dialysis
 ;;^UTILITY(U,$J,358.3,5384,1,4,0)
 ;;=4^Z49.32
 ;;^UTILITY(U,$J,358.3,5384,2)
 ;;=^5063059
 ;;^UTILITY(U,$J,358.3,5385,0)
 ;;=Z49.01^^27^348^4
 ;;^UTILITY(U,$J,358.3,5385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5385,1,3,0)
 ;;=3^Fit/Adjustment of Extracorporeal Dialysis Catheter
 ;;^UTILITY(U,$J,358.3,5385,1,4,0)
 ;;=4^Z49.01
 ;;^UTILITY(U,$J,358.3,5385,2)
 ;;=^5063056
 ;;^UTILITY(U,$J,358.3,5386,0)
 ;;=Z49.02^^27^348^5
 ;;^UTILITY(U,$J,358.3,5386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5386,1,3,0)
 ;;=3^Fit/Adjustment of Peritoneal Dialysis Catheter
 ;;^UTILITY(U,$J,358.3,5386,1,4,0)
 ;;=4^Z49.02
 ;;^UTILITY(U,$J,358.3,5386,2)
 ;;=^5063057
 ;;^UTILITY(U,$J,358.3,5387,0)
 ;;=90471^^28^349^1^^^^1
 ;;^UTILITY(U,$J,358.3,5387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5387,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,5387,1,3,0)
 ;;=3^Immunization Administration (use w/ Vacs below)
 ;;^UTILITY(U,$J,358.3,5388,0)
 ;;=90472^^28^349^1.5^^^^1
 ;;^UTILITY(U,$J,358.3,5388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5388,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,5388,1,3,0)
 ;;=3^2 or more Immunization Administration (use w/ Vacs below)
 ;;^UTILITY(U,$J,358.3,5389,0)
 ;;=90632^^28^349^5^^^^1
 ;;^UTILITY(U,$J,358.3,5389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5389,1,2,0)
 ;;=2^90632
 ;;^UTILITY(U,$J,358.3,5389,1,3,0)
 ;;=3^Hepatitis A Vaccine
 ;;^UTILITY(U,$J,358.3,5390,0)
 ;;=90746^^28^349^7^^^^1
 ;;^UTILITY(U,$J,358.3,5390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5390,1,2,0)
 ;;=2^90746
 ;;^UTILITY(U,$J,358.3,5390,1,3,0)
 ;;=3^Hepatitis B Vaccine
 ;;^UTILITY(U,$J,358.3,5391,0)
 ;;=90636^^28^349^6^^^^1
 ;;^UTILITY(U,$J,358.3,5391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5391,1,2,0)
 ;;=2^90636
 ;;^UTILITY(U,$J,358.3,5391,1,3,0)
 ;;=3^Hepatitis A&B Vaccine
 ;;^UTILITY(U,$J,358.3,5392,0)
 ;;=90707^^28^349^9^^^^1
 ;;^UTILITY(U,$J,358.3,5392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5392,1,2,0)
 ;;=2^90707
 ;;^UTILITY(U,$J,358.3,5392,1,3,0)
 ;;=3^MMR Vaccine
 ;;^UTILITY(U,$J,358.3,5393,0)
 ;;=90658^^28^349^3^^^^1
 ;;^UTILITY(U,$J,358.3,5393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5393,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,5393,1,3,0)
 ;;=3^Flu Vaccine IM (Flulaval)
 ;;^UTILITY(U,$J,358.3,5394,0)
 ;;=90732^^28^349^10^^^^1
 ;;^UTILITY(U,$J,358.3,5394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5394,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,5394,1,3,0)
 ;;=3^Pneumococcal
 ;;^UTILITY(U,$J,358.3,5395,0)
 ;;=90714^^28^349^11^^^^1
 ;;^UTILITY(U,$J,358.3,5395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5395,1,2,0)
 ;;=2^90714
 ;;^UTILITY(U,$J,358.3,5395,1,3,0)
 ;;=3^TD VACCINE
 ;;^UTILITY(U,$J,358.3,5396,0)
 ;;=90715^^28^349^12^^^^1
 ;;^UTILITY(U,$J,358.3,5396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5396,1,2,0)
 ;;=2^90715
 ;;^UTILITY(U,$J,358.3,5396,1,3,0)
 ;;=3^TDAP VACCINE
 ;;^UTILITY(U,$J,358.3,5397,0)
 ;;=90656^^28^349^4^^^^1
 ;;^UTILITY(U,$J,358.3,5397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5397,1,2,0)
 ;;=2^90656
 ;;^UTILITY(U,$J,358.3,5397,1,3,0)
 ;;=3^Flu Vaccine Single Dose Syringe (Afluria)
 ;;^UTILITY(U,$J,358.3,5398,0)
 ;;=90662^^28^349^2^^^^1
 ;;^UTILITY(U,$J,358.3,5398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5398,1,2,0)
 ;;=2^90662

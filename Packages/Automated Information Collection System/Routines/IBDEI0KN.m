IBDEI0KN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9107,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,9108,0)
 ;;=N20.1^^69^619^3
 ;;^UTILITY(U,$J,358.3,9108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9108,1,3,0)
 ;;=3^Calculus of Ureter
 ;;^UTILITY(U,$J,358.3,9108,1,4,0)
 ;;=4^N20.1
 ;;^UTILITY(U,$J,358.3,9108,2)
 ;;=^5015608
 ;;^UTILITY(U,$J,358.3,9109,0)
 ;;=N20.2^^69^619^4
 ;;^UTILITY(U,$J,358.3,9109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9109,1,3,0)
 ;;=3^Calculus of Kidney w/ Calculus of Ureter
 ;;^UTILITY(U,$J,358.3,9109,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,9109,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,9110,0)
 ;;=N20.9^^69^619^5
 ;;^UTILITY(U,$J,358.3,9110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9110,1,3,0)
 ;;=3^Urinary Calculus,Unspec
 ;;^UTILITY(U,$J,358.3,9110,1,4,0)
 ;;=4^N20.9
 ;;^UTILITY(U,$J,358.3,9110,2)
 ;;=^5015610
 ;;^UTILITY(U,$J,358.3,9111,0)
 ;;=E72.53^^69^619^6
 ;;^UTILITY(U,$J,358.3,9111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9111,1,3,0)
 ;;=3^Hyperoxaluria
 ;;^UTILITY(U,$J,358.3,9111,1,4,0)
 ;;=4^E72.53
 ;;^UTILITY(U,$J,358.3,9111,2)
 ;;=^60210
 ;;^UTILITY(U,$J,358.3,9112,0)
 ;;=R78.89^^69^620^1
 ;;^UTILITY(U,$J,358.3,9112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9112,1,3,0)
 ;;=3^Lithium Toxicity
 ;;^UTILITY(U,$J,358.3,9112,1,4,0)
 ;;=4^R78.89
 ;;^UTILITY(U,$J,358.3,9112,2)
 ;;=^5019588
 ;;^UTILITY(U,$J,358.3,9113,0)
 ;;=Z99.2^^69^621^3
 ;;^UTILITY(U,$J,358.3,9113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9113,1,3,0)
 ;;=3^Dependence on Renal Dialysis
 ;;^UTILITY(U,$J,358.3,9113,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,9113,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,9114,0)
 ;;=Z91.15^^69^621^6
 ;;^UTILITY(U,$J,358.3,9114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9114,1,3,0)
 ;;=3^Noncompliance w/ Renal Dialysis
 ;;^UTILITY(U,$J,358.3,9114,1,4,0)
 ;;=4^Z91.15
 ;;^UTILITY(U,$J,358.3,9114,2)
 ;;=^5063617
 ;;^UTILITY(U,$J,358.3,9115,0)
 ;;=Z49.31^^69^621^1
 ;;^UTILITY(U,$J,358.3,9115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9115,1,3,0)
 ;;=3^Adequacy Testing for Hemodialysis
 ;;^UTILITY(U,$J,358.3,9115,1,4,0)
 ;;=4^Z49.31
 ;;^UTILITY(U,$J,358.3,9115,2)
 ;;=^5063058
 ;;^UTILITY(U,$J,358.3,9116,0)
 ;;=Z49.32^^69^621^2
 ;;^UTILITY(U,$J,358.3,9116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9116,1,3,0)
 ;;=3^Adequacy Testing for Peritoneal Dialysis
 ;;^UTILITY(U,$J,358.3,9116,1,4,0)
 ;;=4^Z49.32
 ;;^UTILITY(U,$J,358.3,9116,2)
 ;;=^5063059
 ;;^UTILITY(U,$J,358.3,9117,0)
 ;;=Z49.01^^69^621^4
 ;;^UTILITY(U,$J,358.3,9117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9117,1,3,0)
 ;;=3^Fit/Adjustment of Extracorporeal Dialysis Catheter
 ;;^UTILITY(U,$J,358.3,9117,1,4,0)
 ;;=4^Z49.01
 ;;^UTILITY(U,$J,358.3,9117,2)
 ;;=^5063056
 ;;^UTILITY(U,$J,358.3,9118,0)
 ;;=Z49.02^^69^621^5
 ;;^UTILITY(U,$J,358.3,9118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9118,1,3,0)
 ;;=3^Fit/Adjustment of Peritoneal Dialysis Catheter
 ;;^UTILITY(U,$J,358.3,9118,1,4,0)
 ;;=4^Z49.02
 ;;^UTILITY(U,$J,358.3,9118,2)
 ;;=^5063057
 ;;^UTILITY(U,$J,358.3,9119,0)
 ;;=Z91.5^^69^622^1
 ;;^UTILITY(U,$J,358.3,9119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9119,1,3,0)
 ;;=3^Personal Hx of Suicide Attempt(s)
 ;;^UTILITY(U,$J,358.3,9119,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,9119,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,9120,0)
 ;;=R45.851^^69^622^2
 ;;^UTILITY(U,$J,358.3,9120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9120,1,3,0)
 ;;=3^Suicideal Ideations

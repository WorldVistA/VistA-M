IBDEI0SR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12812,1,3,0)
 ;;=3^Erectile Dysfunction,Drug-Induced
 ;;^UTILITY(U,$J,358.3,12812,1,4,0)
 ;;=4^N52.2
 ;;^UTILITY(U,$J,358.3,12812,2)
 ;;=^5015756
 ;;^UTILITY(U,$J,358.3,12813,0)
 ;;=N52.02^^80^787^13
 ;;^UTILITY(U,$J,358.3,12813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12813,1,3,0)
 ;;=3^Erectile Dysfunction,Corporo-Venous Occlusive
 ;;^UTILITY(U,$J,358.3,12813,1,4,0)
 ;;=4^N52.02
 ;;^UTILITY(U,$J,358.3,12813,2)
 ;;=^5015753
 ;;^UTILITY(U,$J,358.3,12814,0)
 ;;=N52.03^^80^787^12
 ;;^UTILITY(U,$J,358.3,12814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12814,1,3,0)
 ;;=3^Erectile Dysfunction,Artrl Insuff/Corporo-Venous Occlusive
 ;;^UTILITY(U,$J,358.3,12814,1,4,0)
 ;;=4^N52.03
 ;;^UTILITY(U,$J,358.3,12814,2)
 ;;=^5015754
 ;;^UTILITY(U,$J,358.3,12815,0)
 ;;=N52.1^^80^787^18
 ;;^UTILITY(U,$J,358.3,12815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12815,1,3,0)
 ;;=3^Eriectile Dysfunction d/t Oth Diseases
 ;;^UTILITY(U,$J,358.3,12815,1,4,0)
 ;;=4^N52.1
 ;;^UTILITY(U,$J,358.3,12815,2)
 ;;=^5015755
 ;;^UTILITY(U,$J,358.3,12816,0)
 ;;=N52.01^^80^787^17
 ;;^UTILITY(U,$J,358.3,12816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12816,1,3,0)
 ;;=3^Eriectile Dysfunction d/t Arterial Insufficiency
 ;;^UTILITY(U,$J,358.3,12816,1,4,0)
 ;;=4^N52.01
 ;;^UTILITY(U,$J,358.3,12816,2)
 ;;=^5015752
 ;;^UTILITY(U,$J,358.3,12817,0)
 ;;=R33.9^^80^787^35
 ;;^UTILITY(U,$J,358.3,12817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12817,1,3,0)
 ;;=3^Retention of Urine,Unspec
 ;;^UTILITY(U,$J,358.3,12817,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,12817,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,12818,0)
 ;;=R32.^^80^787^40
 ;;^UTILITY(U,$J,358.3,12818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12818,1,3,0)
 ;;=3^Urinary Incontinence,Unspec
 ;;^UTILITY(U,$J,358.3,12818,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,12818,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,12819,0)
 ;;=R35.0^^80^787^19
 ;;^UTILITY(U,$J,358.3,12819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12819,1,3,0)
 ;;=3^Frequency of Micturition
 ;;^UTILITY(U,$J,358.3,12819,1,4,0)
 ;;=4^R35.0
 ;;^UTILITY(U,$J,358.3,12819,2)
 ;;=^5019334
 ;;^UTILITY(U,$J,358.3,12820,0)
 ;;=R31.21^^80^787^28
 ;;^UTILITY(U,$J,358.3,12820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12820,1,3,0)
 ;;=3^Microscopic Hematuria,Asymptomatic
 ;;^UTILITY(U,$J,358.3,12820,1,4,0)
 ;;=4^R31.21
 ;;^UTILITY(U,$J,358.3,12820,2)
 ;;=^5139198
 ;;^UTILITY(U,$J,358.3,12821,0)
 ;;=R31.29^^80^787^29
 ;;^UTILITY(U,$J,358.3,12821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12821,1,3,0)
 ;;=3^Microscopic Hematuria,Other
 ;;^UTILITY(U,$J,358.3,12821,1,4,0)
 ;;=4^R31.29
 ;;^UTILITY(U,$J,358.3,12821,2)
 ;;=^5019327
 ;;^UTILITY(U,$J,358.3,12822,0)
 ;;=N35.919^^80^787^39
 ;;^UTILITY(U,$J,358.3,12822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12822,1,3,0)
 ;;=3^Urethral Stricture,Male,Unspec
 ;;^UTILITY(U,$J,358.3,12822,1,4,0)
 ;;=4^N35.919
 ;;^UTILITY(U,$J,358.3,12822,2)
 ;;=^5157412
 ;;^UTILITY(U,$J,358.3,12823,0)
 ;;=N35.92^^80^787^38
 ;;^UTILITY(U,$J,358.3,12823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12823,1,3,0)
 ;;=3^Urethral Stricture,Female,Unspec
 ;;^UTILITY(U,$J,358.3,12823,1,4,0)
 ;;=4^N35.92
 ;;^UTILITY(U,$J,358.3,12823,2)
 ;;=^5157413
 ;;^UTILITY(U,$J,358.3,12824,0)
 ;;=I83.019^^80^788^21
 ;;^UTILITY(U,$J,358.3,12824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12824,1,3,0)
 ;;=3^Varicose Veins of Right Lower Extremity w/ Ulcer

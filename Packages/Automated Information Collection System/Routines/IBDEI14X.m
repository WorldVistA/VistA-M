IBDEI14X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19309,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,19309,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,19310,0)
 ;;=I70.262^^84^916^11
 ;;^UTILITY(U,$J,358.3,19310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19310,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,19310,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,19310,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,19311,0)
 ;;=I70.261^^84^916^12
 ;;^UTILITY(U,$J,358.3,19311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19311,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,19311,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,19311,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,19312,0)
 ;;=I71.2^^84^916^20
 ;;^UTILITY(U,$J,358.3,19312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19312,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,19312,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,19312,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,19313,0)
 ;;=I71.4^^84^916^1
 ;;^UTILITY(U,$J,358.3,19313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19313,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,19313,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,19313,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,19314,0)
 ;;=I73.9^^84^916^19
 ;;^UTILITY(U,$J,358.3,19314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19314,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19314,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,19314,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,19315,0)
 ;;=I82.891^^84^916^14
 ;;^UTILITY(U,$J,358.3,19315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19315,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,19315,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,19315,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,19316,0)
 ;;=I82.890^^84^916^13
 ;;^UTILITY(U,$J,358.3,19316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19316,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,19316,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,19316,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,19317,0)
 ;;=E78.0^^84^917^12
 ;;^UTILITY(U,$J,358.3,19317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19317,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,19317,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,19317,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,19318,0)
 ;;=E78.1^^84^917^13
 ;;^UTILITY(U,$J,358.3,19318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19318,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,19318,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,19318,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,19319,0)
 ;;=E78.2^^84^917^11
 ;;^UTILITY(U,$J,358.3,19319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19319,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,19319,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,19319,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,19320,0)
 ;;=I10.^^84^917^3
 ;;^UTILITY(U,$J,358.3,19320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19320,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,19320,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,19320,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,19321,0)
 ;;=I11.9^^84^917^10
 ;;^UTILITY(U,$J,358.3,19321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19321,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,19321,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,19321,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,19322,0)
 ;;=I11.0^^84^917^9
 ;;^UTILITY(U,$J,358.3,19322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19322,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure

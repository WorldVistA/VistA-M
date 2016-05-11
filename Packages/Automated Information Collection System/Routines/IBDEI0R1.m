IBDEI0R1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12683,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,12683,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,12683,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,12684,0)
 ;;=I70.262^^53^580^11
 ;;^UTILITY(U,$J,358.3,12684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12684,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,12684,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,12684,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,12685,0)
 ;;=I70.261^^53^580^12
 ;;^UTILITY(U,$J,358.3,12685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12685,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,12685,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,12685,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,12686,0)
 ;;=I71.2^^53^580^20
 ;;^UTILITY(U,$J,358.3,12686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12686,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,12686,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,12686,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,12687,0)
 ;;=I71.4^^53^580^1
 ;;^UTILITY(U,$J,358.3,12687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12687,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,12687,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,12687,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,12688,0)
 ;;=I73.9^^53^580^19
 ;;^UTILITY(U,$J,358.3,12688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12688,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,12688,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,12688,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,12689,0)
 ;;=I82.891^^53^580^14
 ;;^UTILITY(U,$J,358.3,12689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12689,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,12689,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,12689,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,12690,0)
 ;;=I82.890^^53^580^13
 ;;^UTILITY(U,$J,358.3,12690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12690,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,12690,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,12690,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,12691,0)
 ;;=E78.0^^53^581^12
 ;;^UTILITY(U,$J,358.3,12691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12691,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,12691,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,12691,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,12692,0)
 ;;=E78.1^^53^581^13
 ;;^UTILITY(U,$J,358.3,12692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12692,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,12692,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,12692,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,12693,0)
 ;;=E78.2^^53^581^11
 ;;^UTILITY(U,$J,358.3,12693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12693,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,12693,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,12693,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,12694,0)
 ;;=I10.^^53^581^3
 ;;^UTILITY(U,$J,358.3,12694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12694,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,12694,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,12694,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,12695,0)
 ;;=I11.9^^53^581^10
 ;;^UTILITY(U,$J,358.3,12695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12695,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,12695,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,12695,2)
 ;;=^5007064

IBDEI0CM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5779,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Bilateral Legs
 ;;^UTILITY(U,$J,358.3,5779,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,5779,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,5780,0)
 ;;=I70.262^^30^383^11
 ;;^UTILITY(U,$J,358.3,5780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5780,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Left Leg
 ;;^UTILITY(U,$J,358.3,5780,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,5780,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,5781,0)
 ;;=I70.261^^30^383^12
 ;;^UTILITY(U,$J,358.3,5781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5781,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Right Leg
 ;;^UTILITY(U,$J,358.3,5781,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,5781,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,5782,0)
 ;;=I71.2^^30^383^20
 ;;^UTILITY(U,$J,358.3,5782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5782,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,5782,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,5782,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,5783,0)
 ;;=I71.4^^30^383^1
 ;;^UTILITY(U,$J,358.3,5783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5783,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,5783,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,5783,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,5784,0)
 ;;=I73.9^^30^383^19
 ;;^UTILITY(U,$J,358.3,5784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5784,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,5784,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,5784,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,5785,0)
 ;;=I82.891^^30^383^14
 ;;^UTILITY(U,$J,358.3,5785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5785,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Chronic
 ;;^UTILITY(U,$J,358.3,5785,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,5785,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,5786,0)
 ;;=I82.890^^30^383^13
 ;;^UTILITY(U,$J,358.3,5786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5786,1,3,0)
 ;;=3^Embolism/Thrombosis Oth Spec Veins,Acute
 ;;^UTILITY(U,$J,358.3,5786,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,5786,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,5787,0)
 ;;=E78.0^^30^384^13
 ;;^UTILITY(U,$J,358.3,5787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5787,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,5787,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,5787,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,5788,0)
 ;;=E78.1^^30^384^14
 ;;^UTILITY(U,$J,358.3,5788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5788,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,5788,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,5788,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,5789,0)
 ;;=E78.2^^30^384^11
 ;;^UTILITY(U,$J,358.3,5789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5789,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,5789,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,5789,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,5790,0)
 ;;=I10.^^30^384^3
 ;;^UTILITY(U,$J,358.3,5790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5790,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,5790,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,5790,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,5791,0)
 ;;=I11.9^^30^384^10
 ;;^UTILITY(U,$J,358.3,5791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5791,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,5791,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,5791,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,5792,0)
 ;;=I11.0^^30^384^9
 ;;^UTILITY(U,$J,358.3,5792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5792,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure

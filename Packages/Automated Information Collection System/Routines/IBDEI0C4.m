IBDEI0C4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5225,0)
 ;;=I65.8^^40^357^25
 ;;^UTILITY(U,$J,358.3,5225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5225,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,5225,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,5225,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,5226,0)
 ;;=I70.211^^40^357^11
 ;;^UTILITY(U,$J,358.3,5226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5226,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,5226,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,5226,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,5227,0)
 ;;=I70.212^^40^357^10
 ;;^UTILITY(U,$J,358.3,5227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5227,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,5227,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,5227,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,5228,0)
 ;;=I70.213^^40^357^9
 ;;^UTILITY(U,$J,358.3,5228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5228,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,5228,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,5228,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,5229,0)
 ;;=I71.2^^40^357^29
 ;;^UTILITY(U,$J,358.3,5229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5229,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,5229,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,5229,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,5230,0)
 ;;=I71.4^^40^357^1
 ;;^UTILITY(U,$J,358.3,5230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5230,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,5230,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,5230,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,5231,0)
 ;;=I73.9^^40^357^27
 ;;^UTILITY(U,$J,358.3,5231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5231,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,5231,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,5231,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,5232,0)
 ;;=I74.2^^40^357^21
 ;;^UTILITY(U,$J,358.3,5232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5232,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,5232,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,5232,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,5233,0)
 ;;=I74.3^^40^357^19
 ;;^UTILITY(U,$J,358.3,5233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5233,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,5233,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,5233,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,5234,0)
 ;;=I82.402^^40^357^18
 ;;^UTILITY(U,$J,358.3,5234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5234,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,5234,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,5234,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,5235,0)
 ;;=I82.401^^40^357^20
 ;;^UTILITY(U,$J,358.3,5235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5235,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,5235,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,5235,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,5236,0)
 ;;=I82.403^^40^357^17
 ;;^UTILITY(U,$J,358.3,5236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5236,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,5236,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,5236,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,5237,0)
 ;;=K70.30^^40^358^2
 ;;^UTILITY(U,$J,358.3,5237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5237,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites

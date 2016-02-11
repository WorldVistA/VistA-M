IBDEI0WA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14877,0)
 ;;=I70.211^^85^799^11
 ;;^UTILITY(U,$J,358.3,14877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14877,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,14877,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,14877,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,14878,0)
 ;;=I70.212^^85^799^10
 ;;^UTILITY(U,$J,358.3,14878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14878,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,14878,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,14878,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,14879,0)
 ;;=I70.213^^85^799^9
 ;;^UTILITY(U,$J,358.3,14879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14879,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,14879,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,14879,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,14880,0)
 ;;=I71.2^^85^799^29
 ;;^UTILITY(U,$J,358.3,14880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14880,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,14880,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,14880,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,14881,0)
 ;;=I71.4^^85^799^1
 ;;^UTILITY(U,$J,358.3,14881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14881,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,14881,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,14881,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,14882,0)
 ;;=I73.9^^85^799^27
 ;;^UTILITY(U,$J,358.3,14882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14882,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14882,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,14882,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,14883,0)
 ;;=I74.2^^85^799^21
 ;;^UTILITY(U,$J,358.3,14883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14883,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,14883,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,14883,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,14884,0)
 ;;=I74.3^^85^799^19
 ;;^UTILITY(U,$J,358.3,14884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14884,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,14884,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,14884,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,14885,0)
 ;;=I82.402^^85^799^18
 ;;^UTILITY(U,$J,358.3,14885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14885,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,14885,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,14885,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,14886,0)
 ;;=I82.401^^85^799^20
 ;;^UTILITY(U,$J,358.3,14886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14886,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,14886,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,14886,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,14887,0)
 ;;=I82.403^^85^799^17
 ;;^UTILITY(U,$J,358.3,14887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14887,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,14887,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,14887,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,14888,0)
 ;;=K70.30^^85^800^2
 ;;^UTILITY(U,$J,358.3,14888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14888,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,14888,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,14888,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,14889,0)
 ;;=K70.31^^85^800^1
 ;;^UTILITY(U,$J,358.3,14889,1,0)
 ;;=^358.31IA^4^2

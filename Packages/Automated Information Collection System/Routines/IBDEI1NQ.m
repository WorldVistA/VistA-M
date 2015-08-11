IBDEI1NQ ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29794,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,29794,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,29794,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,29795,0)
 ;;=I70.211^^189^1895^11
 ;;^UTILITY(U,$J,358.3,29795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29795,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,29795,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,29795,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,29796,0)
 ;;=I70.212^^189^1895^10
 ;;^UTILITY(U,$J,358.3,29796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29796,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,29796,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,29796,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,29797,0)
 ;;=I70.213^^189^1895^9
 ;;^UTILITY(U,$J,358.3,29797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29797,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,29797,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,29797,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,29798,0)
 ;;=I71.2^^189^1895^29
 ;;^UTILITY(U,$J,358.3,29798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29798,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,29798,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,29798,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,29799,0)
 ;;=I71.4^^189^1895^1
 ;;^UTILITY(U,$J,358.3,29799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29799,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,29799,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,29799,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,29800,0)
 ;;=I73.9^^189^1895^27
 ;;^UTILITY(U,$J,358.3,29800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29800,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,29800,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,29800,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,29801,0)
 ;;=I74.2^^189^1895^21
 ;;^UTILITY(U,$J,358.3,29801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29801,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,29801,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,29801,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,29802,0)
 ;;=I74.3^^189^1895^19
 ;;^UTILITY(U,$J,358.3,29802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29802,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,29802,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,29802,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,29803,0)
 ;;=I82.402^^189^1895^18
 ;;^UTILITY(U,$J,358.3,29803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29803,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,29803,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,29803,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,29804,0)
 ;;=I82.401^^189^1895^20
 ;;^UTILITY(U,$J,358.3,29804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29804,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,29804,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,29804,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,29805,0)
 ;;=I82.403^^189^1895^17
 ;;^UTILITY(U,$J,358.3,29805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29805,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,29805,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,29805,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,29806,0)
 ;;=K70.30^^189^1896^2
 ;;^UTILITY(U,$J,358.3,29806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29806,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites

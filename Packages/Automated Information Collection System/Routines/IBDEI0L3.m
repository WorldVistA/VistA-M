IBDEI0L3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9553,1,3,0)
 ;;=3^Posterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9553,1,4,0)
 ;;=4^G46.2
 ;;^UTILITY(U,$J,358.3,9553,2)
 ;;=^5003962
 ;;^UTILITY(U,$J,358.3,9554,0)
 ;;=G46.3^^65^618^3
 ;;^UTILITY(U,$J,358.3,9554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9554,1,3,0)
 ;;=3^Brain Stem Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,9554,1,4,0)
 ;;=4^G46.3
 ;;^UTILITY(U,$J,358.3,9554,2)
 ;;=^5003963
 ;;^UTILITY(U,$J,358.3,9555,0)
 ;;=G46.7^^65^618^7
 ;;^UTILITY(U,$J,358.3,9555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9555,1,3,0)
 ;;=3^Lacunar Syndromes,Other
 ;;^UTILITY(U,$J,358.3,9555,1,4,0)
 ;;=4^G46.7
 ;;^UTILITY(U,$J,358.3,9555,2)
 ;;=^5003967
 ;;^UTILITY(U,$J,358.3,9556,0)
 ;;=G46.8^^65^618^14
 ;;^UTILITY(U,$J,358.3,9556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9556,1,3,0)
 ;;=3^Vascular Syndromes of Brain in CVD,Other
 ;;^UTILITY(U,$J,358.3,9556,1,4,0)
 ;;=4^G46.8
 ;;^UTILITY(U,$J,358.3,9556,2)
 ;;=^5003968
 ;;^UTILITY(U,$J,358.3,9557,0)
 ;;=I67.2^^65^618^5
 ;;^UTILITY(U,$J,358.3,9557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9557,1,3,0)
 ;;=3^Cerebral Atherosclerosis
 ;;^UTILITY(U,$J,358.3,9557,1,4,0)
 ;;=4^I67.2
 ;;^UTILITY(U,$J,358.3,9557,2)
 ;;=^21571
 ;;^UTILITY(U,$J,358.3,9558,0)
 ;;=I69.898^^65^618^6
 ;;^UTILITY(U,$J,358.3,9558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9558,1,3,0)
 ;;=3^Cerebrovascular Disease Sequelae,Other
 ;;^UTILITY(U,$J,358.3,9558,1,4,0)
 ;;=4^I69.898
 ;;^UTILITY(U,$J,358.3,9558,2)
 ;;=^5007550
 ;;^UTILITY(U,$J,358.3,9559,0)
 ;;=Z86.73^^65^618^9
 ;;^UTILITY(U,$J,358.3,9559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9559,1,3,0)
 ;;=3^Personal Hx of TIA/Cerebral Inf w/o Resid Deficits
 ;;^UTILITY(U,$J,358.3,9559,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,9559,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,9560,0)
 ;;=H81.10^^65^619^1
 ;;^UTILITY(U,$J,358.3,9560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9560,1,3,0)
 ;;=3^Benign Paroxysmal Vertigo
 ;;^UTILITY(U,$J,358.3,9560,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,9560,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,9561,0)
 ;;=H81.49^^65^619^2
 ;;^UTILITY(U,$J,358.3,9561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9561,1,3,0)
 ;;=3^Central Vertigo
 ;;^UTILITY(U,$J,358.3,9561,1,4,0)
 ;;=4^H81.49
 ;;^UTILITY(U,$J,358.3,9561,2)
 ;;=^5006883
 ;;^UTILITY(U,$J,358.3,9562,0)
 ;;=R55.^^65^619^4
 ;;^UTILITY(U,$J,358.3,9562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9562,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,9562,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,9562,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,9563,0)
 ;;=R42.^^65^619^3
 ;;^UTILITY(U,$J,358.3,9563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9563,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,9563,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,9563,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,9564,0)
 ;;=F10.27^^65^620^1
 ;;^UTILITY(U,$J,358.3,9564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9564,1,3,0)
 ;;=3^Alcoholic Encephalopathy
 ;;^UTILITY(U,$J,358.3,9564,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,9564,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,9565,0)
 ;;=G92.^^65^620^4
 ;;^UTILITY(U,$J,358.3,9565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9565,1,3,0)
 ;;=3^Toxic Encephalopathy
 ;;^UTILITY(U,$J,358.3,9565,1,4,0)
 ;;=4^G92.
 ;;^UTILITY(U,$J,358.3,9565,2)
 ;;=^259061
 ;;^UTILITY(U,$J,358.3,9566,0)
 ;;=G96.8^^65^620^2
 ;;^UTILITY(U,$J,358.3,9566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9566,1,3,0)
 ;;=3^Disorder of Central Nervous System,Other Spec
 ;;^UTILITY(U,$J,358.3,9566,1,4,0)
 ;;=4^G96.8

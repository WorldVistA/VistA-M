IBDEI0KL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9309,1,3,0)
 ;;=3^Posterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,9309,1,4,0)
 ;;=4^G46.2
 ;;^UTILITY(U,$J,358.3,9309,2)
 ;;=^5003962
 ;;^UTILITY(U,$J,358.3,9310,0)
 ;;=G46.3^^61^589^3
 ;;^UTILITY(U,$J,358.3,9310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9310,1,3,0)
 ;;=3^Brain Stem Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,9310,1,4,0)
 ;;=4^G46.3
 ;;^UTILITY(U,$J,358.3,9310,2)
 ;;=^5003963
 ;;^UTILITY(U,$J,358.3,9311,0)
 ;;=G46.7^^61^589^7
 ;;^UTILITY(U,$J,358.3,9311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9311,1,3,0)
 ;;=3^Lacunar Syndromes,Other
 ;;^UTILITY(U,$J,358.3,9311,1,4,0)
 ;;=4^G46.7
 ;;^UTILITY(U,$J,358.3,9311,2)
 ;;=^5003967
 ;;^UTILITY(U,$J,358.3,9312,0)
 ;;=G46.8^^61^589^14
 ;;^UTILITY(U,$J,358.3,9312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9312,1,3,0)
 ;;=3^Vascular Syndromes of Brain in CVD,Other
 ;;^UTILITY(U,$J,358.3,9312,1,4,0)
 ;;=4^G46.8
 ;;^UTILITY(U,$J,358.3,9312,2)
 ;;=^5003968
 ;;^UTILITY(U,$J,358.3,9313,0)
 ;;=I67.2^^61^589^5
 ;;^UTILITY(U,$J,358.3,9313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9313,1,3,0)
 ;;=3^Cerebral Atherosclerosis
 ;;^UTILITY(U,$J,358.3,9313,1,4,0)
 ;;=4^I67.2
 ;;^UTILITY(U,$J,358.3,9313,2)
 ;;=^21571
 ;;^UTILITY(U,$J,358.3,9314,0)
 ;;=I69.898^^61^589^6
 ;;^UTILITY(U,$J,358.3,9314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9314,1,3,0)
 ;;=3^Cerebrovascular Disease Sequelae,Other
 ;;^UTILITY(U,$J,358.3,9314,1,4,0)
 ;;=4^I69.898
 ;;^UTILITY(U,$J,358.3,9314,2)
 ;;=^5007550
 ;;^UTILITY(U,$J,358.3,9315,0)
 ;;=Z86.73^^61^589^9
 ;;^UTILITY(U,$J,358.3,9315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9315,1,3,0)
 ;;=3^Personal Hx of TIA/Cerebral Inf w/o Resid Deficits
 ;;^UTILITY(U,$J,358.3,9315,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,9315,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,9316,0)
 ;;=H81.10^^61^590^1
 ;;^UTILITY(U,$J,358.3,9316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9316,1,3,0)
 ;;=3^Benign Paroxysmal Vertigo
 ;;^UTILITY(U,$J,358.3,9316,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,9316,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,9317,0)
 ;;=H81.49^^61^590^2
 ;;^UTILITY(U,$J,358.3,9317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9317,1,3,0)
 ;;=3^Central Vertigo
 ;;^UTILITY(U,$J,358.3,9317,1,4,0)
 ;;=4^H81.49
 ;;^UTILITY(U,$J,358.3,9317,2)
 ;;=^5006883
 ;;^UTILITY(U,$J,358.3,9318,0)
 ;;=R55.^^61^590^4
 ;;^UTILITY(U,$J,358.3,9318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9318,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,9318,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,9318,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,9319,0)
 ;;=R42.^^61^590^3
 ;;^UTILITY(U,$J,358.3,9319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9319,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,9319,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,9319,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,9320,0)
 ;;=F10.27^^61^591^1
 ;;^UTILITY(U,$J,358.3,9320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9320,1,3,0)
 ;;=3^Alcoholic Encephalopathy
 ;;^UTILITY(U,$J,358.3,9320,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,9320,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,9321,0)
 ;;=G92.^^61^591^4
 ;;^UTILITY(U,$J,358.3,9321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9321,1,3,0)
 ;;=3^Toxic Encephalopathy
 ;;^UTILITY(U,$J,358.3,9321,1,4,0)
 ;;=4^G92.
 ;;^UTILITY(U,$J,358.3,9321,2)
 ;;=^259061
 ;;^UTILITY(U,$J,358.3,9322,0)
 ;;=G96.8^^61^591^2
 ;;^UTILITY(U,$J,358.3,9322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9322,1,3,0)
 ;;=3^Disorder of Central Nervous System,Other Spec
 ;;^UTILITY(U,$J,358.3,9322,1,4,0)
 ;;=4^G96.8
 ;;^UTILITY(U,$J,358.3,9322,2)
 ;;=^5004199

IBDEI1NN ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29405,1,3,0)
 ;;=3^Cerebral cysts
 ;;^UTILITY(U,$J,358.3,29405,1,4,0)
 ;;=4^G93.0
 ;;^UTILITY(U,$J,358.3,29405,2)
 ;;=^268481
 ;;^UTILITY(U,$J,358.3,29406,0)
 ;;=G04.90^^176^1883^10
 ;;^UTILITY(U,$J,358.3,29406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29406,1,3,0)
 ;;=3^Encephalitis and encephalomyelitis, unspecified
 ;;^UTILITY(U,$J,358.3,29406,1,4,0)
 ;;=4^G04.90
 ;;^UTILITY(U,$J,358.3,29406,2)
 ;;=^5003741
 ;;^UTILITY(U,$J,358.3,29407,0)
 ;;=G04.91^^176^1883^19
 ;;^UTILITY(U,$J,358.3,29407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29407,1,3,0)
 ;;=3^Myelitis, unspecified
 ;;^UTILITY(U,$J,358.3,29407,1,4,0)
 ;;=4^G04.91
 ;;^UTILITY(U,$J,358.3,29407,2)
 ;;=^5003742
 ;;^UTILITY(U,$J,358.3,29408,0)
 ;;=G93.40^^176^1883^11
 ;;^UTILITY(U,$J,358.3,29408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29408,1,3,0)
 ;;=3^Encephalopathy, unspecified
 ;;^UTILITY(U,$J,358.3,29408,1,4,0)
 ;;=4^G93.40
 ;;^UTILITY(U,$J,358.3,29408,2)
 ;;=^329917
 ;;^UTILITY(U,$J,358.3,29409,0)
 ;;=G91.0^^176^1883^9
 ;;^UTILITY(U,$J,358.3,29409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29409,1,3,0)
 ;;=3^Communicating hydrocephalus
 ;;^UTILITY(U,$J,358.3,29409,1,4,0)
 ;;=4^G91.0
 ;;^UTILITY(U,$J,358.3,29409,2)
 ;;=^26586
 ;;^UTILITY(U,$J,358.3,29410,0)
 ;;=G91.1^^176^1883^27
 ;;^UTILITY(U,$J,358.3,29410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29410,1,3,0)
 ;;=3^Obstructive hydrocephalus
 ;;^UTILITY(U,$J,358.3,29410,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,29410,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,29411,0)
 ;;=I61.9^^176^1883^20
 ;;^UTILITY(U,$J,358.3,29411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29411,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,29411,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,29411,2)
 ;;=^5007288
 ;;^UTILITY(U,$J,358.3,29412,0)
 ;;=I61.3^^176^1883^21
 ;;^UTILITY(U,$J,358.3,29412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29412,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, brainstem
 ;;^UTILITY(U,$J,358.3,29412,1,4,0)
 ;;=4^I61.3
 ;;^UTILITY(U,$J,358.3,29412,2)
 ;;=^5007283
 ;;^UTILITY(U,$J,358.3,29413,0)
 ;;=I61.4^^176^1883^22
 ;;^UTILITY(U,$J,358.3,29413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29413,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, cerebellum
 ;;^UTILITY(U,$J,358.3,29413,1,4,0)
 ;;=4^I61.4
 ;;^UTILITY(U,$J,358.3,29413,2)
 ;;=^5007284
 ;;^UTILITY(U,$J,358.3,29414,0)
 ;;=I61.5^^176^1883^23
 ;;^UTILITY(U,$J,358.3,29414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29414,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, intraventricular
 ;;^UTILITY(U,$J,358.3,29414,1,4,0)
 ;;=4^I61.5
 ;;^UTILITY(U,$J,358.3,29414,2)
 ;;=^5007285
 ;;^UTILITY(U,$J,358.3,29415,0)
 ;;=I61.6^^176^1883^24
 ;;^UTILITY(U,$J,358.3,29415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29415,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, multiple localized
 ;;^UTILITY(U,$J,358.3,29415,1,4,0)
 ;;=4^I61.6
 ;;^UTILITY(U,$J,358.3,29415,2)
 ;;=^5007286
 ;;^UTILITY(U,$J,358.3,29416,0)
 ;;=G44.1^^176^1883^69
 ;;^UTILITY(U,$J,358.3,29416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29416,1,3,0)
 ;;=3^Vascular headache, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,29416,1,4,0)
 ;;=4^G44.1
 ;;^UTILITY(U,$J,358.3,29416,2)
 ;;=^5003934
 ;;^UTILITY(U,$J,358.3,29417,0)
 ;;=R51.^^176^1883^12
 ;;^UTILITY(U,$J,358.3,29417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29417,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,29417,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,29417,2)
 ;;=^5019513

IBDEI22B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34583,1,4,0)
 ;;=4^G04.91
 ;;^UTILITY(U,$J,358.3,34583,2)
 ;;=^5003742
 ;;^UTILITY(U,$J,358.3,34584,0)
 ;;=G93.40^^160^1761^11
 ;;^UTILITY(U,$J,358.3,34584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34584,1,3,0)
 ;;=3^Encephalopathy, unspecified
 ;;^UTILITY(U,$J,358.3,34584,1,4,0)
 ;;=4^G93.40
 ;;^UTILITY(U,$J,358.3,34584,2)
 ;;=^329917
 ;;^UTILITY(U,$J,358.3,34585,0)
 ;;=G91.0^^160^1761^9
 ;;^UTILITY(U,$J,358.3,34585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34585,1,3,0)
 ;;=3^Communicating hydrocephalus
 ;;^UTILITY(U,$J,358.3,34585,1,4,0)
 ;;=4^G91.0
 ;;^UTILITY(U,$J,358.3,34585,2)
 ;;=^26586
 ;;^UTILITY(U,$J,358.3,34586,0)
 ;;=G91.1^^160^1761^27
 ;;^UTILITY(U,$J,358.3,34586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34586,1,3,0)
 ;;=3^Obstructive hydrocephalus
 ;;^UTILITY(U,$J,358.3,34586,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,34586,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,34587,0)
 ;;=I61.9^^160^1761^20
 ;;^UTILITY(U,$J,358.3,34587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34587,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,34587,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,34587,2)
 ;;=^5007288
 ;;^UTILITY(U,$J,358.3,34588,0)
 ;;=I61.3^^160^1761^21
 ;;^UTILITY(U,$J,358.3,34588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34588,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, brainstem
 ;;^UTILITY(U,$J,358.3,34588,1,4,0)
 ;;=4^I61.3
 ;;^UTILITY(U,$J,358.3,34588,2)
 ;;=^5007283
 ;;^UTILITY(U,$J,358.3,34589,0)
 ;;=I61.4^^160^1761^22
 ;;^UTILITY(U,$J,358.3,34589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34589,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, cerebellum
 ;;^UTILITY(U,$J,358.3,34589,1,4,0)
 ;;=4^I61.4
 ;;^UTILITY(U,$J,358.3,34589,2)
 ;;=^5007284
 ;;^UTILITY(U,$J,358.3,34590,0)
 ;;=I61.5^^160^1761^23
 ;;^UTILITY(U,$J,358.3,34590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34590,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, intraventricular
 ;;^UTILITY(U,$J,358.3,34590,1,4,0)
 ;;=4^I61.5
 ;;^UTILITY(U,$J,358.3,34590,2)
 ;;=^5007285
 ;;^UTILITY(U,$J,358.3,34591,0)
 ;;=I61.6^^160^1761^24
 ;;^UTILITY(U,$J,358.3,34591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34591,1,3,0)
 ;;=3^Nontraumatic intracerebral hemorrhage, multiple localized
 ;;^UTILITY(U,$J,358.3,34591,1,4,0)
 ;;=4^I61.6
 ;;^UTILITY(U,$J,358.3,34591,2)
 ;;=^5007286
 ;;^UTILITY(U,$J,358.3,34592,0)
 ;;=G44.1^^160^1761^69
 ;;^UTILITY(U,$J,358.3,34592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34592,1,3,0)
 ;;=3^Vascular headache, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,34592,1,4,0)
 ;;=4^G44.1
 ;;^UTILITY(U,$J,358.3,34592,2)
 ;;=^5003934
 ;;^UTILITY(U,$J,358.3,34593,0)
 ;;=R51.^^160^1761^12
 ;;^UTILITY(U,$J,358.3,34593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34593,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,34593,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,34593,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,34594,0)
 ;;=G03.9^^160^1761^18
 ;;^UTILITY(U,$J,358.3,34594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34594,1,3,0)
 ;;=3^Meningitis, unspecified
 ;;^UTILITY(U,$J,358.3,34594,1,4,0)
 ;;=4^G03.9
 ;;^UTILITY(U,$J,358.3,34594,2)
 ;;=^5003729
 ;;^UTILITY(U,$J,358.3,34595,0)
 ;;=G03.1^^160^1761^8
 ;;^UTILITY(U,$J,358.3,34595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34595,1,3,0)
 ;;=3^Chronic meningitis
 ;;^UTILITY(U,$J,358.3,34595,1,4,0)
 ;;=4^G03.1
 ;;^UTILITY(U,$J,358.3,34595,2)
 ;;=^268382
 ;;^UTILITY(U,$J,358.3,34596,0)
 ;;=G00.9^^160^1761^2
 ;;^UTILITY(U,$J,358.3,34596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34596,1,3,0)
 ;;=3^Bacterial meningitis, unspecified

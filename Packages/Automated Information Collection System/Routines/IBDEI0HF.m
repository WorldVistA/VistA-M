IBDEI0HF ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7582,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,7582,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,7582,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,7583,0)
 ;;=I62.00^^63^495^26
 ;;^UTILITY(U,$J,358.3,7583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7583,1,3,0)
 ;;=3^Nontraumatic Subdural Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,7583,1,4,0)
 ;;=4^I62.00
 ;;^UTILITY(U,$J,358.3,7583,2)
 ;;=^5007289
 ;;^UTILITY(U,$J,358.3,7584,0)
 ;;=C79.31^^63^495^12
 ;;^UTILITY(U,$J,358.3,7584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7584,1,3,0)
 ;;=3^Mets Malig Neop of Brain
 ;;^UTILITY(U,$J,358.3,7584,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,7584,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,7585,0)
 ;;=R40.0^^63^495^30
 ;;^UTILITY(U,$J,358.3,7585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7585,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,7585,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,7585,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,7586,0)
 ;;=R40.1^^63^495^31
 ;;^UTILITY(U,$J,358.3,7586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7586,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,7586,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,7586,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,7587,0)
 ;;=I61.0^^63^495^16
 ;;^UTILITY(U,$J,358.3,7587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7587,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Hemisphere,Subcortical
 ;;^UTILITY(U,$J,358.3,7587,1,4,0)
 ;;=4^I61.0
 ;;^UTILITY(U,$J,358.3,7587,2)
 ;;=^5007280
 ;;^UTILITY(U,$J,358.3,7588,0)
 ;;=I61.1^^63^495^17
 ;;^UTILITY(U,$J,358.3,7588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7588,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Hemisphere,Cortical
 ;;^UTILITY(U,$J,358.3,7588,1,4,0)
 ;;=4^I61.1
 ;;^UTILITY(U,$J,358.3,7588,2)
 ;;=^5007281
 ;;^UTILITY(U,$J,358.3,7589,0)
 ;;=I61.2^^63^495^18
 ;;^UTILITY(U,$J,358.3,7589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7589,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Hemisphere,Unspec
 ;;^UTILITY(U,$J,358.3,7589,1,4,0)
 ;;=4^I61.2
 ;;^UTILITY(U,$J,358.3,7589,2)
 ;;=^5007282
 ;;^UTILITY(U,$J,358.3,7590,0)
 ;;=I61.3^^63^495^19
 ;;^UTILITY(U,$J,358.3,7590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7590,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Brain Stem
 ;;^UTILITY(U,$J,358.3,7590,1,4,0)
 ;;=4^I61.3
 ;;^UTILITY(U,$J,358.3,7590,2)
 ;;=^5007283
 ;;^UTILITY(U,$J,358.3,7591,0)
 ;;=I61.4^^63^495^20
 ;;^UTILITY(U,$J,358.3,7591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7591,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Cerebellum
 ;;^UTILITY(U,$J,358.3,7591,1,4,0)
 ;;=4^I61.4
 ;;^UTILITY(U,$J,358.3,7591,2)
 ;;=^5007284
 ;;^UTILITY(U,$J,358.3,7592,0)
 ;;=I61.5^^63^495^21
 ;;^UTILITY(U,$J,358.3,7592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7592,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Intraventricular
 ;;^UTILITY(U,$J,358.3,7592,1,4,0)
 ;;=4^I61.5
 ;;^UTILITY(U,$J,358.3,7592,2)
 ;;=^5007285
 ;;^UTILITY(U,$J,358.3,7593,0)
 ;;=I61.6^^63^495^22
 ;;^UTILITY(U,$J,358.3,7593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7593,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Mult Localized
 ;;^UTILITY(U,$J,358.3,7593,1,4,0)
 ;;=4^I61.6
 ;;^UTILITY(U,$J,358.3,7593,2)
 ;;=^5007286
 ;;^UTILITY(U,$J,358.3,7594,0)
 ;;=I61.8^^63^495^23
 ;;^UTILITY(U,$J,358.3,7594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7594,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Other

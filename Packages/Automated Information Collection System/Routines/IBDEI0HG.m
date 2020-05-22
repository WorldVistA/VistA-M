IBDEI0HG ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7594,1,4,0)
 ;;=4^I61.8
 ;;^UTILITY(U,$J,358.3,7594,2)
 ;;=^5007287
 ;;^UTILITY(U,$J,358.3,7595,0)
 ;;=I61.9^^63^495^24
 ;;^UTILITY(U,$J,358.3,7595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7595,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,7595,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,7595,2)
 ;;=^5007288
 ;;^UTILITY(U,$J,358.3,7596,0)
 ;;=I62.01^^63^495^13
 ;;^UTILITY(U,$J,358.3,7596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7596,1,3,0)
 ;;=3^Nontraumatic Acute Subdural Hemorrhage
 ;;^UTILITY(U,$J,358.3,7596,1,4,0)
 ;;=4^I62.01
 ;;^UTILITY(U,$J,358.3,7596,2)
 ;;=^5007290
 ;;^UTILITY(U,$J,358.3,7597,0)
 ;;=I62.02^^63^495^25
 ;;^UTILITY(U,$J,358.3,7597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7597,1,3,0)
 ;;=3^Nontraumatic Subacute Subdural Hemorrhage
 ;;^UTILITY(U,$J,358.3,7597,1,4,0)
 ;;=4^I62.02
 ;;^UTILITY(U,$J,358.3,7597,2)
 ;;=^5007291
 ;;^UTILITY(U,$J,358.3,7598,0)
 ;;=I62.03^^63^495^14
 ;;^UTILITY(U,$J,358.3,7598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7598,1,3,0)
 ;;=3^Nontraumatic Chronic Subdural Hemorrhage
 ;;^UTILITY(U,$J,358.3,7598,1,4,0)
 ;;=4^I62.03
 ;;^UTILITY(U,$J,358.3,7598,2)
 ;;=^5007292
 ;;^UTILITY(U,$J,358.3,7599,0)
 ;;=I62.1^^63^495^15
 ;;^UTILITY(U,$J,358.3,7599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7599,1,3,0)
 ;;=3^Nontraumatic Extradural Hemorrhage
 ;;^UTILITY(U,$J,358.3,7599,1,4,0)
 ;;=4^I62.1
 ;;^UTILITY(U,$J,358.3,7599,2)
 ;;=^269743
 ;;^UTILITY(U,$J,358.3,7600,0)
 ;;=K92.2^^63^496^19
 ;;^UTILITY(U,$J,358.3,7600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7600,1,3,0)
 ;;=3^Gastrointestinal Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,7600,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,7600,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,7601,0)
 ;;=K57.31^^63^496^13
 ;;^UTILITY(U,$J,358.3,7601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7601,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/ Bleeding
 ;;^UTILITY(U,$J,358.3,7601,1,4,0)
 ;;=4^K57.31
 ;;^UTILITY(U,$J,358.3,7601,2)
 ;;=^5008724
 ;;^UTILITY(U,$J,358.3,7602,0)
 ;;=K92.1^^63^496^40
 ;;^UTILITY(U,$J,358.3,7602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7602,1,3,0)
 ;;=3^Melena
 ;;^UTILITY(U,$J,358.3,7602,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,7602,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,7603,0)
 ;;=K92.0^^63^496^20
 ;;^UTILITY(U,$J,358.3,7603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7603,1,3,0)
 ;;=3^Hematemesis
 ;;^UTILITY(U,$J,358.3,7603,1,4,0)
 ;;=4^K92.0
 ;;^UTILITY(U,$J,358.3,7603,2)
 ;;=^5008913
 ;;^UTILITY(U,$J,358.3,7604,0)
 ;;=K25.4^^63^496^17
 ;;^UTILITY(U,$J,358.3,7604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7604,1,3,0)
 ;;=3^Gastric Ulcer w/ Hemorrhage,Chronic
 ;;^UTILITY(U,$J,358.3,7604,1,4,0)
 ;;=4^K25.4
 ;;^UTILITY(U,$J,358.3,7604,2)
 ;;=^270076
 ;;^UTILITY(U,$J,358.3,7605,0)
 ;;=K43.2^^63^496^21
 ;;^UTILITY(U,$J,358.3,7605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7605,1,3,0)
 ;;=3^Incisional Hernia w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,7605,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,7605,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,7606,0)
 ;;=K57.32^^63^496^12
 ;;^UTILITY(U,$J,358.3,7606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7606,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,7606,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,7606,2)
 ;;=^5008725

IBDEI0HP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7707,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,7707,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,7707,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,7708,0)
 ;;=I72.4^^63^498^2
 ;;^UTILITY(U,$J,358.3,7708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7708,1,3,0)
 ;;=3^Aneurysm of Lower Extremity Artery
 ;;^UTILITY(U,$J,358.3,7708,1,4,0)
 ;;=4^I72.4
 ;;^UTILITY(U,$J,358.3,7708,2)
 ;;=^269777
 ;;^UTILITY(U,$J,358.3,7709,0)
 ;;=I48.0^^63^498^21
 ;;^UTILITY(U,$J,358.3,7709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7709,1,3,0)
 ;;=3^Atrial Fibrillation,Paroxysmal
 ;;^UTILITY(U,$J,358.3,7709,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,7709,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,7710,0)
 ;;=I48.4^^63^498^23
 ;;^UTILITY(U,$J,358.3,7710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7710,1,3,0)
 ;;=3^Atrial Flutter,Atypical
 ;;^UTILITY(U,$J,358.3,7710,1,4,0)
 ;;=4^I48.4
 ;;^UTILITY(U,$J,358.3,7710,2)
 ;;=^5007228
 ;;^UTILITY(U,$J,358.3,7711,0)
 ;;=I48.3^^63^498^24
 ;;^UTILITY(U,$J,358.3,7711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7711,1,3,0)
 ;;=3^Atrial Flutter,Typical
 ;;^UTILITY(U,$J,358.3,7711,1,4,0)
 ;;=4^I48.3
 ;;^UTILITY(U,$J,358.3,7711,2)
 ;;=^5007227
 ;;^UTILITY(U,$J,358.3,7712,0)
 ;;=I50.31^^63^498^37
 ;;^UTILITY(U,$J,358.3,7712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7712,1,3,0)
 ;;=3^Diastolic Congestive Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,7712,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,7712,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,7713,0)
 ;;=I50.32^^63^498^38
 ;;^UTILITY(U,$J,358.3,7713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7713,1,3,0)
 ;;=3^Diastolic Congestive Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,7713,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,7713,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,7714,0)
 ;;=I16.0^^63^498^52
 ;;^UTILITY(U,$J,358.3,7714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7714,1,3,0)
 ;;=3^Hypertensive Urgency
 ;;^UTILITY(U,$J,358.3,7714,1,4,0)
 ;;=4^I16.0
 ;;^UTILITY(U,$J,358.3,7714,2)
 ;;=^8133013
 ;;^UTILITY(U,$J,358.3,7715,0)
 ;;=I16.1^^63^498^45
 ;;^UTILITY(U,$J,358.3,7715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7715,1,3,0)
 ;;=3^Hypertensive Emergency
 ;;^UTILITY(U,$J,358.3,7715,1,4,0)
 ;;=4^I16.1
 ;;^UTILITY(U,$J,358.3,7715,2)
 ;;=^8204721
 ;;^UTILITY(U,$J,358.3,7716,0)
 ;;=I16.9^^63^498^44
 ;;^UTILITY(U,$J,358.3,7716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7716,1,3,0)
 ;;=3^Hypertensive Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,7716,1,4,0)
 ;;=4^I16.9
 ;;^UTILITY(U,$J,358.3,7716,2)
 ;;=^5138600
 ;;^UTILITY(U,$J,358.3,7717,0)
 ;;=I11.0^^63^498^50
 ;;^UTILITY(U,$J,358.3,7717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7717,1,3,0)
 ;;=3^Hypertensive Hrt Disease w/ CHF
 ;;^UTILITY(U,$J,358.3,7717,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,7717,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,7718,0)
 ;;=I11.9^^63^498^51
 ;;^UTILITY(U,$J,358.3,7718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7718,1,3,0)
 ;;=3^Hypertensive Hrt Disease w/o CHF
 ;;^UTILITY(U,$J,358.3,7718,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,7718,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,7719,0)
 ;;=I13.0^^63^498^48
 ;;^UTILITY(U,$J,358.3,7719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7719,1,3,0)
 ;;=3^Hypertensive Hrt Dis & CKD w/ CHF
 ;;^UTILITY(U,$J,358.3,7719,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,7719,2)
 ;;=^5007067

IBDEI259 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36379,1,3,0)
 ;;=3^AC Combined Systolic & Diastolic Congestive Hrt Failure
 ;;^UTILITY(U,$J,358.3,36379,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,36379,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,36380,0)
 ;;=I50.31^^137^1760^2
 ;;^UTILITY(U,$J,358.3,36380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36380,1,3,0)
 ;;=3^AC Diastolic Congestive Hrt Failure
 ;;^UTILITY(U,$J,358.3,36380,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,36380,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,36381,0)
 ;;=I50.43^^137^1760^4
 ;;^UTILITY(U,$J,358.3,36381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36381,1,3,0)
 ;;=3^AC on Chr Combined Systolic & Diastolic Congestive Hrt Failure
 ;;^UTILITY(U,$J,358.3,36381,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,36381,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,36382,0)
 ;;=I50.33^^137^1760^5
 ;;^UTILITY(U,$J,358.3,36382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36382,1,3,0)
 ;;=3^AC on Chr Diastolic Congestive Hrt Failure
 ;;^UTILITY(U,$J,358.3,36382,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,36382,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,36383,0)
 ;;=I50.23^^137^1760^6
 ;;^UTILITY(U,$J,358.3,36383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36383,1,3,0)
 ;;=3^AC on Chr Systolic Congestive Hrt Failure
 ;;^UTILITY(U,$J,358.3,36383,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,36383,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,36384,0)
 ;;=I50.21^^137^1760^3
 ;;^UTILITY(U,$J,358.3,36384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36384,1,3,0)
 ;;=3^AC Systolic Congestive Hrt Failure
 ;;^UTILITY(U,$J,358.3,36384,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,36384,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,36385,0)
 ;;=I20.9^^137^1760^8
 ;;^UTILITY(U,$J,358.3,36385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36385,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,36385,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,36385,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,36386,0)
 ;;=I25.721^^137^1760^9
 ;;^UTILITY(U,$J,358.3,36386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36386,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Ang Pctrs w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,36386,1,4,0)
 ;;=4^I25.721
 ;;^UTILITY(U,$J,358.3,36386,2)
 ;;=^5007126
 ;;^UTILITY(U,$J,358.3,36387,0)
 ;;=I25.728^^137^1760^10
 ;;^UTILITY(U,$J,358.3,36387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36387,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Ang Pctrs NEC
 ;;^UTILITY(U,$J,358.3,36387,1,4,0)
 ;;=4^I25.728
 ;;^UTILITY(U,$J,358.3,36387,2)
 ;;=^5133560
 ;;^UTILITY(U,$J,358.3,36388,0)
 ;;=I25.729^^137^1760^11
 ;;^UTILITY(U,$J,358.3,36388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36388,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,36388,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,36388,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,36389,0)
 ;;=I25.720^^137^1760^12
 ;;^UTILITY(U,$J,358.3,36389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36389,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,36389,1,4,0)
 ;;=4^I25.720
 ;;^UTILITY(U,$J,358.3,36389,2)
 ;;=^5007125
 ;;^UTILITY(U,$J,358.3,36390,0)
 ;;=I25.711^^137^1760^13
 ;;^UTILITY(U,$J,358.3,36390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36390,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Ang Pctrs w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,36390,1,4,0)
 ;;=4^I25.711
 ;;^UTILITY(U,$J,358.3,36390,2)
 ;;=^5007122
 ;;^UTILITY(U,$J,358.3,36391,0)
 ;;=I25.718^^137^1760^14
 ;;^UTILITY(U,$J,358.3,36391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36391,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Ang Pctrs NEC

IBDEI36X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53584,0)
 ;;=N18.9^^250^2699^10
 ;;^UTILITY(U,$J,358.3,53584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53584,1,3,0)
 ;;=3^Chronic kidney disease, unspecified
 ;;^UTILITY(U,$J,358.3,53584,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,53584,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,53585,0)
 ;;=D50.0^^250^2699^26
 ;;^UTILITY(U,$J,358.3,53585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53585,1,3,0)
 ;;=3^Iron deficiency anemia d/t blood loss (chr)
 ;;^UTILITY(U,$J,358.3,53585,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,53585,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,53586,0)
 ;;=D50.9^^250^2699^27
 ;;^UTILITY(U,$J,358.3,53586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53586,1,3,0)
 ;;=3^Iron deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,53586,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,53586,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,53587,0)
 ;;=D62.^^250^2699^4
 ;;^UTILITY(U,$J,358.3,53587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53587,1,3,0)
 ;;=3^Acute posthemorrhagic anemia
 ;;^UTILITY(U,$J,358.3,53587,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,53587,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,53588,0)
 ;;=D64.9^^250^2699^5
 ;;^UTILITY(U,$J,358.3,53588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53588,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,53588,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,53588,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,53589,0)
 ;;=F03.90^^250^2699^12
 ;;^UTILITY(U,$J,358.3,53589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53589,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,53589,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,53589,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,53590,0)
 ;;=I10.^^250^2699^24
 ;;^UTILITY(U,$J,358.3,53590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53590,1,3,0)
 ;;=3^Hypertension,Essential
 ;;^UTILITY(U,$J,358.3,53590,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,53590,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,53591,0)
 ;;=G45.9^^250^2699^43
 ;;^UTILITY(U,$J,358.3,53591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53591,1,3,0)
 ;;=3^Transient cerebral ischemic attack, unspecified
 ;;^UTILITY(U,$J,358.3,53591,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,53591,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,53592,0)
 ;;=N18.4^^250^2699^9
 ;;^UTILITY(U,$J,358.3,53592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53592,1,3,0)
 ;;=3^Chronic kidney disease, stage 4 (severe)
 ;;^UTILITY(U,$J,358.3,53592,1,4,0)
 ;;=4^N18.4
 ;;^UTILITY(U,$J,358.3,53592,2)
 ;;=^5015605
 ;;^UTILITY(U,$J,358.3,53593,0)
 ;;=R44.3^^250^2699^20
 ;;^UTILITY(U,$J,358.3,53593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53593,1,3,0)
 ;;=3^Hallucinations, unspecified
 ;;^UTILITY(U,$J,358.3,53593,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,53593,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,53594,0)
 ;;=R55.^^250^2699^41
 ;;^UTILITY(U,$J,358.3,53594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53594,1,3,0)
 ;;=3^Syncope and collapse
 ;;^UTILITY(U,$J,358.3,53594,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,53594,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,53595,0)
 ;;=R42.^^250^2699^16
 ;;^UTILITY(U,$J,358.3,53595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53595,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,53595,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,53595,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,53596,0)
 ;;=G47.9^^250^2699^39
 ;;^UTILITY(U,$J,358.3,53596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53596,1,3,0)
 ;;=3^Sleep disorder, unspecified
 ;;^UTILITY(U,$J,358.3,53596,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,53596,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,53597,0)
 ;;=G47.00^^250^2699^25

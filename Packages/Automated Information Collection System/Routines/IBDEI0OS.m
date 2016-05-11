IBDEI0OS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11580,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,11580,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,11580,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,11581,0)
 ;;=G90.01^^47^534^11
 ;;^UTILITY(U,$J,358.3,11581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11581,1,3,0)
 ;;=3^Carotid Sinus Syncope
 ;;^UTILITY(U,$J,358.3,11581,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,11581,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,11582,0)
 ;;=G37.9^^47^534^12
 ;;^UTILITY(U,$J,358.3,11582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11582,1,3,0)
 ;;=3^Central Nervous System Demyelinating Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11582,1,4,0)
 ;;=4^G37.9
 ;;^UTILITY(U,$J,358.3,11582,2)
 ;;=^5003828
 ;;^UTILITY(U,$J,358.3,11583,0)
 ;;=G96.9^^47^534^13
 ;;^UTILITY(U,$J,358.3,11583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11583,1,3,0)
 ;;=3^Central Nervous System Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11583,1,4,0)
 ;;=4^G96.9
 ;;^UTILITY(U,$J,358.3,11583,2)
 ;;=^5004200
 ;;^UTILITY(U,$J,358.3,11584,0)
 ;;=I63.50^^47^534^14
 ;;^UTILITY(U,$J,358.3,11584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11584,1,3,0)
 ;;=3^Cereb infrc due to unsp occls or stenos of unsp cereb artery
 ;;^UTILITY(U,$J,358.3,11584,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,11584,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,11585,0)
 ;;=I67.89^^47^534^36
 ;;^UTILITY(U,$J,358.3,11585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11585,1,3,0)
 ;;=3^Cerebrovascular Disease,Other
 ;;^UTILITY(U,$J,358.3,11585,1,4,0)
 ;;=4^I67.89
 ;;^UTILITY(U,$J,358.3,11585,2)
 ;;=^5007388
 ;;^UTILITY(U,$J,358.3,11586,0)
 ;;=I69.920^^47^534^15
 ;;^UTILITY(U,$J,358.3,11586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11586,1,3,0)
 ;;=3^Cerebrovascular Disease,Aphasia,Unspec
 ;;^UTILITY(U,$J,358.3,11586,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,11586,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,11587,0)
 ;;=I69.990^^47^534^16
 ;;^UTILITY(U,$J,358.3,11587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11587,1,3,0)
 ;;=3^Cerebrovascular Disease,Apraxia,Unspec
 ;;^UTILITY(U,$J,358.3,11587,1,4,0)
 ;;=4^I69.990
 ;;^UTILITY(U,$J,358.3,11587,2)
 ;;=^5007568
 ;;^UTILITY(U,$J,358.3,11588,0)
 ;;=I69.993^^47^534^17
 ;;^UTILITY(U,$J,358.3,11588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11588,1,3,0)
 ;;=3^Cerebrovascular Disease,Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,11588,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,11588,2)
 ;;=^5007571
 ;;^UTILITY(U,$J,358.3,11589,0)
 ;;=I69.91^^47^534^18
 ;;^UTILITY(U,$J,358.3,11589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11589,1,3,0)
 ;;=3^Cerebrovascular Disease,Cognitive Deficits,Unspec
 ;;^UTILITY(U,$J,358.3,11589,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,11589,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,11590,0)
 ;;=I69.922^^47^534^19
 ;;^UTILITY(U,$J,358.3,11590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11590,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysarthria,Unspec
 ;;^UTILITY(U,$J,358.3,11590,1,4,0)
 ;;=4^I69.922
 ;;^UTILITY(U,$J,358.3,11590,2)
 ;;=^5007555
 ;;^UTILITY(U,$J,358.3,11591,0)
 ;;=I69.991^^47^534^20
 ;;^UTILITY(U,$J,358.3,11591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11591,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphagia
 ;;^UTILITY(U,$J,358.3,11591,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,11591,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,11592,0)
 ;;=I69.921^^47^534^21
 ;;^UTILITY(U,$J,358.3,11592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11592,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphasia
 ;;^UTILITY(U,$J,358.3,11592,1,4,0)
 ;;=4^I69.921
 ;;^UTILITY(U,$J,358.3,11592,2)
 ;;=^5007554
 ;;^UTILITY(U,$J,358.3,11593,0)
 ;;=I69.992^^47^534^22

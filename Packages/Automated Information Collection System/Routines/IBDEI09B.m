IBDEI09B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3816,0)
 ;;=G90.01^^28^259^11
 ;;^UTILITY(U,$J,358.3,3816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3816,1,3,0)
 ;;=3^Carotid Sinus Syncope
 ;;^UTILITY(U,$J,358.3,3816,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,3816,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,3817,0)
 ;;=G37.9^^28^259^12
 ;;^UTILITY(U,$J,358.3,3817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3817,1,3,0)
 ;;=3^Central Nervous System Demyelinating Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3817,1,4,0)
 ;;=4^G37.9
 ;;^UTILITY(U,$J,358.3,3817,2)
 ;;=^5003828
 ;;^UTILITY(U,$J,358.3,3818,0)
 ;;=G96.9^^28^259^13
 ;;^UTILITY(U,$J,358.3,3818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3818,1,3,0)
 ;;=3^Central Nervous System Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3818,1,4,0)
 ;;=4^G96.9
 ;;^UTILITY(U,$J,358.3,3818,2)
 ;;=^5004200
 ;;^UTILITY(U,$J,358.3,3819,0)
 ;;=I63.50^^28^259^14
 ;;^UTILITY(U,$J,358.3,3819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3819,1,3,0)
 ;;=3^Cereb infrc due to unsp occls or stenos of unsp cereb artery
 ;;^UTILITY(U,$J,358.3,3819,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,3819,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,3820,0)
 ;;=I67.89^^28^259^36
 ;;^UTILITY(U,$J,358.3,3820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3820,1,3,0)
 ;;=3^Cerebrovascular Disease,Other
 ;;^UTILITY(U,$J,358.3,3820,1,4,0)
 ;;=4^I67.89
 ;;^UTILITY(U,$J,358.3,3820,2)
 ;;=^5007388
 ;;^UTILITY(U,$J,358.3,3821,0)
 ;;=I69.920^^28^259^15
 ;;^UTILITY(U,$J,358.3,3821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3821,1,3,0)
 ;;=3^Cerebrovascular Disease,Aphasia,Unspec
 ;;^UTILITY(U,$J,358.3,3821,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,3821,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,3822,0)
 ;;=I69.990^^28^259^16
 ;;^UTILITY(U,$J,358.3,3822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3822,1,3,0)
 ;;=3^Cerebrovascular Disease,Apraxia,Unspec
 ;;^UTILITY(U,$J,358.3,3822,1,4,0)
 ;;=4^I69.990
 ;;^UTILITY(U,$J,358.3,3822,2)
 ;;=^5007568
 ;;^UTILITY(U,$J,358.3,3823,0)
 ;;=I69.993^^28^259^17
 ;;^UTILITY(U,$J,358.3,3823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3823,1,3,0)
 ;;=3^Cerebrovascular Disease,Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,3823,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,3823,2)
 ;;=^5007571
 ;;^UTILITY(U,$J,358.3,3824,0)
 ;;=I69.91^^28^259^18
 ;;^UTILITY(U,$J,358.3,3824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3824,1,3,0)
 ;;=3^Cerebrovascular Disease,Cognitive Deficits,Unspec
 ;;^UTILITY(U,$J,358.3,3824,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,3824,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,3825,0)
 ;;=I69.922^^28^259^19
 ;;^UTILITY(U,$J,358.3,3825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3825,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysarthria,Unspec
 ;;^UTILITY(U,$J,358.3,3825,1,4,0)
 ;;=4^I69.922
 ;;^UTILITY(U,$J,358.3,3825,2)
 ;;=^5007555
 ;;^UTILITY(U,$J,358.3,3826,0)
 ;;=I69.991^^28^259^20
 ;;^UTILITY(U,$J,358.3,3826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3826,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphagia
 ;;^UTILITY(U,$J,358.3,3826,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,3826,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,3827,0)
 ;;=I69.921^^28^259^21
 ;;^UTILITY(U,$J,358.3,3827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3827,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphasia
 ;;^UTILITY(U,$J,358.3,3827,1,4,0)
 ;;=4^I69.921
 ;;^UTILITY(U,$J,358.3,3827,2)
 ;;=^5007554
 ;;^UTILITY(U,$J,358.3,3828,0)
 ;;=I69.992^^28^259^22
 ;;^UTILITY(U,$J,358.3,3828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3828,1,3,0)
 ;;=3^Cerebrovascular Disease,Facial Weakness
 ;;^UTILITY(U,$J,358.3,3828,1,4,0)
 ;;=4^I69.992

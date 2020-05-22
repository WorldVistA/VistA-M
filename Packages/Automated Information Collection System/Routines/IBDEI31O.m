IBDEI31O ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48616,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,48616,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,48617,0)
 ;;=G37.9^^185^2424^15
 ;;^UTILITY(U,$J,358.3,48617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48617,1,3,0)
 ;;=3^Central Nervous System Demyelinating Disease,Unspec
 ;;^UTILITY(U,$J,358.3,48617,1,4,0)
 ;;=4^G37.9
 ;;^UTILITY(U,$J,358.3,48617,2)
 ;;=^5003828
 ;;^UTILITY(U,$J,358.3,48618,0)
 ;;=G96.9^^185^2424^16
 ;;^UTILITY(U,$J,358.3,48618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48618,1,3,0)
 ;;=3^Central Nervous System Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,48618,1,4,0)
 ;;=4^G96.9
 ;;^UTILITY(U,$J,358.3,48618,2)
 ;;=^5004200
 ;;^UTILITY(U,$J,358.3,48619,0)
 ;;=I63.50^^185^2424^17
 ;;^UTILITY(U,$J,358.3,48619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48619,1,3,0)
 ;;=3^Cereb infrc due to unsp occls or stenos of unsp cereb artery
 ;;^UTILITY(U,$J,358.3,48619,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,48619,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,48620,0)
 ;;=I67.89^^185^2424^38
 ;;^UTILITY(U,$J,358.3,48620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48620,1,3,0)
 ;;=3^Cerebrovascular Disease,Other
 ;;^UTILITY(U,$J,358.3,48620,1,4,0)
 ;;=4^I67.89
 ;;^UTILITY(U,$J,358.3,48620,2)
 ;;=^5007388
 ;;^UTILITY(U,$J,358.3,48621,0)
 ;;=I69.920^^185^2424^18
 ;;^UTILITY(U,$J,358.3,48621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48621,1,3,0)
 ;;=3^Cerebrovascular Disease,Aphasia,Unspec
 ;;^UTILITY(U,$J,358.3,48621,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,48621,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,48622,0)
 ;;=I69.990^^185^2424^19
 ;;^UTILITY(U,$J,358.3,48622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48622,1,3,0)
 ;;=3^Cerebrovascular Disease,Apraxia,Unspec
 ;;^UTILITY(U,$J,358.3,48622,1,4,0)
 ;;=4^I69.990
 ;;^UTILITY(U,$J,358.3,48622,2)
 ;;=^5007568
 ;;^UTILITY(U,$J,358.3,48623,0)
 ;;=I69.993^^185^2424^20
 ;;^UTILITY(U,$J,358.3,48623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48623,1,3,0)
 ;;=3^Cerebrovascular Disease,Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,48623,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,48623,2)
 ;;=^5007571
 ;;^UTILITY(U,$J,358.3,48624,0)
 ;;=I69.922^^185^2424^21
 ;;^UTILITY(U,$J,358.3,48624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48624,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysarthria,Unspec
 ;;^UTILITY(U,$J,358.3,48624,1,4,0)
 ;;=4^I69.922
 ;;^UTILITY(U,$J,358.3,48624,2)
 ;;=^5007555
 ;;^UTILITY(U,$J,358.3,48625,0)
 ;;=I69.991^^185^2424^22
 ;;^UTILITY(U,$J,358.3,48625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48625,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphagia
 ;;^UTILITY(U,$J,358.3,48625,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,48625,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,48626,0)
 ;;=I69.921^^185^2424^23
 ;;^UTILITY(U,$J,358.3,48626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48626,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphasia
 ;;^UTILITY(U,$J,358.3,48626,1,4,0)
 ;;=4^I69.921
 ;;^UTILITY(U,$J,358.3,48626,2)
 ;;=^5007554
 ;;^UTILITY(U,$J,358.3,48627,0)
 ;;=I69.992^^185^2424^24
 ;;^UTILITY(U,$J,358.3,48627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48627,1,3,0)
 ;;=3^Cerebrovascular Disease,Facial Weakness
 ;;^UTILITY(U,$J,358.3,48627,1,4,0)
 ;;=4^I69.992
 ;;^UTILITY(U,$J,358.3,48627,2)
 ;;=^5007570
 ;;^UTILITY(U,$J,358.3,48628,0)
 ;;=I69.923^^185^2424^25
 ;;^UTILITY(U,$J,358.3,48628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48628,1,3,0)
 ;;=3^Cerebrovascular Disease,Fluency Disorder

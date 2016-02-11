IBDEI10W ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17022,1,3,0)
 ;;=3^Brain Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,17022,1,4,0)
 ;;=4^G93.9
 ;;^UTILITY(U,$J,358.3,17022,2)
 ;;=^5004186
 ;;^UTILITY(U,$J,358.3,17023,0)
 ;;=G45.1^^88^857^10
 ;;^UTILITY(U,$J,358.3,17023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17023,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,17023,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,17023,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,17024,0)
 ;;=G90.01^^88^857^11
 ;;^UTILITY(U,$J,358.3,17024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17024,1,3,0)
 ;;=3^Carotid Sinus Syncope
 ;;^UTILITY(U,$J,358.3,17024,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,17024,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,17025,0)
 ;;=G37.9^^88^857^12
 ;;^UTILITY(U,$J,358.3,17025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17025,1,3,0)
 ;;=3^Central Nervous System Demyelinating Disease,Unspec
 ;;^UTILITY(U,$J,358.3,17025,1,4,0)
 ;;=4^G37.9
 ;;^UTILITY(U,$J,358.3,17025,2)
 ;;=^5003828
 ;;^UTILITY(U,$J,358.3,17026,0)
 ;;=G96.9^^88^857^13
 ;;^UTILITY(U,$J,358.3,17026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17026,1,3,0)
 ;;=3^Central Nervous System Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,17026,1,4,0)
 ;;=4^G96.9
 ;;^UTILITY(U,$J,358.3,17026,2)
 ;;=^5004200
 ;;^UTILITY(U,$J,358.3,17027,0)
 ;;=I63.50^^88^857^14
 ;;^UTILITY(U,$J,358.3,17027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17027,1,3,0)
 ;;=3^Cereb infrc due to unsp occls or stenos of unsp cereb artery
 ;;^UTILITY(U,$J,358.3,17027,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,17027,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,17028,0)
 ;;=I67.89^^88^857^36
 ;;^UTILITY(U,$J,358.3,17028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17028,1,3,0)
 ;;=3^Cerebrovascular Disease,Other
 ;;^UTILITY(U,$J,358.3,17028,1,4,0)
 ;;=4^I67.89
 ;;^UTILITY(U,$J,358.3,17028,2)
 ;;=^5007388
 ;;^UTILITY(U,$J,358.3,17029,0)
 ;;=I69.920^^88^857^15
 ;;^UTILITY(U,$J,358.3,17029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17029,1,3,0)
 ;;=3^Cerebrovascular Disease,Aphasia,Unspec
 ;;^UTILITY(U,$J,358.3,17029,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,17029,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,17030,0)
 ;;=I69.990^^88^857^16
 ;;^UTILITY(U,$J,358.3,17030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17030,1,3,0)
 ;;=3^Cerebrovascular Disease,Apraxia,Unspec
 ;;^UTILITY(U,$J,358.3,17030,1,4,0)
 ;;=4^I69.990
 ;;^UTILITY(U,$J,358.3,17030,2)
 ;;=^5007568
 ;;^UTILITY(U,$J,358.3,17031,0)
 ;;=I69.993^^88^857^17
 ;;^UTILITY(U,$J,358.3,17031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17031,1,3,0)
 ;;=3^Cerebrovascular Disease,Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,17031,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,17031,2)
 ;;=^5007571
 ;;^UTILITY(U,$J,358.3,17032,0)
 ;;=I69.91^^88^857^18
 ;;^UTILITY(U,$J,358.3,17032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17032,1,3,0)
 ;;=3^Cerebrovascular Disease,Cognitive Deficits,Unspec
 ;;^UTILITY(U,$J,358.3,17032,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,17032,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,17033,0)
 ;;=I69.922^^88^857^19
 ;;^UTILITY(U,$J,358.3,17033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17033,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysarthria,Unspec
 ;;^UTILITY(U,$J,358.3,17033,1,4,0)
 ;;=4^I69.922
 ;;^UTILITY(U,$J,358.3,17033,2)
 ;;=^5007555
 ;;^UTILITY(U,$J,358.3,17034,0)
 ;;=I69.991^^88^857^20
 ;;^UTILITY(U,$J,358.3,17034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17034,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphagia
 ;;^UTILITY(U,$J,358.3,17034,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,17034,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,17035,0)
 ;;=I69.921^^88^857^21

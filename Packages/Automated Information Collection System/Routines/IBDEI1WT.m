IBDEI1WT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31975,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,31976,0)
 ;;=F03.90^^141^1478^17
 ;;^UTILITY(U,$J,358.3,31976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31976,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,31976,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,31976,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,31977,0)
 ;;=F06.30^^141^1479^2
 ;;^UTILITY(U,$J,358.3,31977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31977,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,31977,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,31977,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,31978,0)
 ;;=F06.31^^141^1479^3
 ;;^UTILITY(U,$J,358.3,31978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31978,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,31978,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,31978,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,31979,0)
 ;;=F06.32^^141^1479^4
 ;;^UTILITY(U,$J,358.3,31979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31979,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,31979,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,31979,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,31980,0)
 ;;=F32.9^^141^1479^14
 ;;^UTILITY(U,$J,358.3,31980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31980,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,31980,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,31980,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,31981,0)
 ;;=F32.0^^141^1479^15
 ;;^UTILITY(U,$J,358.3,31981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31981,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,31981,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,31981,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,31982,0)
 ;;=F32.1^^141^1479^16
 ;;^UTILITY(U,$J,358.3,31982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31982,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,31982,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,31982,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,31983,0)
 ;;=F32.2^^141^1479^17
 ;;^UTILITY(U,$J,358.3,31983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31983,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,31983,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,31983,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,31984,0)
 ;;=F32.3^^141^1479^18
 ;;^UTILITY(U,$J,358.3,31984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31984,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,31984,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,31984,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,31985,0)
 ;;=F32.4^^141^1479^19
 ;;^UTILITY(U,$J,358.3,31985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31985,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,31985,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,31985,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,31986,0)
 ;;=F32.5^^141^1479^20
 ;;^UTILITY(U,$J,358.3,31986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31986,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,31986,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,31986,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,31987,0)
 ;;=F33.9^^141^1479^13
 ;;^UTILITY(U,$J,358.3,31987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31987,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,31987,1,4,0)
 ;;=4^F33.9

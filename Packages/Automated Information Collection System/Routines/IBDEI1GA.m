IBDEI1GA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24640,0)
 ;;=G20.^^93^1094^29
 ;;^UTILITY(U,$J,358.3,24640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24640,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,24640,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,24640,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,24641,0)
 ;;=G23.1^^93^1094^34
 ;;^UTILITY(U,$J,358.3,24641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24641,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,24641,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,24641,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,24642,0)
 ;;=F03.91^^93^1094^15
 ;;^UTILITY(U,$J,358.3,24642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24642,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,24642,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,24642,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,24643,0)
 ;;=F03.90^^93^1094^17
 ;;^UTILITY(U,$J,358.3,24643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24643,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,24643,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,24643,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,24644,0)
 ;;=F06.30^^93^1095^2
 ;;^UTILITY(U,$J,358.3,24644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24644,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,24644,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,24644,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,24645,0)
 ;;=F06.31^^93^1095^3
 ;;^UTILITY(U,$J,358.3,24645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24645,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,24645,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,24645,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,24646,0)
 ;;=F06.32^^93^1095^4
 ;;^UTILITY(U,$J,358.3,24646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24646,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,24646,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,24646,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,24647,0)
 ;;=F32.9^^93^1095^20
 ;;^UTILITY(U,$J,358.3,24647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24647,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,24647,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,24647,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,24648,0)
 ;;=F32.0^^93^1095^17
 ;;^UTILITY(U,$J,358.3,24648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24648,1,3,0)
 ;;=3^MDD,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,24648,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,24648,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,24649,0)
 ;;=F32.1^^93^1095^18
 ;;^UTILITY(U,$J,358.3,24649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24649,1,3,0)
 ;;=3^MDD,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,24649,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,24649,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,24650,0)
 ;;=F32.2^^93^1095^19
 ;;^UTILITY(U,$J,358.3,24650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24650,1,3,0)
 ;;=3^MDD,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,24650,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,24650,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,24651,0)
 ;;=F32.3^^93^1095^14
 ;;^UTILITY(U,$J,358.3,24651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24651,1,3,0)
 ;;=3^MDD,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,24651,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,24651,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,24652,0)
 ;;=F32.4^^93^1095^16
 ;;^UTILITY(U,$J,358.3,24652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24652,1,3,0)
 ;;=3^MDD,Single Episode,In Partial Remission

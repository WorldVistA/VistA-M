IBDEI023 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,203,0)
 ;;=G20.^^3^27^28
 ;;^UTILITY(U,$J,358.3,203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,203,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,203,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,203,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,204,0)
 ;;=G20.^^3^27^29
 ;;^UTILITY(U,$J,358.3,204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,204,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=G23.1^^3^27^34
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=F03.91^^3^27^15
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=F03.90^^3^27^17
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=F06.30^^3^28^2
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=F06.31^^3^28^3
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=F06.32^^3^28^4
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=F32.9^^3^28^14
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=F32.0^^3^28^15
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=F32.1^^3^28^16
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=F32.2^^3^28^17
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=F32.3^^3^28^18
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features

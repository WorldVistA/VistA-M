IBDEI01J ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,217,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,217,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,218,0)
 ;;=G20.^^3^27^28
 ;;^UTILITY(U,$J,358.3,218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,218,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,218,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,218,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,219,0)
 ;;=G20.^^3^27^29
 ;;^UTILITY(U,$J,358.3,219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,219,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,219,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,219,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,220,0)
 ;;=G23.1^^3^27^34
 ;;^UTILITY(U,$J,358.3,220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,220,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,220,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,220,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,221,0)
 ;;=F03.91^^3^27^15
 ;;^UTILITY(U,$J,358.3,221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,221,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,221,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,221,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,222,0)
 ;;=F03.90^^3^27^17
 ;;^UTILITY(U,$J,358.3,222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,222,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,222,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,222,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,223,0)
 ;;=F06.30^^3^28^2
 ;;^UTILITY(U,$J,358.3,223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,223,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,223,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,223,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,224,0)
 ;;=F06.31^^3^28^3
 ;;^UTILITY(U,$J,358.3,224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,224,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,224,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,224,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,225,0)
 ;;=F06.32^^3^28^4
 ;;^UTILITY(U,$J,358.3,225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,225,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,225,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,225,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,226,0)
 ;;=F32.9^^3^28^20
 ;;^UTILITY(U,$J,358.3,226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,226,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,226,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,226,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,227,0)
 ;;=F32.0^^3^28^17
 ;;^UTILITY(U,$J,358.3,227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,227,1,3,0)
 ;;=3^MDD,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,227,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,227,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,228,0)
 ;;=F32.1^^3^28^18
 ;;^UTILITY(U,$J,358.3,228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,228,1,3,0)
 ;;=3^MDD,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,228,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,228,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,229,0)
 ;;=F32.2^^3^28^19
 ;;^UTILITY(U,$J,358.3,229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,229,1,3,0)
 ;;=3^MDD,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,229,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,229,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,230,0)
 ;;=F32.3^^3^28^14
 ;;^UTILITY(U,$J,358.3,230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,230,1,3,0)
 ;;=3^MDD,Single Episode w Psychotic Features

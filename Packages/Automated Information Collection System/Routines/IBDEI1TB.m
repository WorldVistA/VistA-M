IBDEI1TB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30790,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,30790,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,30790,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,30791,0)
 ;;=F19.97^^123^1533^35
 ;;^UTILITY(U,$J,358.3,30791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30791,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,30791,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,30791,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,30792,0)
 ;;=G20.^^123^1533^28
 ;;^UTILITY(U,$J,358.3,30792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30792,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,30792,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,30792,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,30793,0)
 ;;=G20.^^123^1533^29
 ;;^UTILITY(U,$J,358.3,30793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30793,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,30793,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,30793,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,30794,0)
 ;;=G23.1^^123^1533^34
 ;;^UTILITY(U,$J,358.3,30794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30794,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,30794,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,30794,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,30795,0)
 ;;=F03.91^^123^1533^15
 ;;^UTILITY(U,$J,358.3,30795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30795,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,30795,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,30795,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,30796,0)
 ;;=F03.90^^123^1533^17
 ;;^UTILITY(U,$J,358.3,30796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30796,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,30796,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,30796,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,30797,0)
 ;;=F06.30^^123^1534^2
 ;;^UTILITY(U,$J,358.3,30797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30797,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,30797,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,30797,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,30798,0)
 ;;=F06.31^^123^1534^3
 ;;^UTILITY(U,$J,358.3,30798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30798,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,30798,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,30798,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,30799,0)
 ;;=F06.32^^123^1534^4
 ;;^UTILITY(U,$J,358.3,30799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30799,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,30799,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,30799,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,30800,0)
 ;;=F32.9^^123^1534^20
 ;;^UTILITY(U,$J,358.3,30800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30800,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,30800,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,30800,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,30801,0)
 ;;=F32.0^^123^1534^17
 ;;^UTILITY(U,$J,358.3,30801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30801,1,3,0)
 ;;=3^MDD,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,30801,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,30801,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,30802,0)
 ;;=F32.1^^123^1534^18
 ;;^UTILITY(U,$J,358.3,30802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30802,1,3,0)
 ;;=3^MDD,Single Episode,Moderate

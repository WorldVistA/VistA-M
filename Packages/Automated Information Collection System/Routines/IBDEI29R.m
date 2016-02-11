IBDEI29R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38107,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,38107,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,38107,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,38108,0)
 ;;=G30.8^^177^1918^2
 ;;^UTILITY(U,$J,358.3,38108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38108,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,38108,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,38108,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,38109,0)
 ;;=A81.89^^177^1918^6
 ;;^UTILITY(U,$J,358.3,38109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38109,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,38109,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,38109,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,38110,0)
 ;;=F19.97^^177^1918^35
 ;;^UTILITY(U,$J,358.3,38110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38110,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,38110,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,38110,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,38111,0)
 ;;=G20.^^177^1918^28
 ;;^UTILITY(U,$J,358.3,38111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38111,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38111,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,38111,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,38112,0)
 ;;=G20.^^177^1918^29
 ;;^UTILITY(U,$J,358.3,38112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38112,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,38112,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,38112,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,38113,0)
 ;;=G23.1^^177^1918^34
 ;;^UTILITY(U,$J,358.3,38113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38113,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,38113,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,38113,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,38114,0)
 ;;=F03.91^^177^1918^15
 ;;^UTILITY(U,$J,358.3,38114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38114,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,38114,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,38114,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,38115,0)
 ;;=F03.90^^177^1918^17
 ;;^UTILITY(U,$J,358.3,38115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38115,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,38115,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,38115,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,38116,0)
 ;;=F06.30^^177^1919^2
 ;;^UTILITY(U,$J,358.3,38116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38116,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,38116,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,38116,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,38117,0)
 ;;=F06.31^^177^1919^3
 ;;^UTILITY(U,$J,358.3,38117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38117,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,38117,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,38117,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,38118,0)
 ;;=F06.32^^177^1919^4
 ;;^UTILITY(U,$J,358.3,38118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38118,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,38118,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,38118,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,38119,0)
 ;;=F32.9^^177^1919^14
 ;;^UTILITY(U,$J,358.3,38119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38119,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec

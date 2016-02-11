IBDEI1ZO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33306,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,33306,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,33307,0)
 ;;=G10.^^148^1635^20
 ;;^UTILITY(U,$J,358.3,33307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33307,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,33307,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,33307,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,33308,0)
 ;;=G10.^^148^1635^21
 ;;^UTILITY(U,$J,358.3,33308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33308,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,33308,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,33308,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,33309,0)
 ;;=G90.3^^148^1635^25
 ;;^UTILITY(U,$J,358.3,33309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33309,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,33309,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,33309,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,33310,0)
 ;;=G91.2^^148^1635^26
 ;;^UTILITY(U,$J,358.3,33310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33310,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,33310,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,33310,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,33311,0)
 ;;=G91.2^^148^1635^27
 ;;^UTILITY(U,$J,358.3,33311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33311,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavorial Disturbances
 ;;^UTILITY(U,$J,358.3,33311,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,33311,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,33312,0)
 ;;=G30.8^^148^1635^2
 ;;^UTILITY(U,$J,358.3,33312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33312,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,33312,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,33312,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,33313,0)
 ;;=A81.89^^148^1635^6
 ;;^UTILITY(U,$J,358.3,33313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33313,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,33313,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,33313,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,33314,0)
 ;;=F19.97^^148^1635^35
 ;;^UTILITY(U,$J,358.3,33314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33314,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,33314,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,33314,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,33315,0)
 ;;=G20.^^148^1635^28
 ;;^UTILITY(U,$J,358.3,33315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33315,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,33315,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,33315,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,33316,0)
 ;;=G20.^^148^1635^29
 ;;^UTILITY(U,$J,358.3,33316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33316,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,33316,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,33316,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,33317,0)
 ;;=G23.1^^148^1635^34
 ;;^UTILITY(U,$J,358.3,33317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33317,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,33317,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,33317,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,33318,0)
 ;;=F03.91^^148^1635^15
 ;;^UTILITY(U,$J,358.3,33318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33318,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,33318,1,4,0)
 ;;=4^F03.91

IBDEI22S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35189,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,35189,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,35189,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,35190,0)
 ;;=G31.83^^131^1700^14
 ;;^UTILITY(U,$J,358.3,35190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35190,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,35190,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,35190,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,35191,0)
 ;;=F01.51^^131^1700^30
 ;;^UTILITY(U,$J,358.3,35191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35191,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,35191,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,35191,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,35192,0)
 ;;=F01.50^^131^1700^31
 ;;^UTILITY(U,$J,358.3,35192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35192,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,35192,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,35192,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,35193,0)
 ;;=A81.9^^131^1700^6
 ;;^UTILITY(U,$J,358.3,35193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35193,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,35193,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,35193,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,35194,0)
 ;;=A81.09^^131^1700^8
 ;;^UTILITY(U,$J,358.3,35194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35194,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,35194,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,35194,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,35195,0)
 ;;=A81.00^^131^1700^9
 ;;^UTILITY(U,$J,358.3,35195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35195,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,35195,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,35195,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,35196,0)
 ;;=A81.01^^131^1700^10
 ;;^UTILITY(U,$J,358.3,35196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35196,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,35196,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,35196,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,35197,0)
 ;;=A81.89^^131^1700^7
 ;;^UTILITY(U,$J,358.3,35197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35197,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,35197,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,35197,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,35198,0)
 ;;=A81.2^^131^1700^27
 ;;^UTILITY(U,$J,358.3,35198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35198,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,35198,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,35198,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,35199,0)
 ;;=B20.^^131^1700^17
 ;;^UTILITY(U,$J,358.3,35199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35199,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,35199,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,35199,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,35200,0)
 ;;=B20.^^131^1700^18
 ;;^UTILITY(U,$J,358.3,35200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35200,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,35200,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,35200,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,35201,0)
 ;;=F10.27^^131^1700^1
 ;;^UTILITY(U,$J,358.3,35201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35201,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,35201,1,4,0)
 ;;=4^F10.27

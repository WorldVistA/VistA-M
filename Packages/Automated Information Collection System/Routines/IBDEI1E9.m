IBDEI1E9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23680,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,23680,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,23680,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,23681,0)
 ;;=F01.51^^87^1001^30
 ;;^UTILITY(U,$J,358.3,23681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23681,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23681,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,23681,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,23682,0)
 ;;=F01.50^^87^1001^31
 ;;^UTILITY(U,$J,358.3,23682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23682,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23682,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,23682,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,23683,0)
 ;;=A81.9^^87^1001^6
 ;;^UTILITY(U,$J,358.3,23683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23683,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,23683,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,23683,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,23684,0)
 ;;=A81.09^^87^1001^8
 ;;^UTILITY(U,$J,358.3,23684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23684,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,23684,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,23684,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,23685,0)
 ;;=A81.00^^87^1001^9
 ;;^UTILITY(U,$J,358.3,23685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23685,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23685,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,23685,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,23686,0)
 ;;=A81.01^^87^1001^10
 ;;^UTILITY(U,$J,358.3,23686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23686,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,23686,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,23686,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,23687,0)
 ;;=A81.89^^87^1001^7
 ;;^UTILITY(U,$J,358.3,23687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23687,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,23687,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,23687,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,23688,0)
 ;;=A81.2^^87^1001^27
 ;;^UTILITY(U,$J,358.3,23688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23688,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,23688,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,23688,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,23689,0)
 ;;=B20.^^87^1001^17
 ;;^UTILITY(U,$J,358.3,23689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23689,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23689,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,23689,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,23690,0)
 ;;=B20.^^87^1001^18
 ;;^UTILITY(U,$J,358.3,23690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23690,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,23690,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,23690,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,23691,0)
 ;;=F10.27^^87^1001^1
 ;;^UTILITY(U,$J,358.3,23691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23691,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,23691,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,23691,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,23692,0)
 ;;=F19.97^^87^1001^29
 ;;^UTILITY(U,$J,358.3,23692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23692,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,23692,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,23692,2)
 ;;=^5003465

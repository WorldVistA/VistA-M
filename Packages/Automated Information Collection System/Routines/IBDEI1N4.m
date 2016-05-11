IBDEI1N4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27840,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,27840,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,27840,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,27841,0)
 ;;=A81.00^^109^1388^12
 ;;^UTILITY(U,$J,358.3,27841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27841,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,27841,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,27841,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,27842,0)
 ;;=A81.01^^109^1388^13
 ;;^UTILITY(U,$J,358.3,27842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27842,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,27842,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,27842,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,27843,0)
 ;;=A81.89^^109^1388^7
 ;;^UTILITY(U,$J,358.3,27843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27843,1,3,0)
 ;;=3^Atypical Virus Infection of CNS NEC
 ;;^UTILITY(U,$J,358.3,27843,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,27843,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,27844,0)
 ;;=A81.2^^109^1388^33
 ;;^UTILITY(U,$J,358.3,27844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27844,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,27844,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,27844,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,27845,0)
 ;;=B20.^^109^1388^20
 ;;^UTILITY(U,$J,358.3,27845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27845,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27845,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,27845,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,27846,0)
 ;;=B20.^^109^1388^21
 ;;^UTILITY(U,$J,358.3,27846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27846,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27846,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,27846,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,27847,0)
 ;;=F10.27^^109^1388^1
 ;;^UTILITY(U,$J,358.3,27847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27847,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,27847,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,27847,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,27848,0)
 ;;=F02.81^^109^1388^14
 ;;^UTILITY(U,$J,358.3,27848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27848,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturb
 ;;^UTILITY(U,$J,358.3,27848,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,27848,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,27849,0)
 ;;=F02.80^^109^1388^15
 ;;^UTILITY(U,$J,358.3,27849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27849,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27849,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,27849,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,27850,0)
 ;;=F19.97^^109^1388^35
 ;;^UTILITY(U,$J,358.3,27850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27850,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,27850,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,27850,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,27851,0)
 ;;=F01.51^^109^1388^37
 ;;^UTILITY(U,$J,358.3,27851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27851,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,27851,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,27851,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,27852,0)
 ;;=G10.^^109^1388^24
 ;;^UTILITY(U,$J,358.3,27852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27852,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances

IBDEI1E7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23233,1,3,0)
 ;;=3^Vascular Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23233,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,23233,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,23234,0)
 ;;=A81.9^^110^1107^6
 ;;^UTILITY(U,$J,358.3,23234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23234,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,23234,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,23234,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,23235,0)
 ;;=A81.09^^110^1107^8
 ;;^UTILITY(U,$J,358.3,23235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23235,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,23235,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,23235,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,23236,0)
 ;;=A81.00^^110^1107^9
 ;;^UTILITY(U,$J,358.3,23236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23236,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23236,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,23236,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,23237,0)
 ;;=A81.01^^110^1107^10
 ;;^UTILITY(U,$J,358.3,23237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23237,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,23237,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,23237,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,23238,0)
 ;;=A81.89^^110^1107^7
 ;;^UTILITY(U,$J,358.3,23238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23238,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,23238,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,23238,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,23239,0)
 ;;=A81.2^^110^1107^27
 ;;^UTILITY(U,$J,358.3,23239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23239,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,23239,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,23239,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,23240,0)
 ;;=B20.^^110^1107^17
 ;;^UTILITY(U,$J,358.3,23240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23240,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,23240,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,23240,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,23241,0)
 ;;=B20.^^110^1107^18
 ;;^UTILITY(U,$J,358.3,23241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23241,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23241,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,23241,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,23242,0)
 ;;=F10.27^^110^1107^1
 ;;^UTILITY(U,$J,358.3,23242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23242,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,23242,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,23242,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,23243,0)
 ;;=F19.97^^110^1107^29
 ;;^UTILITY(U,$J,358.3,23243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23243,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,23243,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,23243,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,23244,0)
 ;;=G30.0^^110^1107^2
 ;;^UTILITY(U,$J,358.3,23244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23244,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,23244,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,23244,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,23245,0)
 ;;=G30.1^^110^1107^3
 ;;^UTILITY(U,$J,358.3,23245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23245,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,23245,1,4,0)
 ;;=4^G30.1

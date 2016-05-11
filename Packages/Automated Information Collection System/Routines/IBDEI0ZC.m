IBDEI0ZC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16609,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,16609,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,16609,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,16610,0)
 ;;=A81.00^^67^769^9
 ;;^UTILITY(U,$J,358.3,16610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16610,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16610,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,16610,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,16611,0)
 ;;=A81.01^^67^769^10
 ;;^UTILITY(U,$J,358.3,16611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16611,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,16611,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,16611,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,16612,0)
 ;;=A81.89^^67^769^7
 ;;^UTILITY(U,$J,358.3,16612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16612,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,16612,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,16612,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,16613,0)
 ;;=A81.2^^67^769^27
 ;;^UTILITY(U,$J,358.3,16613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16613,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,16613,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,16613,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,16614,0)
 ;;=B20.^^67^769^17
 ;;^UTILITY(U,$J,358.3,16614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16614,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16614,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,16614,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,16615,0)
 ;;=B20.^^67^769^18
 ;;^UTILITY(U,$J,358.3,16615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16615,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,16615,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,16615,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,16616,0)
 ;;=F10.27^^67^769^1
 ;;^UTILITY(U,$J,358.3,16616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16616,1,3,0)
 ;;=3^Alc Dep w/ Alc-Induced Persist Dementia
 ;;^UTILITY(U,$J,358.3,16616,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,16616,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,16617,0)
 ;;=F19.97^^67^769^29
 ;;^UTILITY(U,$J,358.3,16617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16617,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,16617,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,16617,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,16618,0)
 ;;=G30.0^^67^769^2
 ;;^UTILITY(U,$J,358.3,16618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16618,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,16618,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,16618,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,16619,0)
 ;;=G30.1^^67^769^3
 ;;^UTILITY(U,$J,358.3,16619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16619,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,16619,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,16619,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,16620,0)
 ;;=G30.9^^67^769^4
 ;;^UTILITY(U,$J,358.3,16620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16620,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,16620,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,16620,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,16621,0)
 ;;=G10.^^67^769^19
 ;;^UTILITY(U,$J,358.3,16621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16621,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,16621,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,16621,2)
 ;;=^5003751^F02.81

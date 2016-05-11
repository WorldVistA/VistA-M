IBDEI0H0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7860,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,7861,0)
 ;;=F02.81^^30^416^11
 ;;^UTILITY(U,$J,358.3,7861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7861,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7861,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,7861,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,7862,0)
 ;;=F02.80^^30^416^12
 ;;^UTILITY(U,$J,358.3,7862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7862,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7862,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,7862,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,7863,0)
 ;;=F03.91^^30^416^13
 ;;^UTILITY(U,$J,358.3,7863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7863,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,7863,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,7863,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,7864,0)
 ;;=G31.83^^30^416^14
 ;;^UTILITY(U,$J,358.3,7864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7864,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,7864,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,7864,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,7865,0)
 ;;=F01.51^^30^416^30
 ;;^UTILITY(U,$J,358.3,7865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7865,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7865,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,7865,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,7866,0)
 ;;=F01.50^^30^416^31
 ;;^UTILITY(U,$J,358.3,7866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7866,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,7866,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,7866,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,7867,0)
 ;;=A81.9^^30^416^6
 ;;^UTILITY(U,$J,358.3,7867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7867,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,7867,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,7867,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,7868,0)
 ;;=A81.09^^30^416^8
 ;;^UTILITY(U,$J,358.3,7868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7868,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,7868,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,7868,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,7869,0)
 ;;=A81.00^^30^416^9
 ;;^UTILITY(U,$J,358.3,7869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7869,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7869,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,7869,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,7870,0)
 ;;=A81.01^^30^416^10
 ;;^UTILITY(U,$J,358.3,7870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7870,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,7870,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,7870,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,7871,0)
 ;;=A81.89^^30^416^7
 ;;^UTILITY(U,$J,358.3,7871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7871,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,7871,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,7871,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,7872,0)
 ;;=A81.2^^30^416^27
 ;;^UTILITY(U,$J,358.3,7872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7872,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,7872,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,7872,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,7873,0)
 ;;=B20.^^30^416^17
 ;;^UTILITY(U,$J,358.3,7873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7873,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances

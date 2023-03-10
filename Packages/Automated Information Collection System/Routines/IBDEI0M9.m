IBDEI0M9 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10006,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10006,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,10006,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,10007,0)
 ;;=F02.80^^39^421^12
 ;;^UTILITY(U,$J,358.3,10007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10007,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10007,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,10007,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,10008,0)
 ;;=F03.91^^39^421^13
 ;;^UTILITY(U,$J,358.3,10008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10008,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,10008,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,10008,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,10009,0)
 ;;=G31.83^^39^421^14
 ;;^UTILITY(U,$J,358.3,10009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10009,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,10009,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,10009,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,10010,0)
 ;;=F01.51^^39^421^30
 ;;^UTILITY(U,$J,358.3,10010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10010,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10010,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,10010,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,10011,0)
 ;;=F01.50^^39^421^31
 ;;^UTILITY(U,$J,358.3,10011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10011,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10011,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,10011,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,10012,0)
 ;;=A81.9^^39^421^6
 ;;^UTILITY(U,$J,358.3,10012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10012,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,10012,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,10012,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,10013,0)
 ;;=A81.09^^39^421^8
 ;;^UTILITY(U,$J,358.3,10013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10013,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,10013,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,10013,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,10014,0)
 ;;=A81.00^^39^421^9
 ;;^UTILITY(U,$J,358.3,10014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10014,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,10014,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,10014,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,10015,0)
 ;;=A81.01^^39^421^10
 ;;^UTILITY(U,$J,358.3,10015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10015,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,10015,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,10015,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,10016,0)
 ;;=A81.89^^39^421^7
 ;;^UTILITY(U,$J,358.3,10016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10016,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,10016,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,10016,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,10017,0)
 ;;=A81.2^^39^421^27
 ;;^UTILITY(U,$J,358.3,10017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10017,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,10017,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,10017,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,10018,0)
 ;;=B20.^^39^421^17

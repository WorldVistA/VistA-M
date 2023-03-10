IBDEI0MA ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10018,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10018,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10018,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,10019,0)
 ;;=B20.^^39^421^18
 ;;^UTILITY(U,$J,358.3,10019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10019,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10019,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10019,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,10020,0)
 ;;=F10.27^^39^421^1
 ;;^UTILITY(U,$J,358.3,10020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10020,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,10020,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,10020,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,10021,0)
 ;;=F19.97^^39^421^29
 ;;^UTILITY(U,$J,358.3,10021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10021,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,10021,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,10021,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,10022,0)
 ;;=F03.90^^39^421^15
 ;;^UTILITY(U,$J,358.3,10022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10022,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,10022,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,10022,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,10023,0)
 ;;=G30.0^^39^421^2
 ;;^UTILITY(U,$J,358.3,10023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10023,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,10023,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,10023,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,10024,0)
 ;;=G30.1^^39^421^3
 ;;^UTILITY(U,$J,358.3,10024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10024,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,10024,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,10024,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,10025,0)
 ;;=G30.9^^39^421^4
 ;;^UTILITY(U,$J,358.3,10025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10025,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,10025,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,10025,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,10026,0)
 ;;=G10.^^39^421^19
 ;;^UTILITY(U,$J,358.3,10026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10026,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,10026,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,10026,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,10027,0)
 ;;=G10.^^39^421^20
 ;;^UTILITY(U,$J,358.3,10027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10027,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10027,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,10027,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,10028,0)
 ;;=G90.3^^39^421^21
 ;;^UTILITY(U,$J,358.3,10028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10028,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,10028,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,10028,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,10029,0)
 ;;=G91.2^^39^421^22
 ;;^UTILITY(U,$J,358.3,10029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10029,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10029,1,4,0)
 ;;=4^G91.2

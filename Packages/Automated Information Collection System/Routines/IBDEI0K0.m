IBDEI0K0 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9002,0)
 ;;=K74.00^^39^404^16
 ;;^UTILITY(U,$J,358.3,9002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9002,1,3,0)
 ;;=3^Hepatic Fibrosis,Unspec
 ;;^UTILITY(U,$J,358.3,9002,1,4,0)
 ;;=4^K74.00
 ;;^UTILITY(U,$J,358.3,9002,2)
 ;;=^5159218
 ;;^UTILITY(U,$J,358.3,9003,0)
 ;;=K74.01^^39^404^15
 ;;^UTILITY(U,$J,358.3,9003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9003,1,3,0)
 ;;=3^Hepatic Fibrosis,Early Fibrosis
 ;;^UTILITY(U,$J,358.3,9003,1,4,0)
 ;;=4^K74.01
 ;;^UTILITY(U,$J,358.3,9003,2)
 ;;=^5159219
 ;;^UTILITY(U,$J,358.3,9004,0)
 ;;=K74.02^^39^404^14
 ;;^UTILITY(U,$J,358.3,9004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9004,1,3,0)
 ;;=3^Hepatic Fibrosis,Advanced Fibrosis
 ;;^UTILITY(U,$J,358.3,9004,1,4,0)
 ;;=4^K74.02
 ;;^UTILITY(U,$J,358.3,9004,2)
 ;;=^5159220
 ;;^UTILITY(U,$J,358.3,9005,0)
 ;;=F20.3^^39^405^31
 ;;^UTILITY(U,$J,358.3,9005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9005,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,9005,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,9005,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,9006,0)
 ;;=F20.9^^39^405^27
 ;;^UTILITY(U,$J,358.3,9006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9006,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,9006,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,9006,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,9007,0)
 ;;=F31.9^^39^405^6
 ;;^UTILITY(U,$J,358.3,9007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9007,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,9007,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,9007,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,9008,0)
 ;;=F31.72^^39^405^7
 ;;^UTILITY(U,$J,358.3,9008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9008,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,9008,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,9008,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,9009,0)
 ;;=F31.71^^39^405^5
 ;;^UTILITY(U,$J,358.3,9009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9009,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,9009,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,9009,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,9010,0)
 ;;=F31.70^^39^405^4
 ;;^UTILITY(U,$J,358.3,9010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9010,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,9010,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,9010,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,9011,0)
 ;;=F29.^^39^405^25
 ;;^UTILITY(U,$J,358.3,9011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9011,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,9011,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,9011,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,9012,0)
 ;;=F28.^^39^405^26
 ;;^UTILITY(U,$J,358.3,9012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9012,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,9012,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,9012,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,9013,0)
 ;;=F41.9^^39^405^3
 ;;^UTILITY(U,$J,358.3,9013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9013,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,9013,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,9013,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,9014,0)
 ;;=F45.0^^39^405^29
 ;;^UTILITY(U,$J,358.3,9014,1,0)
 ;;=^358.31IA^4^2

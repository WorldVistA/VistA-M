IBDEI0NZ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10790,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,10790,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,10791,0)
 ;;=Z62.29^^42^487^8
 ;;^UTILITY(U,$J,358.3,10791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10791,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,10791,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,10791,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,10792,0)
 ;;=F20.9^^42^488^11
 ;;^UTILITY(U,$J,358.3,10792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10792,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,10792,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,10792,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,10793,0)
 ;;=F20.81^^42^488^14
 ;;^UTILITY(U,$J,358.3,10793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10793,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,10793,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,10793,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,10794,0)
 ;;=F22.^^42^488^5
 ;;^UTILITY(U,$J,358.3,10794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10794,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,10794,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,10794,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,10795,0)
 ;;=F23.^^42^488^1
 ;;^UTILITY(U,$J,358.3,10795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10795,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,10795,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,10795,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,10796,0)
 ;;=F25.0^^42^488^9
 ;;^UTILITY(U,$J,358.3,10796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10796,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,10796,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,10796,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,10797,0)
 ;;=F25.1^^42^488^10
 ;;^UTILITY(U,$J,358.3,10797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10797,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,10797,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,10797,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,10798,0)
 ;;=F28.^^42^488^12
 ;;^UTILITY(U,$J,358.3,10798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10798,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,10798,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,10798,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,10799,0)
 ;;=F29.^^42^488^13
 ;;^UTILITY(U,$J,358.3,10799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10799,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10799,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,10799,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,10800,0)
 ;;=F06.1^^42^488^2
 ;;^UTILITY(U,$J,358.3,10800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10800,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,10800,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,10800,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,10801,0)
 ;;=F06.1^^42^488^4
 ;;^UTILITY(U,$J,358.3,10801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10801,1,3,0)
 ;;=3^Catatonic Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,10801,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,10801,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,10802,0)
 ;;=F06.1^^42^488^3
 ;;^UTILITY(U,$J,358.3,10802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10802,1,3,0)
 ;;=3^Catatonia,Unspec
 ;;^UTILITY(U,$J,358.3,10802,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,10802,2)
 ;;=^5003054

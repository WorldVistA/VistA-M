IBDEI1B9 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20956,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,20956,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,20957,0)
 ;;=Z63.4^^95^1039^7
 ;;^UTILITY(U,$J,358.3,20957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20957,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,20957,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,20957,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,20958,0)
 ;;=Z62.29^^95^1039^8
 ;;^UTILITY(U,$J,358.3,20958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20958,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,20958,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,20958,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,20959,0)
 ;;=F20.9^^95^1040^11
 ;;^UTILITY(U,$J,358.3,20959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20959,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,20959,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,20959,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,20960,0)
 ;;=F20.81^^95^1040^14
 ;;^UTILITY(U,$J,358.3,20960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20960,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,20960,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,20960,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,20961,0)
 ;;=F22.^^95^1040^5
 ;;^UTILITY(U,$J,358.3,20961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20961,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,20961,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,20961,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,20962,0)
 ;;=F23.^^95^1040^1
 ;;^UTILITY(U,$J,358.3,20962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20962,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,20962,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,20962,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,20963,0)
 ;;=F25.0^^95^1040^9
 ;;^UTILITY(U,$J,358.3,20963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20963,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,20963,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,20963,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,20964,0)
 ;;=F25.1^^95^1040^10
 ;;^UTILITY(U,$J,358.3,20964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20964,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,20964,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,20964,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,20965,0)
 ;;=F28.^^95^1040^12
 ;;^UTILITY(U,$J,358.3,20965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20965,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,20965,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,20965,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,20966,0)
 ;;=F29.^^95^1040^13
 ;;^UTILITY(U,$J,358.3,20966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20966,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,20966,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,20966,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,20967,0)
 ;;=F06.1^^95^1040^2
 ;;^UTILITY(U,$J,358.3,20967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20967,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,20967,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,20967,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,20968,0)
 ;;=F06.1^^95^1040^4
 ;;^UTILITY(U,$J,358.3,20968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20968,1,3,0)
 ;;=3^Catatonic Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,20968,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,20968,2)
 ;;=^5003054

IBDEI2DF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40205,0)
 ;;=T81.30XS^^156^1956^26
 ;;^UTILITY(U,$J,358.3,40205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40205,1,3,0)
 ;;=3^Disruption of wound, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,40205,1,4,0)
 ;;=4^T81.30XS
 ;;^UTILITY(U,$J,358.3,40205,2)
 ;;=^5054469
 ;;^UTILITY(U,$J,358.3,40206,0)
 ;;=T81.31XA^^156^1956^16
 ;;^UTILITY(U,$J,358.3,40206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40206,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, init
 ;;^UTILITY(U,$J,358.3,40206,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,40206,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,40207,0)
 ;;=T81.31XD^^156^1956^17
 ;;^UTILITY(U,$J,358.3,40207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40207,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, subs
 ;;^UTILITY(U,$J,358.3,40207,1,4,0)
 ;;=4^T81.31XD
 ;;^UTILITY(U,$J,358.3,40207,2)
 ;;=^5054471
 ;;^UTILITY(U,$J,358.3,40208,0)
 ;;=T81.31XS^^156^1956^18
 ;;^UTILITY(U,$J,358.3,40208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40208,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, sequela
 ;;^UTILITY(U,$J,358.3,40208,1,4,0)
 ;;=4^T81.31XS
 ;;^UTILITY(U,$J,358.3,40208,2)
 ;;=^5054472
 ;;^UTILITY(U,$J,358.3,40209,0)
 ;;=T81.32XA^^156^1956^19
 ;;^UTILITY(U,$J,358.3,40209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40209,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, init
 ;;^UTILITY(U,$J,358.3,40209,1,4,0)
 ;;=4^T81.32XA
 ;;^UTILITY(U,$J,358.3,40209,2)
 ;;=^5054473
 ;;^UTILITY(U,$J,358.3,40210,0)
 ;;=T81.32XD^^156^1956^20
 ;;^UTILITY(U,$J,358.3,40210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40210,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, subs
 ;;^UTILITY(U,$J,358.3,40210,1,4,0)
 ;;=4^T81.32XD
 ;;^UTILITY(U,$J,358.3,40210,2)
 ;;=^5054474
 ;;^UTILITY(U,$J,358.3,40211,0)
 ;;=T81.32XS^^156^1956^21
 ;;^UTILITY(U,$J,358.3,40211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40211,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, sequela
 ;;^UTILITY(U,$J,358.3,40211,1,4,0)
 ;;=4^T81.32XS
 ;;^UTILITY(U,$J,358.3,40211,2)
 ;;=^5054475
 ;;^UTILITY(U,$J,358.3,40212,0)
 ;;=T81.33XA^^156^1956^22
 ;;^UTILITY(U,$J,358.3,40212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40212,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, init encntr
 ;;^UTILITY(U,$J,358.3,40212,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,40212,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,40213,0)
 ;;=T81.33XD^^156^1956^23
 ;;^UTILITY(U,$J,358.3,40213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40213,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, subs encntr
 ;;^UTILITY(U,$J,358.3,40213,1,4,0)
 ;;=4^T81.33XD
 ;;^UTILITY(U,$J,358.3,40213,2)
 ;;=^5054477
 ;;^UTILITY(U,$J,358.3,40214,0)
 ;;=T81.33XS^^156^1956^24
 ;;^UTILITY(U,$J,358.3,40214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40214,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, sequela
 ;;^UTILITY(U,$J,358.3,40214,1,4,0)
 ;;=4^T81.33XS
 ;;^UTILITY(U,$J,358.3,40214,2)
 ;;=^5054478
 ;;^UTILITY(U,$J,358.3,40215,0)
 ;;=T81.4XXA^^156^1956^36
 ;;^UTILITY(U,$J,358.3,40215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40215,1,3,0)
 ;;=3^Infection following a procedure, initial encounter
 ;;^UTILITY(U,$J,358.3,40215,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,40215,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,40216,0)
 ;;=K68.11^^156^1956^54
 ;;^UTILITY(U,$J,358.3,40216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40216,1,3,0)
 ;;=3^Postprocedural retroperitoneal abscess
 ;;^UTILITY(U,$J,358.3,40216,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,40216,2)
 ;;=^5008782

IBDEI21M ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35696,1,3,0)
 ;;=3^Disruption of wound, unspecified, subsequent encounter
 ;;^UTILITY(U,$J,358.3,35696,1,4,0)
 ;;=4^T81.30XD
 ;;^UTILITY(U,$J,358.3,35696,2)
 ;;=^5054468
 ;;^UTILITY(U,$J,358.3,35697,0)
 ;;=T81.30XS^^189^2061^13
 ;;^UTILITY(U,$J,358.3,35697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35697,1,3,0)
 ;;=3^Disruption of wound, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,35697,1,4,0)
 ;;=4^T81.30XS
 ;;^UTILITY(U,$J,358.3,35697,2)
 ;;=^5054469
 ;;^UTILITY(U,$J,358.3,35698,0)
 ;;=T81.31XA^^189^2061^3
 ;;^UTILITY(U,$J,358.3,35698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35698,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, init
 ;;^UTILITY(U,$J,358.3,35698,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,35698,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,35699,0)
 ;;=T81.31XD^^189^2061^4
 ;;^UTILITY(U,$J,358.3,35699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35699,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, subs
 ;;^UTILITY(U,$J,358.3,35699,1,4,0)
 ;;=4^T81.31XD
 ;;^UTILITY(U,$J,358.3,35699,2)
 ;;=^5054471
 ;;^UTILITY(U,$J,358.3,35700,0)
 ;;=T81.31XS^^189^2061^5
 ;;^UTILITY(U,$J,358.3,35700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35700,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, sequela
 ;;^UTILITY(U,$J,358.3,35700,1,4,0)
 ;;=4^T81.31XS
 ;;^UTILITY(U,$J,358.3,35700,2)
 ;;=^5054472
 ;;^UTILITY(U,$J,358.3,35701,0)
 ;;=T81.32XA^^189^2061^6
 ;;^UTILITY(U,$J,358.3,35701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35701,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, init
 ;;^UTILITY(U,$J,358.3,35701,1,4,0)
 ;;=4^T81.32XA
 ;;^UTILITY(U,$J,358.3,35701,2)
 ;;=^5054473
 ;;^UTILITY(U,$J,358.3,35702,0)
 ;;=T81.32XD^^189^2061^7
 ;;^UTILITY(U,$J,358.3,35702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35702,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, subs
 ;;^UTILITY(U,$J,358.3,35702,1,4,0)
 ;;=4^T81.32XD
 ;;^UTILITY(U,$J,358.3,35702,2)
 ;;=^5054474
 ;;^UTILITY(U,$J,358.3,35703,0)
 ;;=T81.32XS^^189^2061^8
 ;;^UTILITY(U,$J,358.3,35703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35703,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, sequela
 ;;^UTILITY(U,$J,358.3,35703,1,4,0)
 ;;=4^T81.32XS
 ;;^UTILITY(U,$J,358.3,35703,2)
 ;;=^5054475
 ;;^UTILITY(U,$J,358.3,35704,0)
 ;;=T81.33XA^^189^2061^9
 ;;^UTILITY(U,$J,358.3,35704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35704,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, init encntr
 ;;^UTILITY(U,$J,358.3,35704,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,35704,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,35705,0)
 ;;=T81.33XD^^189^2061^10
 ;;^UTILITY(U,$J,358.3,35705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35705,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, subs encntr
 ;;^UTILITY(U,$J,358.3,35705,1,4,0)
 ;;=4^T81.33XD
 ;;^UTILITY(U,$J,358.3,35705,2)
 ;;=^5054477
 ;;^UTILITY(U,$J,358.3,35706,0)
 ;;=T81.33XS^^189^2061^11
 ;;^UTILITY(U,$J,358.3,35706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35706,1,3,0)
 ;;=3^Disruption of traumatic injury wound repair, sequela
 ;;^UTILITY(U,$J,358.3,35706,1,4,0)
 ;;=4^T81.33XS
 ;;^UTILITY(U,$J,358.3,35706,2)
 ;;=^5054478
 ;;^UTILITY(U,$J,358.3,35707,0)
 ;;=T81.4XXA^^189^2061^15
 ;;^UTILITY(U,$J,358.3,35707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35707,1,3,0)
 ;;=3^Infection following a procedure, initial encounter
 ;;^UTILITY(U,$J,358.3,35707,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,35707,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,35708,0)
 ;;=K68.11^^189^2061^17
 ;;^UTILITY(U,$J,358.3,35708,1,0)
 ;;=^358.31IA^4^2

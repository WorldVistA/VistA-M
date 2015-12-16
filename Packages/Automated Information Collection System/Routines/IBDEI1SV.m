IBDEI1SV ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31743,1,4,0)
 ;;=4^S02.402A
 ;;^UTILITY(U,$J,358.3,31743,2)
 ;;=^5020330
 ;;^UTILITY(U,$J,358.3,31744,0)
 ;;=S02.609A^^181^1967^7
 ;;^UTILITY(U,$J,358.3,31744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31744,1,3,0)
 ;;=3^Fracture of mandible, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,31744,1,4,0)
 ;;=4^S02.609A
 ;;^UTILITY(U,$J,358.3,31744,2)
 ;;=^5020372
 ;;^UTILITY(U,$J,358.3,31745,0)
 ;;=S02.69XA^^181^1967^6
 ;;^UTILITY(U,$J,358.3,31745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31745,1,3,0)
 ;;=3^Fracture of mandible of oth site, init for clos fx
 ;;^UTILITY(U,$J,358.3,31745,1,4,0)
 ;;=4^S02.69XA
 ;;^UTILITY(U,$J,358.3,31745,2)
 ;;=^5020420
 ;;^UTILITY(U,$J,358.3,31746,0)
 ;;=S02.8XXA^^181^1967^11
 ;;^UTILITY(U,$J,358.3,31746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31746,1,3,0)
 ;;=3^Fracture of oth skull and facial bones, init for clos fx
 ;;^UTILITY(U,$J,358.3,31746,1,4,0)
 ;;=4^S02.8XXA
 ;;^UTILITY(U,$J,358.3,31746,2)
 ;;=^5020426
 ;;^UTILITY(U,$J,358.3,31747,0)
 ;;=S02.91XA^^181^1967^12
 ;;^UTILITY(U,$J,358.3,31747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31747,1,3,0)
 ;;=3^Fracture of skull unspec, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,31747,1,4,0)
 ;;=4^S02.91XA
 ;;^UTILITY(U,$J,358.3,31747,2)
 ;;=^5020432
 ;;^UTILITY(U,$J,358.3,31748,0)
 ;;=S02.92XA^^181^1967^4
 ;;^UTILITY(U,$J,358.3,31748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31748,1,3,0)
 ;;=3^Fracture of facial bones unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,31748,1,4,0)
 ;;=4^S02.92XA
 ;;^UTILITY(U,$J,358.3,31748,2)
 ;;=^5020438
 ;;^UTILITY(U,$J,358.3,31749,0)
 ;;=S02.0XXB^^181^1967^15
 ;;^UTILITY(U,$J,358.3,31749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31749,1,3,0)
 ;;=3^Fracture of vault of skull, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,31749,1,4,0)
 ;;=4^S02.0XXB
 ;;^UTILITY(U,$J,358.3,31749,2)
 ;;=^5020253
 ;;^UTILITY(U,$J,358.3,31750,0)
 ;;=S02.2XXB^^181^1967^9
 ;;^UTILITY(U,$J,358.3,31750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31750,1,3,0)
 ;;=3^Fracture of nasal bones, initial encounter for open fracture
 ;;^UTILITY(U,$J,358.3,31750,1,4,0)
 ;;=4^S02.2XXB
 ;;^UTILITY(U,$J,358.3,31750,2)
 ;;=^5020307
 ;;^UTILITY(U,$J,358.3,31751,0)
 ;;=S02.402B^^181^1967^22
 ;;^UTILITY(U,$J,358.3,31751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31751,1,3,0)
 ;;=3^Zygomatic fracture, unsp, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,31751,1,4,0)
 ;;=4^S02.402B
 ;;^UTILITY(U,$J,358.3,31751,2)
 ;;=^5020331
 ;;^UTILITY(U,$J,358.3,31752,0)
 ;;=S02.91XB^^181^1967^13
 ;;^UTILITY(U,$J,358.3,31752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31752,1,3,0)
 ;;=3^Fracture of skull unspec, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,31752,1,4,0)
 ;;=4^S02.91XB
 ;;^UTILITY(U,$J,358.3,31752,2)
 ;;=^5020433
 ;;^UTILITY(U,$J,358.3,31753,0)
 ;;=S02.0XXD^^181^1967^17
 ;;^UTILITY(U,$J,358.3,31753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31753,1,3,0)
 ;;=3^Fracture of vault of skull, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,31753,1,4,0)
 ;;=4^S02.0XXD
 ;;^UTILITY(U,$J,358.3,31753,2)
 ;;=^5020254
 ;;^UTILITY(U,$J,358.3,31754,0)
 ;;=S02.10XD^^181^1967^3
 ;;^UTILITY(U,$J,358.3,31754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31754,1,3,0)
 ;;=3^Fracture of base of skull unspec, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,31754,1,4,0)
 ;;=4^S02.10XD
 ;;^UTILITY(U,$J,358.3,31754,2)
 ;;=^5020260
 ;;^UTILITY(U,$J,358.3,31755,0)
 ;;=S02.0XXS^^181^1967^16
 ;;^UTILITY(U,$J,358.3,31755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31755,1,3,0)
 ;;=3^Fracture of vault of skull, sequela

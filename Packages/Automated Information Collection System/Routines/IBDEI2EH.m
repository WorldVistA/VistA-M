IBDEI2EH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38312,1,3,0)
 ;;=3^Maxillary fracture, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,38312,1,4,0)
 ;;=4^S02.401A
 ;;^UTILITY(U,$J,358.3,38312,2)
 ;;=^5020324
 ;;^UTILITY(U,$J,358.3,38313,0)
 ;;=S02.402A^^149^1947^29
 ;;^UTILITY(U,$J,358.3,38313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38313,1,3,0)
 ;;=3^Zygomatic fracture, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,38313,1,4,0)
 ;;=4^S02.402A
 ;;^UTILITY(U,$J,358.3,38313,2)
 ;;=^5020330
 ;;^UTILITY(U,$J,358.3,38314,0)
 ;;=S02.609A^^149^1947^10
 ;;^UTILITY(U,$J,358.3,38314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38314,1,3,0)
 ;;=3^Fracture of mandible, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,38314,1,4,0)
 ;;=4^S02.609A
 ;;^UTILITY(U,$J,358.3,38314,2)
 ;;=^5020372
 ;;^UTILITY(U,$J,358.3,38315,0)
 ;;=S02.69XA^^149^1947^9
 ;;^UTILITY(U,$J,358.3,38315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38315,1,3,0)
 ;;=3^Fracture of mandible of oth site, init for clos fx
 ;;^UTILITY(U,$J,358.3,38315,1,4,0)
 ;;=4^S02.69XA
 ;;^UTILITY(U,$J,358.3,38315,2)
 ;;=^5020420
 ;;^UTILITY(U,$J,358.3,38316,0)
 ;;=S02.91XA^^149^1947^20
 ;;^UTILITY(U,$J,358.3,38316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38316,1,3,0)
 ;;=3^Fracture of skull unspec, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,38316,1,4,0)
 ;;=4^S02.91XA
 ;;^UTILITY(U,$J,358.3,38316,2)
 ;;=^5020432
 ;;^UTILITY(U,$J,358.3,38317,0)
 ;;=S02.92XA^^149^1947^7
 ;;^UTILITY(U,$J,358.3,38317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38317,1,3,0)
 ;;=3^Fracture of facial bones unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,38317,1,4,0)
 ;;=4^S02.92XA
 ;;^UTILITY(U,$J,358.3,38317,2)
 ;;=^5020438
 ;;^UTILITY(U,$J,358.3,38318,0)
 ;;=S02.0XXB^^149^1947^23
 ;;^UTILITY(U,$J,358.3,38318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38318,1,3,0)
 ;;=3^Fracture of vault of skull, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,38318,1,4,0)
 ;;=4^S02.0XXB
 ;;^UTILITY(U,$J,358.3,38318,2)
 ;;=^5020253
 ;;^UTILITY(U,$J,358.3,38319,0)
 ;;=S02.2XXB^^149^1947^12
 ;;^UTILITY(U,$J,358.3,38319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38319,1,3,0)
 ;;=3^Fracture of nasal bones, initial encounter for open fracture
 ;;^UTILITY(U,$J,358.3,38319,1,4,0)
 ;;=4^S02.2XXB
 ;;^UTILITY(U,$J,358.3,38319,2)
 ;;=^5020307
 ;;^UTILITY(U,$J,358.3,38320,0)
 ;;=S02.402B^^149^1947^30
 ;;^UTILITY(U,$J,358.3,38320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38320,1,3,0)
 ;;=3^Zygomatic fracture, unsp, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,38320,1,4,0)
 ;;=4^S02.402B
 ;;^UTILITY(U,$J,358.3,38320,2)
 ;;=^5020331
 ;;^UTILITY(U,$J,358.3,38321,0)
 ;;=S02.91XB^^149^1947^21
 ;;^UTILITY(U,$J,358.3,38321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38321,1,3,0)
 ;;=3^Fracture of skull unspec, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,38321,1,4,0)
 ;;=4^S02.91XB
 ;;^UTILITY(U,$J,358.3,38321,2)
 ;;=^5020433
 ;;^UTILITY(U,$J,358.3,38322,0)
 ;;=S02.0XXD^^149^1947^25
 ;;^UTILITY(U,$J,358.3,38322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38322,1,3,0)
 ;;=3^Fracture of vault of skull, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,38322,1,4,0)
 ;;=4^S02.0XXD
 ;;^UTILITY(U,$J,358.3,38322,2)
 ;;=^5020254
 ;;^UTILITY(U,$J,358.3,38323,0)
 ;;=S02.0XXS^^149^1947^24
 ;;^UTILITY(U,$J,358.3,38323,1,0)
 ;;=^358.31IA^4^2

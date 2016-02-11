IBDEI2KG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43046,1,4,0)
 ;;=4^Z13.89
 ;;^UTILITY(U,$J,358.3,43046,2)
 ;;=^5062720
 ;;^UTILITY(U,$J,358.3,43047,0)
 ;;=Z87.81^^195^2165^2
 ;;^UTILITY(U,$J,358.3,43047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43047,1,3,0)
 ;;=3^Personal history of (healed) traumatic fracture
 ;;^UTILITY(U,$J,358.3,43047,1,4,0)
 ;;=4^Z87.81
 ;;^UTILITY(U,$J,358.3,43047,2)
 ;;=^5063513
 ;;^UTILITY(U,$J,358.3,43048,0)
 ;;=Z87.828^^195^2165^3
 ;;^UTILITY(U,$J,358.3,43048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43048,1,3,0)
 ;;=3^Personal history of oth (healed) physical injury and trauma
 ;;^UTILITY(U,$J,358.3,43048,1,4,0)
 ;;=4^Z87.828
 ;;^UTILITY(U,$J,358.3,43048,2)
 ;;=^5063516
 ;;^UTILITY(U,$J,358.3,43049,0)
 ;;=S02.10XA^^195^2166^1
 ;;^UTILITY(U,$J,358.3,43049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43049,1,3,0)
 ;;=3^Fracture of base of skull unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,43049,1,4,0)
 ;;=4^S02.10XA
 ;;^UTILITY(U,$J,358.3,43049,2)
 ;;=^5020258
 ;;^UTILITY(U,$J,358.3,43050,0)
 ;;=S02.113A^^195^2166^20
 ;;^UTILITY(U,$J,358.3,43050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43050,1,3,0)
 ;;=3^Occipital condyle fx unspec, init for clos fx
 ;;^UTILITY(U,$J,358.3,43050,1,4,0)
 ;;=4^S02.113A
 ;;^UTILITY(U,$J,358.3,43050,2)
 ;;=^5020282
 ;;^UTILITY(U,$J,358.3,43051,0)
 ;;=S02.2XXA^^195^2166^8
 ;;^UTILITY(U,$J,358.3,43051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43051,1,3,0)
 ;;=3^Fracture of nasal bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,43051,1,4,0)
 ;;=4^S02.2XXA
 ;;^UTILITY(U,$J,358.3,43051,2)
 ;;=^5020306
 ;;^UTILITY(U,$J,358.3,43052,0)
 ;;=S02.401A^^195^2166^18
 ;;^UTILITY(U,$J,358.3,43052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43052,1,3,0)
 ;;=3^Maxillary fracture, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,43052,1,4,0)
 ;;=4^S02.401A
 ;;^UTILITY(U,$J,358.3,43052,2)
 ;;=^5020324
 ;;^UTILITY(U,$J,358.3,43053,0)
 ;;=S02.402A^^195^2166^21
 ;;^UTILITY(U,$J,358.3,43053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43053,1,3,0)
 ;;=3^Zygomatic fracture, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,43053,1,4,0)
 ;;=4^S02.402A
 ;;^UTILITY(U,$J,358.3,43053,2)
 ;;=^5020330
 ;;^UTILITY(U,$J,358.3,43054,0)
 ;;=S02.609A^^195^2166^7
 ;;^UTILITY(U,$J,358.3,43054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43054,1,3,0)
 ;;=3^Fracture of mandible, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,43054,1,4,0)
 ;;=4^S02.609A
 ;;^UTILITY(U,$J,358.3,43054,2)
 ;;=^5020372
 ;;^UTILITY(U,$J,358.3,43055,0)
 ;;=S02.69XA^^195^2166^6
 ;;^UTILITY(U,$J,358.3,43055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43055,1,3,0)
 ;;=3^Fracture of mandible of oth site, init for clos fx
 ;;^UTILITY(U,$J,358.3,43055,1,4,0)
 ;;=4^S02.69XA
 ;;^UTILITY(U,$J,358.3,43055,2)
 ;;=^5020420
 ;;^UTILITY(U,$J,358.3,43056,0)
 ;;=S02.8XXA^^195^2166^11
 ;;^UTILITY(U,$J,358.3,43056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43056,1,3,0)
 ;;=3^Fracture of oth skull and facial bones, init for clos fx
 ;;^UTILITY(U,$J,358.3,43056,1,4,0)
 ;;=4^S02.8XXA
 ;;^UTILITY(U,$J,358.3,43056,2)
 ;;=^5020426
 ;;^UTILITY(U,$J,358.3,43057,0)
 ;;=S02.91XA^^195^2166^12
 ;;^UTILITY(U,$J,358.3,43057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43057,1,3,0)
 ;;=3^Fracture of skull unspec, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,43057,1,4,0)
 ;;=4^S02.91XA
 ;;^UTILITY(U,$J,358.3,43057,2)
 ;;=^5020432
 ;;^UTILITY(U,$J,358.3,43058,0)
 ;;=S02.92XA^^195^2166^4
 ;;^UTILITY(U,$J,358.3,43058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43058,1,3,0)
 ;;=3^Fracture of facial bones unspec, init for clos fx

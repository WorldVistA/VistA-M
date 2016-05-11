IBDEI1PI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28995,1,4,0)
 ;;=4^O31.32X0
 ;;^UTILITY(U,$J,358.3,28995,2)
 ;;=^5016600
 ;;^UTILITY(U,$J,358.3,28996,0)
 ;;=O31.33X0^^115^1454^6
 ;;^UTILITY(U,$J,358.3,28996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28996,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,3rd tri, unsp
 ;;^UTILITY(U,$J,358.3,28996,1,4,0)
 ;;=4^O31.33X0
 ;;^UTILITY(U,$J,358.3,28996,2)
 ;;=^5016607
 ;;^UTILITY(U,$J,358.3,28997,0)
 ;;=O31.31X1^^115^1454^7
 ;;^UTILITY(U,$J,358.3,28997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28997,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,1st tri, fts1
 ;;^UTILITY(U,$J,358.3,28997,1,4,0)
 ;;=4^O31.31X1
 ;;^UTILITY(U,$J,358.3,28997,2)
 ;;=^5016594
 ;;^UTILITY(U,$J,358.3,28998,0)
 ;;=O31.32X1^^115^1454^8
 ;;^UTILITY(U,$J,358.3,28998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28998,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,2nd tri, fts1
 ;;^UTILITY(U,$J,358.3,28998,1,4,0)
 ;;=4^O31.32X1
 ;;^UTILITY(U,$J,358.3,28998,2)
 ;;=^5016601
 ;;^UTILITY(U,$J,358.3,28999,0)
 ;;=O31.33X1^^115^1454^9
 ;;^UTILITY(U,$J,358.3,28999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28999,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,3rd tri, fts1
 ;;^UTILITY(U,$J,358.3,28999,1,4,0)
 ;;=4^O31.33X1
 ;;^UTILITY(U,$J,358.3,28999,2)
 ;;=^5016608
 ;;^UTILITY(U,$J,358.3,29000,0)
 ;;=O31.31X2^^115^1454^10
 ;;^UTILITY(U,$J,358.3,29000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29000,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,1st tri, fts2
 ;;^UTILITY(U,$J,358.3,29000,1,4,0)
 ;;=4^O31.31X2
 ;;^UTILITY(U,$J,358.3,29000,2)
 ;;=^5016595
 ;;^UTILITY(U,$J,358.3,29001,0)
 ;;=O31.32X2^^115^1454^11
 ;;^UTILITY(U,$J,358.3,29001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29001,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,2nd tri, fts2
 ;;^UTILITY(U,$J,358.3,29001,1,4,0)
 ;;=4^O31.32X2
 ;;^UTILITY(U,$J,358.3,29001,2)
 ;;=^5016602
 ;;^UTILITY(U,$J,358.3,29002,0)
 ;;=O31.33X2^^115^1454^12
 ;;^UTILITY(U,$J,358.3,29002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29002,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,3rd tri, fts2
 ;;^UTILITY(U,$J,358.3,29002,1,4,0)
 ;;=4^O31.33X2
 ;;^UTILITY(U,$J,358.3,29002,2)
 ;;=^5016609
 ;;^UTILITY(U,$J,358.3,29003,0)
 ;;=O31.31X3^^115^1454^13
 ;;^UTILITY(U,$J,358.3,29003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29003,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,1st tri, fts3
 ;;^UTILITY(U,$J,358.3,29003,1,4,0)
 ;;=4^O31.31X3
 ;;^UTILITY(U,$J,358.3,29003,2)
 ;;=^5016596
 ;;^UTILITY(U,$J,358.3,29004,0)
 ;;=O31.32X3^^115^1454^14
 ;;^UTILITY(U,$J,358.3,29004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29004,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,2nd tri, fts3
 ;;^UTILITY(U,$J,358.3,29004,1,4,0)
 ;;=4^O31.32X3
 ;;^UTILITY(U,$J,358.3,29004,2)
 ;;=^5016603
 ;;^UTILITY(U,$J,358.3,29005,0)
 ;;=O31.33X3^^115^1454^15
 ;;^UTILITY(U,$J,358.3,29005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29005,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,3rd tri, fts3
 ;;^UTILITY(U,$J,358.3,29005,1,4,0)
 ;;=4^O31.33X3
 ;;^UTILITY(U,$J,358.3,29005,2)
 ;;=^5016610
 ;;^UTILITY(U,$J,358.3,29006,0)
 ;;=O31.31X4^^115^1454^16
 ;;^UTILITY(U,$J,358.3,29006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29006,1,3,0)
 ;;=3^Cont preg aft elctv fetl rdct of 1 fts or more,1st tri, fts4
 ;;^UTILITY(U,$J,358.3,29006,1,4,0)
 ;;=4^O31.31X4
 ;;^UTILITY(U,$J,358.3,29006,2)
 ;;=^5016597
 ;;^UTILITY(U,$J,358.3,29007,0)
 ;;=O31.32X4^^115^1454^17
 ;;^UTILITY(U,$J,358.3,29007,1,0)
 ;;=^358.31IA^4^2

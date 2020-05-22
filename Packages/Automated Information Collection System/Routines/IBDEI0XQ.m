IBDEI0XQ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15022,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/ Bleeding
 ;;^UTILITY(U,$J,358.3,15022,1,4,0)
 ;;=4^K28.4
 ;;^UTILITY(U,$J,358.3,15022,2)
 ;;=^270153
 ;;^UTILITY(U,$J,358.3,15023,0)
 ;;=K28.5^^85^838^70
 ;;^UTILITY(U,$J,358.3,15023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15023,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/ Perforation
 ;;^UTILITY(U,$J,358.3,15023,1,4,0)
 ;;=4^K28.5
 ;;^UTILITY(U,$J,358.3,15023,2)
 ;;=^270156
 ;;^UTILITY(U,$J,358.3,15024,0)
 ;;=K28.6^^85^838^68
 ;;^UTILITY(U,$J,358.3,15024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15024,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,15024,1,4,0)
 ;;=4^K28.6
 ;;^UTILITY(U,$J,358.3,15024,2)
 ;;=^5008539
 ;;^UTILITY(U,$J,358.3,15025,0)
 ;;=K28.7^^85^838^71
 ;;^UTILITY(U,$J,358.3,15025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15025,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/o Bleed or Perf
 ;;^UTILITY(U,$J,358.3,15025,1,4,0)
 ;;=4^K28.7
 ;;^UTILITY(U,$J,358.3,15025,2)
 ;;=^5008540
 ;;^UTILITY(U,$J,358.3,15026,0)
 ;;=K63.3^^85^838^55
 ;;^UTILITY(U,$J,358.3,15026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15026,1,3,0)
 ;;=3^Ulcer of Intestine w/o Perforation
 ;;^UTILITY(U,$J,358.3,15026,1,4,0)
 ;;=4^K63.3
 ;;^UTILITY(U,$J,358.3,15026,2)
 ;;=^5008763
 ;;^UTILITY(U,$J,358.3,15027,0)
 ;;=K55.8^^85^838^72
 ;;^UTILITY(U,$J,358.3,15027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15027,1,3,0)
 ;;=3^Vascular disorders of Intestine,Other
 ;;^UTILITY(U,$J,358.3,15027,1,4,0)
 ;;=4^K55.8
 ;;^UTILITY(U,$J,358.3,15027,2)
 ;;=^5008709
 ;;^UTILITY(U,$J,358.3,15028,0)
 ;;=K56.2^^85^838^73
 ;;^UTILITY(U,$J,358.3,15028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15028,1,3,0)
 ;;=3^Volvulus
 ;;^UTILITY(U,$J,358.3,15028,1,4,0)
 ;;=4^K56.2
 ;;^UTILITY(U,$J,358.3,15028,2)
 ;;=^5008711
 ;;^UTILITY(U,$J,358.3,15029,0)
 ;;=K31.9^^85^838^13
 ;;^UTILITY(U,$J,358.3,15029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15029,1,3,0)
 ;;=3^Disease of Duodenum,Unsp
 ;;^UTILITY(U,$J,358.3,15029,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,15029,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,15030,0)
 ;;=K63.9^^85^838^14
 ;;^UTILITY(U,$J,358.3,15030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15030,1,3,0)
 ;;=3^Disease of Intestine,Unspec
 ;;^UTILITY(U,$J,358.3,15030,1,4,0)
 ;;=4^K63.9
 ;;^UTILITY(U,$J,358.3,15030,2)
 ;;=^5008768
 ;;^UTILITY(U,$J,358.3,15031,0)
 ;;=K56.50^^85^838^48
 ;;^UTILITY(U,$J,358.3,15031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15031,1,3,0)
 ;;=3^Obstruction of Sm Int,Partial or Complete,Adhesions
 ;;^UTILITY(U,$J,358.3,15031,1,4,0)
 ;;=4^K56.50
 ;;^UTILITY(U,$J,358.3,15031,2)
 ;;=^5151418
 ;;^UTILITY(U,$J,358.3,15032,0)
 ;;=K56.51^^85^838^50
 ;;^UTILITY(U,$J,358.3,15032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15032,1,3,0)
 ;;=3^Obstruction of Sm Int,Partial,Adhesions
 ;;^UTILITY(U,$J,358.3,15032,1,4,0)
 ;;=4^K56.51
 ;;^UTILITY(U,$J,358.3,15032,2)
 ;;=^5151419
 ;;^UTILITY(U,$J,358.3,15033,0)
 ;;=K56.52^^85^838^46
 ;;^UTILITY(U,$J,358.3,15033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15033,1,3,0)
 ;;=3^Obstruction of Sm Int,Complete,Adhesions
 ;;^UTILITY(U,$J,358.3,15033,1,4,0)
 ;;=4^K56.52
 ;;^UTILITY(U,$J,358.3,15033,2)
 ;;=^5151420
 ;;^UTILITY(U,$J,358.3,15034,0)
 ;;=K56.600^^85^838^47
 ;;^UTILITY(U,$J,358.3,15034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15034,1,3,0)
 ;;=3^Obstruction of Sm Int,Partial

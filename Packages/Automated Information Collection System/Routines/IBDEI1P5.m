IBDEI1P5 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30090,1,4,0)
 ;;=4^O99.285
 ;;^UTILITY(U,$J,358.3,30090,2)
 ;;=^5017939
 ;;^UTILITY(U,$J,358.3,30091,0)
 ;;=O99.011^^178^1913^3
 ;;^UTILITY(U,$J,358.3,30091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30091,1,3,0)
 ;;=3^Anemia complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,30091,1,4,0)
 ;;=4^O99.011
 ;;^UTILITY(U,$J,358.3,30091,2)
 ;;=^5017916
 ;;^UTILITY(U,$J,358.3,30092,0)
 ;;=O99.012^^178^1913^4
 ;;^UTILITY(U,$J,358.3,30092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30092,1,3,0)
 ;;=3^Anemia complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,30092,1,4,0)
 ;;=4^O99.012
 ;;^UTILITY(U,$J,358.3,30092,2)
 ;;=^5017917
 ;;^UTILITY(U,$J,358.3,30093,0)
 ;;=O99.013^^178^1913^5
 ;;^UTILITY(U,$J,358.3,30093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30093,1,3,0)
 ;;=3^Anemia complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,30093,1,4,0)
 ;;=4^O99.013
 ;;^UTILITY(U,$J,358.3,30093,2)
 ;;=^5017918
 ;;^UTILITY(U,$J,358.3,30094,0)
 ;;=O99.03^^178^1913^6
 ;;^UTILITY(U,$J,358.3,30094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30094,1,3,0)
 ;;=3^Anemia complicating the puerperium
 ;;^UTILITY(U,$J,358.3,30094,1,4,0)
 ;;=4^O99.03
 ;;^UTILITY(U,$J,358.3,30094,2)
 ;;=^5017921
 ;;^UTILITY(U,$J,358.3,30095,0)
 ;;=O99.321^^178^1913^12
 ;;^UTILITY(U,$J,358.3,30095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30095,1,3,0)
 ;;=3^Drug use complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,30095,1,4,0)
 ;;=4^O99.321
 ;;^UTILITY(U,$J,358.3,30095,2)
 ;;=^5017947
 ;;^UTILITY(U,$J,358.3,30096,0)
 ;;=O99.322^^178^1913^13
 ;;^UTILITY(U,$J,358.3,30096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30096,1,3,0)
 ;;=3^Drug use complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,30096,1,4,0)
 ;;=4^O99.322
 ;;^UTILITY(U,$J,358.3,30096,2)
 ;;=^5017948
 ;;^UTILITY(U,$J,358.3,30097,0)
 ;;=O99.323^^178^1913^14
 ;;^UTILITY(U,$J,358.3,30097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30097,1,3,0)
 ;;=3^Drug use complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,30097,1,4,0)
 ;;=4^O99.323
 ;;^UTILITY(U,$J,358.3,30097,2)
 ;;=^5017949
 ;;^UTILITY(U,$J,358.3,30098,0)
 ;;=O99.325^^178^1913^15
 ;;^UTILITY(U,$J,358.3,30098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30098,1,3,0)
 ;;=3^Drug use complicating the puerperium
 ;;^UTILITY(U,$J,358.3,30098,1,4,0)
 ;;=4^O99.325
 ;;^UTILITY(U,$J,358.3,30098,2)
 ;;=^5017951
 ;;^UTILITY(U,$J,358.3,30099,0)
 ;;=O90.6^^178^1913^57
 ;;^UTILITY(U,$J,358.3,30099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30099,1,3,0)
 ;;=3^Postpartum mood disturbance
 ;;^UTILITY(U,$J,358.3,30099,1,4,0)
 ;;=4^O90.6
 ;;^UTILITY(U,$J,358.3,30099,2)
 ;;=^5017818
 ;;^UTILITY(U,$J,358.3,30100,0)
 ;;=F53.^^178^1913^79
 ;;^UTILITY(U,$J,358.3,30100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30100,1,3,0)
 ;;=3^Puerperal psychosis
 ;;^UTILITY(U,$J,358.3,30100,1,4,0)
 ;;=4^F53.
 ;;^UTILITY(U,$J,358.3,30100,2)
 ;;=^5003626
 ;;^UTILITY(U,$J,358.3,30101,0)
 ;;=O99.411^^178^1913^8
 ;;^UTILITY(U,$J,358.3,30101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30101,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,30101,1,4,0)
 ;;=4^O99.411
 ;;^UTILITY(U,$J,358.3,30101,2)
 ;;=^5017970
 ;;^UTILITY(U,$J,358.3,30102,0)
 ;;=O99.412^^178^1913^9
 ;;^UTILITY(U,$J,358.3,30102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30102,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,30102,1,4,0)
 ;;=4^O99.412
 ;;^UTILITY(U,$J,358.3,30102,2)
 ;;=^5017971
 ;;^UTILITY(U,$J,358.3,30103,0)
 ;;=O99.413^^178^1913^10

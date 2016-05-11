IBDEI1PA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28900,1,4,0)
 ;;=4^O99.321
 ;;^UTILITY(U,$J,358.3,28900,2)
 ;;=^5017947
 ;;^UTILITY(U,$J,358.3,28901,0)
 ;;=O99.322^^115^1452^13
 ;;^UTILITY(U,$J,358.3,28901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28901,1,3,0)
 ;;=3^Drug use complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28901,1,4,0)
 ;;=4^O99.322
 ;;^UTILITY(U,$J,358.3,28901,2)
 ;;=^5017948
 ;;^UTILITY(U,$J,358.3,28902,0)
 ;;=O99.323^^115^1452^14
 ;;^UTILITY(U,$J,358.3,28902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28902,1,3,0)
 ;;=3^Drug use complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28902,1,4,0)
 ;;=4^O99.323
 ;;^UTILITY(U,$J,358.3,28902,2)
 ;;=^5017949
 ;;^UTILITY(U,$J,358.3,28903,0)
 ;;=O99.325^^115^1452^15
 ;;^UTILITY(U,$J,358.3,28903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28903,1,3,0)
 ;;=3^Drug use complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28903,1,4,0)
 ;;=4^O99.325
 ;;^UTILITY(U,$J,358.3,28903,2)
 ;;=^5017951
 ;;^UTILITY(U,$J,358.3,28904,0)
 ;;=O90.6^^115^1452^57
 ;;^UTILITY(U,$J,358.3,28904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28904,1,3,0)
 ;;=3^Postpartum mood disturbance
 ;;^UTILITY(U,$J,358.3,28904,1,4,0)
 ;;=4^O90.6
 ;;^UTILITY(U,$J,358.3,28904,2)
 ;;=^5017818
 ;;^UTILITY(U,$J,358.3,28905,0)
 ;;=F53.^^115^1452^79
 ;;^UTILITY(U,$J,358.3,28905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28905,1,3,0)
 ;;=3^Puerperal psychosis
 ;;^UTILITY(U,$J,358.3,28905,1,4,0)
 ;;=4^F53.
 ;;^UTILITY(U,$J,358.3,28905,2)
 ;;=^5003626
 ;;^UTILITY(U,$J,358.3,28906,0)
 ;;=O99.411^^115^1452^8
 ;;^UTILITY(U,$J,358.3,28906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28906,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28906,1,4,0)
 ;;=4^O99.411
 ;;^UTILITY(U,$J,358.3,28906,2)
 ;;=^5017970
 ;;^UTILITY(U,$J,358.3,28907,0)
 ;;=O99.412^^115^1452^9
 ;;^UTILITY(U,$J,358.3,28907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28907,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28907,1,4,0)
 ;;=4^O99.412
 ;;^UTILITY(U,$J,358.3,28907,2)
 ;;=^5017971
 ;;^UTILITY(U,$J,358.3,28908,0)
 ;;=O99.413^^115^1452^10
 ;;^UTILITY(U,$J,358.3,28908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28908,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28908,1,4,0)
 ;;=4^O99.413
 ;;^UTILITY(U,$J,358.3,28908,2)
 ;;=^5017972
 ;;^UTILITY(U,$J,358.3,28909,0)
 ;;=O99.43^^115^1452^11
 ;;^UTILITY(U,$J,358.3,28909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28909,1,3,0)
 ;;=3^Diseases of the circ sys complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28909,1,4,0)
 ;;=4^O99.43
 ;;^UTILITY(U,$J,358.3,28909,2)
 ;;=^5017975
 ;;^UTILITY(U,$J,358.3,28910,0)
 ;;=O33.0^^115^1452^38
 ;;^UTILITY(U,$J,358.3,28910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28910,1,3,0)
 ;;=3^Matern care for disproprtn d/t deformity of matern pelv bone
 ;;^UTILITY(U,$J,358.3,28910,1,4,0)
 ;;=4^O33.0
 ;;^UTILITY(U,$J,358.3,28910,2)
 ;;=^5016691
 ;;^UTILITY(U,$J,358.3,28911,0)
 ;;=O99.810^^115^1452^1
 ;;^UTILITY(U,$J,358.3,28911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28911,1,3,0)
 ;;=3^Abnormal glucose complicating pregnancy
 ;;^UTILITY(U,$J,358.3,28911,1,4,0)
 ;;=4^O99.810
 ;;^UTILITY(U,$J,358.3,28911,2)
 ;;=^5017994
 ;;^UTILITY(U,$J,358.3,28912,0)
 ;;=O99.815^^115^1452^2
 ;;^UTILITY(U,$J,358.3,28912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28912,1,3,0)
 ;;=3^Abnormal glucose complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28912,1,4,0)
 ;;=4^O99.815
 ;;^UTILITY(U,$J,358.3,28912,2)
 ;;=^5017996

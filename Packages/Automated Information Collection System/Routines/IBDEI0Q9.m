IBDEI0Q9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12305,1,4,0)
 ;;=4^K22.5
 ;;^UTILITY(U,$J,358.3,12305,2)
 ;;=^5008509
 ;;^UTILITY(U,$J,358.3,12306,0)
 ;;=K22.6^^50^558^20
 ;;^UTILITY(U,$J,358.3,12306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12306,1,3,0)
 ;;=3^Gastro-esophageal laceration-hemorrhage syndrome
 ;;^UTILITY(U,$J,358.3,12306,1,4,0)
 ;;=4^K22.6
 ;;^UTILITY(U,$J,358.3,12306,2)
 ;;=^5008510
 ;;^UTILITY(U,$J,358.3,12307,0)
 ;;=K21.9^^50^558^22
 ;;^UTILITY(U,$J,358.3,12307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12307,1,3,0)
 ;;=3^Gastro-esophageal reflux disease w/o esophagitis
 ;;^UTILITY(U,$J,358.3,12307,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,12307,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,12308,0)
 ;;=K22.70^^50^558^5
 ;;^UTILITY(U,$J,358.3,12308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12308,1,3,0)
 ;;=3^Barrett's esophagus w/o dysplasia
 ;;^UTILITY(U,$J,358.3,12308,1,4,0)
 ;;=4^K22.70
 ;;^UTILITY(U,$J,358.3,12308,2)
 ;;=^5008511
 ;;^UTILITY(U,$J,358.3,12309,0)
 ;;=K22.710^^50^558^4
 ;;^UTILITY(U,$J,358.3,12309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12309,1,3,0)
 ;;=3^Barrett's esophagus w/ low grade dysplasia
 ;;^UTILITY(U,$J,358.3,12309,1,4,0)
 ;;=4^K22.710
 ;;^UTILITY(U,$J,358.3,12309,2)
 ;;=^5008512
 ;;^UTILITY(U,$J,358.3,12310,0)
 ;;=K22.711^^50^558^3
 ;;^UTILITY(U,$J,358.3,12310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12310,1,3,0)
 ;;=3^Barrett's esophagus w/ high grade dysplasia
 ;;^UTILITY(U,$J,358.3,12310,1,4,0)
 ;;=4^K22.711
 ;;^UTILITY(U,$J,358.3,12310,2)
 ;;=^5008513
 ;;^UTILITY(U,$J,358.3,12311,0)
 ;;=K22.719^^50^558^2
 ;;^UTILITY(U,$J,358.3,12311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12311,1,3,0)
 ;;=3^Barrett's esophagus w/ dysplasia, unspecified
 ;;^UTILITY(U,$J,358.3,12311,1,4,0)
 ;;=4^K22.719
 ;;^UTILITY(U,$J,358.3,12311,2)
 ;;=^5008514
 ;;^UTILITY(U,$J,358.3,12312,0)
 ;;=K44.9^^50^558^7
 ;;^UTILITY(U,$J,358.3,12312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12312,1,3,0)
 ;;=3^Diaphragmatic hernia w/o obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,12312,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,12312,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,12313,0)
 ;;=Q39.4^^50^558^14
 ;;^UTILITY(U,$J,358.3,12313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12313,1,3,0)
 ;;=3^Esophageal web
 ;;^UTILITY(U,$J,358.3,12313,1,4,0)
 ;;=4^Q39.4
 ;;^UTILITY(U,$J,358.3,12313,2)
 ;;=^5018659
 ;;^UTILITY(U,$J,358.3,12314,0)
 ;;=T18.108A^^50^558^17
 ;;^UTILITY(U,$J,358.3,12314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12314,1,3,0)
 ;;=3^Foreign body in esophagus causing oth injury, init
 ;;^UTILITY(U,$J,358.3,12314,1,4,0)
 ;;=4^T18.108A
 ;;^UTILITY(U,$J,358.3,12314,2)
 ;;=^5046582
 ;;^UTILITY(U,$J,358.3,12315,0)
 ;;=T18.118A^^50^558^19
 ;;^UTILITY(U,$J,358.3,12315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12315,1,3,0)
 ;;=3^Gastric contents in esophagus causing oth injury, init
 ;;^UTILITY(U,$J,358.3,12315,1,4,0)
 ;;=4^T18.118A
 ;;^UTILITY(U,$J,358.3,12315,2)
 ;;=^5046588
 ;;^UTILITY(U,$J,358.3,12316,0)
 ;;=T18.128A^^50^558^16
 ;;^UTILITY(U,$J,358.3,12316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12316,1,3,0)
 ;;=3^Food in esophagus causing other injury, initial encounter
 ;;^UTILITY(U,$J,358.3,12316,1,4,0)
 ;;=4^T18.128A
 ;;^UTILITY(U,$J,358.3,12316,2)
 ;;=^5046594
 ;;^UTILITY(U,$J,358.3,12317,0)
 ;;=T18.198A^^50^558^18
 ;;^UTILITY(U,$J,358.3,12317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12317,1,3,0)
 ;;=3^Foreign object in esophagus causing oth injury, init
 ;;^UTILITY(U,$J,358.3,12317,1,4,0)
 ;;=4^T18.198A
 ;;^UTILITY(U,$J,358.3,12317,2)
 ;;=^5046600
 ;;^UTILITY(U,$J,358.3,12318,0)
 ;;=Q39.1^^50^558^13

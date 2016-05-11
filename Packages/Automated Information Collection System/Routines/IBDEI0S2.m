IBDEI0S2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13161,0)
 ;;=K27.9^^53^588^72
 ;;^UTILITY(U,$J,358.3,13161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13161,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,13161,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,13161,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,13162,0)
 ;;=K29.70^^53^588^51
 ;;^UTILITY(U,$J,358.3,13162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13162,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,13162,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,13162,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,13163,0)
 ;;=K29.90^^53^588^52
 ;;^UTILITY(U,$J,358.3,13163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13163,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,13163,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,13163,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,13164,0)
 ;;=K30.^^53^588^45
 ;;^UTILITY(U,$J,358.3,13164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13164,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,13164,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,13164,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,13165,0)
 ;;=K31.89^^53^588^34
 ;;^UTILITY(U,$J,358.3,13165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13165,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,13165,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,13165,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,13166,0)
 ;;=K31.9^^53^588^33
 ;;^UTILITY(U,$J,358.3,13166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13166,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,13166,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,13166,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,13167,0)
 ;;=K40.90^^53^588^68
 ;;^UTILITY(U,$J,358.3,13167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13167,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,13167,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,13167,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,13168,0)
 ;;=K40.20^^53^588^67
 ;;^UTILITY(U,$J,358.3,13168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13168,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,13168,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,13168,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,13169,0)
 ;;=K44.9^^53^588^31
 ;;^UTILITY(U,$J,358.3,13169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13169,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,13169,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,13169,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,13170,0)
 ;;=K46.9^^53^588^1
 ;;^UTILITY(U,$J,358.3,13170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13170,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,13170,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,13170,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,13171,0)
 ;;=K50.90^^53^588^29
 ;;^UTILITY(U,$J,358.3,13171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13171,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,13171,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,13171,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,13172,0)
 ;;=K50.911^^53^588^27
 ;;^UTILITY(U,$J,358.3,13172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13172,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,13172,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,13172,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,13173,0)
 ;;=K50.912^^53^588^25
 ;;^UTILITY(U,$J,358.3,13173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13173,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,13173,1,4,0)
 ;;=4^K50.912

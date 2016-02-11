IBDEI1RX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29696,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,29696,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,29696,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,29697,0)
 ;;=K30.^^135^1367^45
 ;;^UTILITY(U,$J,358.3,29697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29697,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,29697,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,29697,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,29698,0)
 ;;=K31.89^^135^1367^34
 ;;^UTILITY(U,$J,358.3,29698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29698,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,29698,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,29698,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,29699,0)
 ;;=K31.9^^135^1367^33
 ;;^UTILITY(U,$J,358.3,29699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29699,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,29699,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,29699,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,29700,0)
 ;;=K40.90^^135^1367^68
 ;;^UTILITY(U,$J,358.3,29700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29700,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,29700,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,29700,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,29701,0)
 ;;=K40.20^^135^1367^67
 ;;^UTILITY(U,$J,358.3,29701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29701,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,29701,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,29701,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,29702,0)
 ;;=K44.9^^135^1367^31
 ;;^UTILITY(U,$J,358.3,29702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29702,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,29702,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,29702,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,29703,0)
 ;;=K46.9^^135^1367^1
 ;;^UTILITY(U,$J,358.3,29703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29703,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,29703,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,29703,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,29704,0)
 ;;=K50.90^^135^1367^29
 ;;^UTILITY(U,$J,358.3,29704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29704,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,29704,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,29704,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,29705,0)
 ;;=K50.911^^135^1367^27
 ;;^UTILITY(U,$J,358.3,29705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29705,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,29705,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,29705,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,29706,0)
 ;;=K50.912^^135^1367^25
 ;;^UTILITY(U,$J,358.3,29706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29706,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,29706,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,29706,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,29707,0)
 ;;=K50.919^^135^1367^28
 ;;^UTILITY(U,$J,358.3,29707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29707,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,29707,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,29707,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,29708,0)
 ;;=K50.914^^135^1367^23
 ;;^UTILITY(U,$J,358.3,29708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29708,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,29708,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,29708,2)
 ;;=^5008649

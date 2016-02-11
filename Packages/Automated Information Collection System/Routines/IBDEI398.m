IBDEI398 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,54693,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,54693,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,54693,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,54694,0)
 ;;=K30.^^256^2770^45
 ;;^UTILITY(U,$J,358.3,54694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54694,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,54694,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,54694,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,54695,0)
 ;;=K31.89^^256^2770^34
 ;;^UTILITY(U,$J,358.3,54695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54695,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,54695,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,54695,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,54696,0)
 ;;=K31.9^^256^2770^33
 ;;^UTILITY(U,$J,358.3,54696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54696,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,54696,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,54696,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,54697,0)
 ;;=K40.90^^256^2770^68
 ;;^UTILITY(U,$J,358.3,54697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54697,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,54697,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,54697,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,54698,0)
 ;;=K40.20^^256^2770^67
 ;;^UTILITY(U,$J,358.3,54698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54698,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,54698,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,54698,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,54699,0)
 ;;=K44.9^^256^2770^31
 ;;^UTILITY(U,$J,358.3,54699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54699,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,54699,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,54699,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,54700,0)
 ;;=K46.9^^256^2770^1
 ;;^UTILITY(U,$J,358.3,54700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54700,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,54700,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,54700,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,54701,0)
 ;;=K50.90^^256^2770^29
 ;;^UTILITY(U,$J,358.3,54701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54701,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,54701,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,54701,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,54702,0)
 ;;=K50.911^^256^2770^27
 ;;^UTILITY(U,$J,358.3,54702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54702,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,54702,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,54702,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,54703,0)
 ;;=K50.912^^256^2770^25
 ;;^UTILITY(U,$J,358.3,54703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54703,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,54703,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,54703,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,54704,0)
 ;;=K50.919^^256^2770^28
 ;;^UTILITY(U,$J,358.3,54704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54704,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,54704,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,54704,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,54705,0)
 ;;=K50.914^^256^2770^23
 ;;^UTILITY(U,$J,358.3,54705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54705,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,54705,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,54705,2)
 ;;=^5008649

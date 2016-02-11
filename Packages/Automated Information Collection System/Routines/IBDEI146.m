IBDEI146 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18603,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,18604,0)
 ;;=K29.90^^94^911^52
 ;;^UTILITY(U,$J,358.3,18604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18604,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,18604,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,18604,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,18605,0)
 ;;=K30.^^94^911^45
 ;;^UTILITY(U,$J,358.3,18605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18605,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,18605,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,18605,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,18606,0)
 ;;=K31.89^^94^911^34
 ;;^UTILITY(U,$J,358.3,18606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18606,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,18606,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,18606,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,18607,0)
 ;;=K31.9^^94^911^33
 ;;^UTILITY(U,$J,358.3,18607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18607,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,18607,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,18607,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,18608,0)
 ;;=K40.90^^94^911^68
 ;;^UTILITY(U,$J,358.3,18608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18608,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,18608,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,18608,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,18609,0)
 ;;=K40.20^^94^911^67
 ;;^UTILITY(U,$J,358.3,18609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18609,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,18609,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,18609,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,18610,0)
 ;;=K44.9^^94^911^31
 ;;^UTILITY(U,$J,358.3,18610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18610,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,18610,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,18610,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,18611,0)
 ;;=K46.9^^94^911^1
 ;;^UTILITY(U,$J,358.3,18611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18611,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,18611,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,18611,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,18612,0)
 ;;=K50.90^^94^911^29
 ;;^UTILITY(U,$J,358.3,18612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18612,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,18612,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,18612,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,18613,0)
 ;;=K50.911^^94^911^27
 ;;^UTILITY(U,$J,358.3,18613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18613,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,18613,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,18613,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,18614,0)
 ;;=K50.912^^94^911^25
 ;;^UTILITY(U,$J,358.3,18614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18614,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,18614,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,18614,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,18615,0)
 ;;=K50.919^^94^911^28
 ;;^UTILITY(U,$J,358.3,18615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18615,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,18615,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,18615,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,18616,0)
 ;;=K50.914^^94^911^23
 ;;^UTILITY(U,$J,358.3,18616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18616,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec

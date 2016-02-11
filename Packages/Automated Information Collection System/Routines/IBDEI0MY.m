IBDEI0MY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10483,0)
 ;;=K25.7^^68^670^50
 ;;^UTILITY(U,$J,358.3,10483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10483,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,10483,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,10483,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,10484,0)
 ;;=K26.9^^68^670^44
 ;;^UTILITY(U,$J,358.3,10484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10484,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,10484,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,10484,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,10485,0)
 ;;=K27.9^^68^670^72
 ;;^UTILITY(U,$J,358.3,10485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10485,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,10485,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,10485,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,10486,0)
 ;;=K29.70^^68^670^51
 ;;^UTILITY(U,$J,358.3,10486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10486,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,10486,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,10486,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,10487,0)
 ;;=K29.90^^68^670^52
 ;;^UTILITY(U,$J,358.3,10487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10487,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,10487,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,10487,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,10488,0)
 ;;=K30.^^68^670^45
 ;;^UTILITY(U,$J,358.3,10488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10488,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,10488,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,10488,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,10489,0)
 ;;=K31.89^^68^670^34
 ;;^UTILITY(U,$J,358.3,10489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10489,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,10489,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,10489,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,10490,0)
 ;;=K31.9^^68^670^33
 ;;^UTILITY(U,$J,358.3,10490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10490,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,10490,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,10490,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,10491,0)
 ;;=K40.90^^68^670^68
 ;;^UTILITY(U,$J,358.3,10491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10491,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,10491,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,10491,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,10492,0)
 ;;=K40.20^^68^670^67
 ;;^UTILITY(U,$J,358.3,10492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10492,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,10492,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,10492,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,10493,0)
 ;;=K44.9^^68^670^31
 ;;^UTILITY(U,$J,358.3,10493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10493,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,10493,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,10493,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,10494,0)
 ;;=K46.9^^68^670^1
 ;;^UTILITY(U,$J,358.3,10494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10494,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,10494,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,10494,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,10495,0)
 ;;=K50.90^^68^670^29
 ;;^UTILITY(U,$J,358.3,10495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10495,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,10495,1,4,0)
 ;;=4^K50.90

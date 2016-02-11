IBDEI1N0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27393,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,27393,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,27393,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,27394,0)
 ;;=K40.90^^132^1315^68
 ;;^UTILITY(U,$J,358.3,27394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27394,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,27394,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,27394,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,27395,0)
 ;;=K40.20^^132^1315^67
 ;;^UTILITY(U,$J,358.3,27395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27395,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,27395,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,27395,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,27396,0)
 ;;=K44.9^^132^1315^31
 ;;^UTILITY(U,$J,358.3,27396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27396,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,27396,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,27396,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,27397,0)
 ;;=K46.9^^132^1315^1
 ;;^UTILITY(U,$J,358.3,27397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27397,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,27397,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,27397,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,27398,0)
 ;;=K50.90^^132^1315^29
 ;;^UTILITY(U,$J,358.3,27398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27398,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,27398,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,27398,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,27399,0)
 ;;=K50.911^^132^1315^27
 ;;^UTILITY(U,$J,358.3,27399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27399,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,27399,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,27399,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,27400,0)
 ;;=K50.912^^132^1315^25
 ;;^UTILITY(U,$J,358.3,27400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27400,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,27400,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,27400,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,27401,0)
 ;;=K50.919^^132^1315^28
 ;;^UTILITY(U,$J,358.3,27401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27401,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,27401,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,27401,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,27402,0)
 ;;=K50.914^^132^1315^23
 ;;^UTILITY(U,$J,358.3,27402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27402,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,27402,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,27402,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,27403,0)
 ;;=K50.913^^132^1315^24
 ;;^UTILITY(U,$J,358.3,27403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27403,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,27403,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,27403,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,27404,0)
 ;;=K50.918^^132^1315^26
 ;;^UTILITY(U,$J,358.3,27404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27404,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,27404,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,27404,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,27405,0)
 ;;=K51.90^^132^1315^80
 ;;^UTILITY(U,$J,358.3,27405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27405,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec

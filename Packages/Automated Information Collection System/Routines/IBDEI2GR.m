IBDEI2GR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39343,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,39343,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,39343,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,39344,0)
 ;;=K40.20^^152^1996^74
 ;;^UTILITY(U,$J,358.3,39344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39344,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,39344,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,39344,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,39345,0)
 ;;=K44.9^^152^1996^36
 ;;^UTILITY(U,$J,358.3,39345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39345,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,39345,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,39345,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,39346,0)
 ;;=K46.9^^152^1996^1
 ;;^UTILITY(U,$J,358.3,39346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39346,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,39346,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,39346,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,39347,0)
 ;;=K50.90^^152^1996^31
 ;;^UTILITY(U,$J,358.3,39347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39347,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,39347,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,39347,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,39348,0)
 ;;=K50.911^^152^1996^29
 ;;^UTILITY(U,$J,358.3,39348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39348,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,39348,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,39348,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,39349,0)
 ;;=K50.912^^152^1996^27
 ;;^UTILITY(U,$J,358.3,39349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39349,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,39349,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,39349,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,39350,0)
 ;;=K50.919^^152^1996^30
 ;;^UTILITY(U,$J,358.3,39350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39350,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,39350,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,39350,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,39351,0)
 ;;=K50.914^^152^1996^25
 ;;^UTILITY(U,$J,358.3,39351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39351,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,39351,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,39351,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,39352,0)
 ;;=K50.913^^152^1996^26
 ;;^UTILITY(U,$J,358.3,39352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39352,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,39352,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,39352,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,39353,0)
 ;;=K50.918^^152^1996^28
 ;;^UTILITY(U,$J,358.3,39353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39353,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,39353,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,39353,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,39354,0)
 ;;=K51.90^^152^1996^90
 ;;^UTILITY(U,$J,358.3,39354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39354,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,39354,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,39354,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,39355,0)
 ;;=K51.919^^152^1996^89

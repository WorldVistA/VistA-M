IBDEI10D ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16215,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,16216,0)
 ;;=K40.90^^88^875^75
 ;;^UTILITY(U,$J,358.3,16216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16216,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,16216,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,16216,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,16217,0)
 ;;=K40.20^^88^875^74
 ;;^UTILITY(U,$J,358.3,16217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16217,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,16217,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,16217,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,16218,0)
 ;;=K44.9^^88^875^36
 ;;^UTILITY(U,$J,358.3,16218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16218,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,16218,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,16218,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,16219,0)
 ;;=K46.9^^88^875^1
 ;;^UTILITY(U,$J,358.3,16219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16219,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,16219,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,16219,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,16220,0)
 ;;=K50.90^^88^875^31
 ;;^UTILITY(U,$J,358.3,16220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16220,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,16220,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,16220,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,16221,0)
 ;;=K50.911^^88^875^29
 ;;^UTILITY(U,$J,358.3,16221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16221,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,16221,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,16221,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,16222,0)
 ;;=K50.912^^88^875^27
 ;;^UTILITY(U,$J,358.3,16222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16222,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,16222,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,16222,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,16223,0)
 ;;=K50.919^^88^875^30
 ;;^UTILITY(U,$J,358.3,16223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16223,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,16223,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,16223,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,16224,0)
 ;;=K50.914^^88^875^25
 ;;^UTILITY(U,$J,358.3,16224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16224,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,16224,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,16224,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,16225,0)
 ;;=K50.913^^88^875^26
 ;;^UTILITY(U,$J,358.3,16225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16225,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,16225,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,16225,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,16226,0)
 ;;=K50.918^^88^875^28
 ;;^UTILITY(U,$J,358.3,16226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16226,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,16226,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,16226,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,16227,0)
 ;;=K51.90^^88^875^90
 ;;^UTILITY(U,$J,358.3,16227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16227,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec

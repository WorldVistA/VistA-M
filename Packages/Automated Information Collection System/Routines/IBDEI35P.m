IBDEI35P ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50403,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,50403,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,50403,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,50404,0)
 ;;=K40.20^^193^2493^74
 ;;^UTILITY(U,$J,358.3,50404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50404,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,50404,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,50404,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,50405,0)
 ;;=K44.9^^193^2493^36
 ;;^UTILITY(U,$J,358.3,50405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50405,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,50405,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,50405,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,50406,0)
 ;;=K46.9^^193^2493^1
 ;;^UTILITY(U,$J,358.3,50406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50406,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,50406,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,50406,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,50407,0)
 ;;=K50.90^^193^2493^31
 ;;^UTILITY(U,$J,358.3,50407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50407,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,50407,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,50407,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,50408,0)
 ;;=K50.911^^193^2493^29
 ;;^UTILITY(U,$J,358.3,50408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50408,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,50408,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,50408,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,50409,0)
 ;;=K50.912^^193^2493^27
 ;;^UTILITY(U,$J,358.3,50409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50409,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,50409,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,50409,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,50410,0)
 ;;=K50.919^^193^2493^30
 ;;^UTILITY(U,$J,358.3,50410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50410,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,50410,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,50410,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,50411,0)
 ;;=K50.914^^193^2493^25
 ;;^UTILITY(U,$J,358.3,50411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50411,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,50411,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,50411,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,50412,0)
 ;;=K50.913^^193^2493^26
 ;;^UTILITY(U,$J,358.3,50412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50412,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,50412,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,50412,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,50413,0)
 ;;=K50.918^^193^2493^28
 ;;^UTILITY(U,$J,358.3,50413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50413,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,50413,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,50413,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,50414,0)
 ;;=K51.90^^193^2493^90
 ;;^UTILITY(U,$J,358.3,50414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50414,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,50414,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,50414,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,50415,0)
 ;;=K51.919^^193^2493^89

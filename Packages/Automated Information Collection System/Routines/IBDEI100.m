IBDEI100 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16241,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,16242,0)
 ;;=K40.90^^61^771^76
 ;;^UTILITY(U,$J,358.3,16242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16242,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,16242,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,16242,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,16243,0)
 ;;=K40.20^^61^771^75
 ;;^UTILITY(U,$J,358.3,16243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16243,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,16243,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,16243,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,16244,0)
 ;;=K44.9^^61^771^36
 ;;^UTILITY(U,$J,358.3,16244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16244,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,16244,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,16244,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,16245,0)
 ;;=K46.9^^61^771^1
 ;;^UTILITY(U,$J,358.3,16245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16245,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,16245,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,16245,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,16246,0)
 ;;=K50.90^^61^771^31
 ;;^UTILITY(U,$J,358.3,16246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16246,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,16246,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,16246,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,16247,0)
 ;;=K50.911^^61^771^29
 ;;^UTILITY(U,$J,358.3,16247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16247,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,16247,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,16247,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,16248,0)
 ;;=K50.912^^61^771^27
 ;;^UTILITY(U,$J,358.3,16248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16248,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,16248,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,16248,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,16249,0)
 ;;=K50.919^^61^771^30
 ;;^UTILITY(U,$J,358.3,16249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16249,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,16249,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,16249,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,16250,0)
 ;;=K50.914^^61^771^25
 ;;^UTILITY(U,$J,358.3,16250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16250,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,16250,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,16250,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,16251,0)
 ;;=K50.913^^61^771^26
 ;;^UTILITY(U,$J,358.3,16251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16251,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,16251,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,16251,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,16252,0)
 ;;=K50.918^^61^771^28
 ;;^UTILITY(U,$J,358.3,16252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16252,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,16252,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,16252,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,16253,0)
 ;;=K51.90^^61^771^91
 ;;^UTILITY(U,$J,358.3,16253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16253,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec

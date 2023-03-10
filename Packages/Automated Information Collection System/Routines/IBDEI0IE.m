IBDEI0IE ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8278,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,8278,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,8278,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,8279,0)
 ;;=K30.^^39^397^50
 ;;^UTILITY(U,$J,358.3,8279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8279,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,8279,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,8279,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,8280,0)
 ;;=K31.89^^39^397^39
 ;;^UTILITY(U,$J,358.3,8280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8280,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,8280,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,8280,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,8281,0)
 ;;=K31.9^^39^397^38
 ;;^UTILITY(U,$J,358.3,8281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8281,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,8281,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,8281,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,8282,0)
 ;;=K40.90^^39^397^76
 ;;^UTILITY(U,$J,358.3,8282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8282,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,8282,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,8282,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,8283,0)
 ;;=K40.20^^39^397^75
 ;;^UTILITY(U,$J,358.3,8283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8283,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,8283,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,8283,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,8284,0)
 ;;=K44.9^^39^397^36
 ;;^UTILITY(U,$J,358.3,8284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8284,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,8284,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,8284,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,8285,0)
 ;;=K46.9^^39^397^1
 ;;^UTILITY(U,$J,358.3,8285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8285,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,8285,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,8285,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,8286,0)
 ;;=K50.90^^39^397^31
 ;;^UTILITY(U,$J,358.3,8286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8286,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,8286,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,8286,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,8287,0)
 ;;=K50.911^^39^397^29
 ;;^UTILITY(U,$J,358.3,8287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8287,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,8287,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,8287,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,8288,0)
 ;;=K50.912^^39^397^27
 ;;^UTILITY(U,$J,358.3,8288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8288,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,8288,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,8288,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,8289,0)
 ;;=K50.919^^39^397^30
 ;;^UTILITY(U,$J,358.3,8289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8289,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,8289,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,8289,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,8290,0)
 ;;=K50.914^^39^397^25
 ;;^UTILITY(U,$J,358.3,8290,1,0)
 ;;=^358.31IA^4^2

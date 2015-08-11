IBDEI1RG ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31487,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,31487,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,31487,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,31488,0)
 ;;=K31.89^^190^1938^31
 ;;^UTILITY(U,$J,358.3,31488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31488,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,31488,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,31488,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,31489,0)
 ;;=K31.9^^190^1938^30
 ;;^UTILITY(U,$J,358.3,31489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31489,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,31489,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,31489,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,31490,0)
 ;;=K40.90^^190^1938^63
 ;;^UTILITY(U,$J,358.3,31490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31490,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,31490,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,31490,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,31491,0)
 ;;=K40.20^^190^1938^62
 ;;^UTILITY(U,$J,358.3,31491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31491,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,31491,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,31491,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,31492,0)
 ;;=K44.9^^190^1938^28
 ;;^UTILITY(U,$J,358.3,31492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31492,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,31492,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,31492,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,31493,0)
 ;;=K46.9^^190^1938^1
 ;;^UTILITY(U,$J,358.3,31493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31493,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,31493,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,31493,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,31494,0)
 ;;=K50.90^^190^1938^26
 ;;^UTILITY(U,$J,358.3,31494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31494,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,31494,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,31494,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,31495,0)
 ;;=K50.911^^190^1938^24
 ;;^UTILITY(U,$J,358.3,31495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31495,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,31495,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,31495,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,31496,0)
 ;;=K50.912^^190^1938^22
 ;;^UTILITY(U,$J,358.3,31496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31496,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,31496,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,31496,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,31497,0)
 ;;=K50.919^^190^1938^25
 ;;^UTILITY(U,$J,358.3,31497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31497,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,31497,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,31497,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,31498,0)
 ;;=K50.914^^190^1938^20
 ;;^UTILITY(U,$J,358.3,31498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31498,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,31498,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,31498,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,31499,0)
 ;;=K50.913^^190^1938^21
 ;;^UTILITY(U,$J,358.3,31499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31499,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,31499,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,31499,2)
 ;;=^5008648

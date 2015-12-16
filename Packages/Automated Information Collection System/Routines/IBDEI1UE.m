IBDEI1UE ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32445,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,32446,0)
 ;;=K27.9^^182^1987^66
 ;;^UTILITY(U,$J,358.3,32446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32446,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,32446,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,32446,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,32447,0)
 ;;=K29.70^^182^1987^46
 ;;^UTILITY(U,$J,358.3,32447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32447,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,32447,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,32447,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,32448,0)
 ;;=K29.90^^182^1987^47
 ;;^UTILITY(U,$J,358.3,32448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32448,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,32448,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,32448,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,32449,0)
 ;;=K30.^^182^1987^42
 ;;^UTILITY(U,$J,358.3,32449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32449,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,32449,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,32449,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,32450,0)
 ;;=K31.89^^182^1987^31
 ;;^UTILITY(U,$J,358.3,32450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32450,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,32450,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,32450,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,32451,0)
 ;;=K31.9^^182^1987^30
 ;;^UTILITY(U,$J,358.3,32451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32451,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,32451,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,32451,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,32452,0)
 ;;=K40.90^^182^1987^63
 ;;^UTILITY(U,$J,358.3,32452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32452,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,32452,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,32452,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,32453,0)
 ;;=K40.20^^182^1987^62
 ;;^UTILITY(U,$J,358.3,32453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32453,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,32453,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,32453,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,32454,0)
 ;;=K44.9^^182^1987^28
 ;;^UTILITY(U,$J,358.3,32454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32454,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,32454,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,32454,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,32455,0)
 ;;=K46.9^^182^1987^1
 ;;^UTILITY(U,$J,358.3,32455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32455,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,32455,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,32455,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,32456,0)
 ;;=K50.90^^182^1987^26
 ;;^UTILITY(U,$J,358.3,32456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32456,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,32456,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,32456,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,32457,0)
 ;;=K50.911^^182^1987^24
 ;;^UTILITY(U,$J,358.3,32457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32457,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,32457,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,32457,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,32458,0)
 ;;=K50.912^^182^1987^22
 ;;^UTILITY(U,$J,358.3,32458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32458,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec

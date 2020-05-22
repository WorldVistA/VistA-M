IBDEI1J9 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24508,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,24508,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,24508,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,24509,0)
 ;;=K21.9^^107^1207^62
 ;;^UTILITY(U,$J,358.3,24509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24509,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,24509,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,24509,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,24510,0)
 ;;=K25.7^^107^1207^57
 ;;^UTILITY(U,$J,358.3,24510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24510,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,24510,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,24510,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,24511,0)
 ;;=K26.9^^107^1207^49
 ;;^UTILITY(U,$J,358.3,24511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24511,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,24511,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,24511,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,24512,0)
 ;;=K27.9^^107^1207^82
 ;;^UTILITY(U,$J,358.3,24512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24512,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,24512,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,24512,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,24513,0)
 ;;=K29.70^^107^1207^58
 ;;^UTILITY(U,$J,358.3,24513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24513,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,24513,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,24513,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,24514,0)
 ;;=K29.90^^107^1207^59
 ;;^UTILITY(U,$J,358.3,24514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24514,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,24514,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,24514,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,24515,0)
 ;;=K30.^^107^1207^50
 ;;^UTILITY(U,$J,358.3,24515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24515,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,24515,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,24515,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,24516,0)
 ;;=K31.89^^107^1207^39
 ;;^UTILITY(U,$J,358.3,24516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24516,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,24516,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,24516,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,24517,0)
 ;;=K31.9^^107^1207^38
 ;;^UTILITY(U,$J,358.3,24517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24517,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,24517,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,24517,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,24518,0)
 ;;=K40.90^^107^1207^75
 ;;^UTILITY(U,$J,358.3,24518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24518,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,24518,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,24518,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,24519,0)
 ;;=K40.20^^107^1207^74
 ;;^UTILITY(U,$J,358.3,24519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24519,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,24519,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,24519,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,24520,0)
 ;;=K44.9^^107^1207^36

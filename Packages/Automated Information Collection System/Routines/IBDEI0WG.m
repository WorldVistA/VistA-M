IBDEI0WG ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42611,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,42611,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,42611,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,42612,0)
 ;;=K26.9^^127^1850^44
 ;;^UTILITY(U,$J,358.3,42612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42612,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,42612,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,42612,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,42613,0)
 ;;=K27.9^^127^1850^72
 ;;^UTILITY(U,$J,358.3,42613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42613,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,42613,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,42613,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,42614,0)
 ;;=K29.70^^127^1850^51
 ;;^UTILITY(U,$J,358.3,42614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42614,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,42614,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,42614,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,42615,0)
 ;;=K29.90^^127^1850^52
 ;;^UTILITY(U,$J,358.3,42615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42615,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,42615,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,42615,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,42616,0)
 ;;=K30.^^127^1850^45
 ;;^UTILITY(U,$J,358.3,42616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42616,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,42616,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,42616,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,42617,0)
 ;;=K31.89^^127^1850^34
 ;;^UTILITY(U,$J,358.3,42617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42617,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,42617,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,42617,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,42618,0)
 ;;=K31.9^^127^1850^33
 ;;^UTILITY(U,$J,358.3,42618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42618,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,42618,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,42618,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,42619,0)
 ;;=K40.90^^127^1850^68
 ;;^UTILITY(U,$J,358.3,42619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42619,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,42619,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,42619,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,42620,0)
 ;;=K40.20^^127^1850^67
 ;;^UTILITY(U,$J,358.3,42620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42620,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,42620,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,42620,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,42621,0)
 ;;=K44.9^^127^1850^31
 ;;^UTILITY(U,$J,358.3,42621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42621,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,42621,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,42621,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,42622,0)
 ;;=K46.9^^127^1850^1
 ;;^UTILITY(U,$J,358.3,42622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42622,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,42622,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,42622,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,42623,0)
 ;;=K50.90^^127^1850^29
 ;;^UTILITY(U,$J,358.3,42623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42623,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,42623,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,42623,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,42624,0)
 ;;=K50.911^^127^1850^27
 ;;^UTILITY(U,$J,358.3,42624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42624,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,42624,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,42624,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,42625,0)
 ;;=K50.912^^127^1850^25
 ;;^UTILITY(U,$J,358.3,42625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42625,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,42625,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,42625,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,42626,0)
 ;;=K50.919^^127^1850^28
 ;;^UTILITY(U,$J,358.3,42626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42626,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,42626,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,42626,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,42627,0)
 ;;=K50.914^^127^1850^23
 ;;^UTILITY(U,$J,358.3,42627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42627,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,42627,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,42627,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,42628,0)
 ;;=K50.913^^127^1850^24
 ;;^UTILITY(U,$J,358.3,42628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42628,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,42628,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,42628,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,42629,0)
 ;;=K50.918^^127^1850^26
 ;;^UTILITY(U,$J,358.3,42629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42629,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,42629,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,42629,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,42630,0)
 ;;=K51.90^^127^1850^80
 ;;^UTILITY(U,$J,358.3,42630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42630,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,42630,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,42630,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,42631,0)
 ;;=K51.919^^127^1850^79
 ;;^UTILITY(U,$J,358.3,42631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42631,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,42631,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,42631,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,42632,0)
 ;;=K51.918^^127^1850^77
 ;;^UTILITY(U,$J,358.3,42632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42632,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,42632,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,42632,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,42633,0)
 ;;=K51.914^^127^1850^74
 ;;^UTILITY(U,$J,358.3,42633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42633,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,42633,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,42633,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,42634,0)
 ;;=K51.913^^127^1850^75
 ;;^UTILITY(U,$J,358.3,42634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42634,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,42634,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,42634,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,42635,0)
 ;;=K51.912^^127^1850^76
 ;;^UTILITY(U,$J,358.3,42635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42635,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,42635,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,42635,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,42636,0)
 ;;=K51.911^^127^1850^78
 ;;^UTILITY(U,$J,358.3,42636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42636,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,42636,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,42636,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,42637,0)
 ;;=K52.89^^127^1850^54
 ;;^UTILITY(U,$J,358.3,42637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42637,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,42637,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,42637,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,42638,0)
 ;;=K52.9^^127^1850^53
 ;;^UTILITY(U,$J,358.3,42638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42638,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,42638,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,42638,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,42639,0)
 ;;=K57.30^^127^1850^42
 ;;^UTILITY(U,$J,358.3,42639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42639,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,42639,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,42639,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,42640,0)
 ;;=K57.50^^127^1850^43
 ;;^UTILITY(U,$J,358.3,42640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42640,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,42640,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,42640,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,42641,0)
 ;;=K57.90^^127^1850^41
 ;;^UTILITY(U,$J,358.3,42641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42641,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,42641,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,42641,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,42642,0)
 ;;=K57.20^^127^1850^37
 ;;^UTILITY(U,$J,358.3,42642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42642,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,42642,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,42642,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,42643,0)
 ;;=K57.92^^127^1850^36
 ;;^UTILITY(U,$J,358.3,42643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42643,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,42643,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,42643,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,42644,0)
 ;;=K57.80^^127^1850^35
 ;;^UTILITY(U,$J,358.3,42644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42644,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,42644,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,42644,2)
 ;;=^5008733

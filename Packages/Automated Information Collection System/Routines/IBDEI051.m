IBDEI051 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6208,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,6208,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,6208,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,6209,0)
 ;;=K25.7^^26^397^51
 ;;^UTILITY(U,$J,358.3,6209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6209,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,6209,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,6209,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,6210,0)
 ;;=K26.9^^26^397^44
 ;;^UTILITY(U,$J,358.3,6210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6210,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,6210,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,6210,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,6211,0)
 ;;=K27.9^^26^397^74
 ;;^UTILITY(U,$J,358.3,6211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6211,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,6211,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,6211,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,6212,0)
 ;;=K29.70^^26^397^52
 ;;^UTILITY(U,$J,358.3,6212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6212,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6212,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,6212,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,6213,0)
 ;;=K29.90^^26^397^53
 ;;^UTILITY(U,$J,358.3,6213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6213,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6213,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,6213,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,6214,0)
 ;;=K30.^^26^397^45
 ;;^UTILITY(U,$J,358.3,6214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6214,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,6214,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,6214,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,6215,0)
 ;;=K31.89^^26^397^34
 ;;^UTILITY(U,$J,358.3,6215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6215,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,6215,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,6215,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,6216,0)
 ;;=K31.9^^26^397^33
 ;;^UTILITY(U,$J,358.3,6216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6216,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,6216,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,6216,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,6217,0)
 ;;=K40.90^^26^397^69
 ;;^UTILITY(U,$J,358.3,6217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6217,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,6217,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,6217,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,6218,0)
 ;;=K40.20^^26^397^68
 ;;^UTILITY(U,$J,358.3,6218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6218,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,6218,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,6218,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,6219,0)
 ;;=K44.9^^26^397^31
 ;;^UTILITY(U,$J,358.3,6219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6219,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,6219,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,6219,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,6220,0)
 ;;=K46.9^^26^397^1
 ;;^UTILITY(U,$J,358.3,6220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6220,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,6220,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,6220,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,6221,0)
 ;;=K50.90^^26^397^29
 ;;^UTILITY(U,$J,358.3,6221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6221,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6221,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,6221,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,6222,0)
 ;;=K50.911^^26^397^27
 ;;^UTILITY(U,$J,358.3,6222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6222,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6222,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,6222,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,6223,0)
 ;;=K50.912^^26^397^25
 ;;^UTILITY(U,$J,358.3,6223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6223,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,6223,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,6223,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,6224,0)
 ;;=K50.919^^26^397^28
 ;;^UTILITY(U,$J,358.3,6224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6224,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6224,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,6224,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,6225,0)
 ;;=K50.914^^26^397^23
 ;;^UTILITY(U,$J,358.3,6225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6225,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,6225,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,6225,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,6226,0)
 ;;=K50.913^^26^397^24
 ;;^UTILITY(U,$J,358.3,6226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6226,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,6226,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,6226,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,6227,0)
 ;;=K50.918^^26^397^26
 ;;^UTILITY(U,$J,358.3,6227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6227,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,6227,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,6227,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,6228,0)
 ;;=K51.90^^26^397^83
 ;;^UTILITY(U,$J,358.3,6228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6228,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6228,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,6228,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,6229,0)
 ;;=K51.919^^26^397^82
 ;;^UTILITY(U,$J,358.3,6229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6229,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6229,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,6229,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,6230,0)
 ;;=K51.918^^26^397^80
 ;;^UTILITY(U,$J,358.3,6230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6230,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,6230,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,6230,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,6231,0)
 ;;=K51.914^^26^397^77
 ;;^UTILITY(U,$J,358.3,6231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6231,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,6231,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,6231,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,6232,0)
 ;;=K51.913^^26^397^78
 ;;^UTILITY(U,$J,358.3,6232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6232,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,6232,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,6232,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,6233,0)
 ;;=K51.912^^26^397^79
 ;;^UTILITY(U,$J,358.3,6233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6233,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,6233,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,6233,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,6234,0)
 ;;=K51.911^^26^397^81
 ;;^UTILITY(U,$J,358.3,6234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6234,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6234,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,6234,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,6235,0)
 ;;=K52.89^^26^397^55
 ;;^UTILITY(U,$J,358.3,6235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6235,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,6235,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,6235,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,6236,0)
 ;;=K52.9^^26^397^54
 ;;^UTILITY(U,$J,358.3,6236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6236,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,6236,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,6236,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,6237,0)
 ;;=K57.30^^26^397^42
 ;;^UTILITY(U,$J,358.3,6237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6237,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6237,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,6237,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,6238,0)
 ;;=K57.50^^26^397^43
 ;;^UTILITY(U,$J,358.3,6238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6238,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6238,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,6238,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,6239,0)
 ;;=K57.90^^26^397^41
 ;;^UTILITY(U,$J,358.3,6239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6239,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6239,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,6239,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,6240,0)
 ;;=K57.20^^26^397^37
 ;;^UTILITY(U,$J,358.3,6240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6240,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6240,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,6240,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,6241,0)
 ;;=K57.92^^26^397^36
 ;;^UTILITY(U,$J,358.3,6241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6241,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6241,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,6241,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,6242,0)
 ;;=K57.80^^26^397^35
 ;;^UTILITY(U,$J,358.3,6242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6242,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6242,1,4,0)
 ;;=4^K57.80

IBDEI0F0 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18967,0)
 ;;=K31.9^^55^783^33
 ;;^UTILITY(U,$J,358.3,18967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18967,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,18967,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,18967,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,18968,0)
 ;;=K40.90^^55^783^68
 ;;^UTILITY(U,$J,358.3,18968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18968,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,18968,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,18968,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,18969,0)
 ;;=K40.20^^55^783^67
 ;;^UTILITY(U,$J,358.3,18969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18969,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,18969,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,18969,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,18970,0)
 ;;=K44.9^^55^783^31
 ;;^UTILITY(U,$J,358.3,18970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18970,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,18970,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,18970,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,18971,0)
 ;;=K46.9^^55^783^1
 ;;^UTILITY(U,$J,358.3,18971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18971,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,18971,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,18971,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,18972,0)
 ;;=K50.90^^55^783^29
 ;;^UTILITY(U,$J,358.3,18972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18972,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,18972,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,18972,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,18973,0)
 ;;=K50.911^^55^783^27
 ;;^UTILITY(U,$J,358.3,18973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18973,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,18973,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,18973,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,18974,0)
 ;;=K50.912^^55^783^25
 ;;^UTILITY(U,$J,358.3,18974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18974,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,18974,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,18974,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,18975,0)
 ;;=K50.919^^55^783^28
 ;;^UTILITY(U,$J,358.3,18975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18975,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,18975,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,18975,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,18976,0)
 ;;=K50.914^^55^783^23
 ;;^UTILITY(U,$J,358.3,18976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18976,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,18976,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,18976,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,18977,0)
 ;;=K50.913^^55^783^24
 ;;^UTILITY(U,$J,358.3,18977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18977,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,18977,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,18977,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,18978,0)
 ;;=K50.918^^55^783^26
 ;;^UTILITY(U,$J,358.3,18978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18978,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,18978,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,18978,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,18979,0)
 ;;=K51.90^^55^783^80
 ;;^UTILITY(U,$J,358.3,18979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18979,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,18979,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,18979,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,18980,0)
 ;;=K51.919^^55^783^79
 ;;^UTILITY(U,$J,358.3,18980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18980,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,18980,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,18980,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,18981,0)
 ;;=K51.918^^55^783^77
 ;;^UTILITY(U,$J,358.3,18981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18981,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,18981,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,18981,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,18982,0)
 ;;=K51.914^^55^783^74
 ;;^UTILITY(U,$J,358.3,18982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18982,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,18982,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,18982,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,18983,0)
 ;;=K51.913^^55^783^75
 ;;^UTILITY(U,$J,358.3,18983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18983,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,18983,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,18983,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,18984,0)
 ;;=K51.912^^55^783^76
 ;;^UTILITY(U,$J,358.3,18984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18984,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,18984,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,18984,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,18985,0)
 ;;=K51.911^^55^783^78
 ;;^UTILITY(U,$J,358.3,18985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18985,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,18985,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,18985,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,18986,0)
 ;;=K52.89^^55^783^54
 ;;^UTILITY(U,$J,358.3,18986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18986,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,18986,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,18986,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,18987,0)
 ;;=K52.9^^55^783^53
 ;;^UTILITY(U,$J,358.3,18987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18987,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,18987,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,18987,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,18988,0)
 ;;=K57.30^^55^783^42
 ;;^UTILITY(U,$J,358.3,18988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18988,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18988,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,18988,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,18989,0)
 ;;=K57.50^^55^783^43
 ;;^UTILITY(U,$J,358.3,18989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18989,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18989,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,18989,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,18990,0)
 ;;=K57.90^^55^783^41
 ;;^UTILITY(U,$J,358.3,18990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18990,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18990,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,18990,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,18991,0)
 ;;=K57.20^^55^783^37
 ;;^UTILITY(U,$J,358.3,18991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18991,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18991,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,18991,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,18992,0)
 ;;=K57.92^^55^783^36
 ;;^UTILITY(U,$J,358.3,18992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18992,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18992,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,18992,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,18993,0)
 ;;=K57.80^^55^783^35
 ;;^UTILITY(U,$J,358.3,18993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18993,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18993,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,18993,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,18994,0)
 ;;=K57.52^^55^783^40
 ;;^UTILITY(U,$J,358.3,18994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18994,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18994,1,4,0)
 ;;=4^K57.52
 ;;^UTILITY(U,$J,358.3,18994,2)
 ;;=^5008731
 ;;^UTILITY(U,$J,358.3,18995,0)
 ;;=K57.40^^55^783^39
 ;;^UTILITY(U,$J,358.3,18995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18995,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18995,1,4,0)
 ;;=4^K57.40
 ;;^UTILITY(U,$J,358.3,18995,2)
 ;;=^5008727
 ;;^UTILITY(U,$J,358.3,18996,0)
 ;;=K57.32^^55^783^38
 ;;^UTILITY(U,$J,358.3,18996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18996,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,18996,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,18996,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,18997,0)
 ;;=K59.00^^55^783^20
 ;;^UTILITY(U,$J,358.3,18997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18997,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,18997,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,18997,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,18998,0)
 ;;=K58.9^^55^783^70
 ;;^UTILITY(U,$J,358.3,18998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18998,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,18998,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,18998,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,18999,0)
 ;;=K58.0^^55^783^69
 ;;^UTILITY(U,$J,358.3,18999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18999,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,18999,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,18999,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,19000,0)
 ;;=K59.1^^55^783^32
 ;;^UTILITY(U,$J,358.3,19000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19000,1,3,0)
 ;;=3^Diarrhea,Functional

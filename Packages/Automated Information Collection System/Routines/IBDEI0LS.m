IBDEI0LS ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21969,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,21969,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,21969,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,21970,0)
 ;;=K50.90^^89^1041^29
 ;;^UTILITY(U,$J,358.3,21970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21970,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,21970,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,21970,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,21971,0)
 ;;=K50.911^^89^1041^27
 ;;^UTILITY(U,$J,358.3,21971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21971,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,21971,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,21971,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,21972,0)
 ;;=K50.912^^89^1041^25
 ;;^UTILITY(U,$J,358.3,21972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21972,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,21972,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,21972,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,21973,0)
 ;;=K50.919^^89^1041^28
 ;;^UTILITY(U,$J,358.3,21973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21973,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,21973,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,21973,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,21974,0)
 ;;=K50.914^^89^1041^23
 ;;^UTILITY(U,$J,358.3,21974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21974,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,21974,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,21974,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,21975,0)
 ;;=K50.913^^89^1041^24
 ;;^UTILITY(U,$J,358.3,21975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21975,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,21975,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,21975,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,21976,0)
 ;;=K50.918^^89^1041^26
 ;;^UTILITY(U,$J,358.3,21976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21976,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,21976,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,21976,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,21977,0)
 ;;=K51.90^^89^1041^80
 ;;^UTILITY(U,$J,358.3,21977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21977,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,21977,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,21977,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,21978,0)
 ;;=K51.919^^89^1041^79
 ;;^UTILITY(U,$J,358.3,21978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21978,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,21978,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,21978,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,21979,0)
 ;;=K51.918^^89^1041^77
 ;;^UTILITY(U,$J,358.3,21979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21979,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,21979,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,21979,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,21980,0)
 ;;=K51.914^^89^1041^74
 ;;^UTILITY(U,$J,358.3,21980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21980,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,21980,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,21980,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,21981,0)
 ;;=K51.913^^89^1041^75
 ;;^UTILITY(U,$J,358.3,21981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21981,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,21981,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,21981,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,21982,0)
 ;;=K51.912^^89^1041^76
 ;;^UTILITY(U,$J,358.3,21982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21982,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,21982,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,21982,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,21983,0)
 ;;=K51.911^^89^1041^78
 ;;^UTILITY(U,$J,358.3,21983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21983,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,21983,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,21983,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,21984,0)
 ;;=K52.89^^89^1041^54
 ;;^UTILITY(U,$J,358.3,21984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21984,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,21984,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,21984,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,21985,0)
 ;;=K52.9^^89^1041^53
 ;;^UTILITY(U,$J,358.3,21985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21985,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,21985,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,21985,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,21986,0)
 ;;=K57.30^^89^1041^42
 ;;^UTILITY(U,$J,358.3,21986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21986,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21986,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,21986,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,21987,0)
 ;;=K57.50^^89^1041^43
 ;;^UTILITY(U,$J,358.3,21987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21987,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21987,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,21987,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,21988,0)
 ;;=K57.90^^89^1041^41
 ;;^UTILITY(U,$J,358.3,21988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21988,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21988,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,21988,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,21989,0)
 ;;=K57.20^^89^1041^37
 ;;^UTILITY(U,$J,358.3,21989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21989,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21989,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,21989,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,21990,0)
 ;;=K57.92^^89^1041^36
 ;;^UTILITY(U,$J,358.3,21990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21990,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21990,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,21990,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,21991,0)
 ;;=K57.80^^89^1041^35
 ;;^UTILITY(U,$J,358.3,21991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21991,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21991,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,21991,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,21992,0)
 ;;=K57.52^^89^1041^40
 ;;^UTILITY(U,$J,358.3,21992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21992,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21992,1,4,0)
 ;;=4^K57.52
 ;;^UTILITY(U,$J,358.3,21992,2)
 ;;=^5008731
 ;;^UTILITY(U,$J,358.3,21993,0)
 ;;=K57.40^^89^1041^39
 ;;^UTILITY(U,$J,358.3,21993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21993,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21993,1,4,0)
 ;;=4^K57.40
 ;;^UTILITY(U,$J,358.3,21993,2)
 ;;=^5008727
 ;;^UTILITY(U,$J,358.3,21994,0)
 ;;=K57.32^^89^1041^38
 ;;^UTILITY(U,$J,358.3,21994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21994,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21994,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,21994,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,21995,0)
 ;;=K59.00^^89^1041^20
 ;;^UTILITY(U,$J,358.3,21995,1,0)
 ;;=^358.31IA^4^2

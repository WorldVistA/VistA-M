IBDEI0AA ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13038,0)
 ;;=I85.00^^43^619^46
 ;;^UTILITY(U,$J,358.3,13038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13038,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13038,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,13038,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,13039,0)
 ;;=K20.9^^43^619^47
 ;;^UTILITY(U,$J,358.3,13039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13039,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,13039,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,13039,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,13040,0)
 ;;=K21.9^^43^619^55
 ;;^UTILITY(U,$J,358.3,13040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13040,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,13040,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,13040,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,13041,0)
 ;;=K25.7^^43^619^50
 ;;^UTILITY(U,$J,358.3,13041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13041,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,13041,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,13041,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,13042,0)
 ;;=K26.9^^43^619^44
 ;;^UTILITY(U,$J,358.3,13042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13042,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,13042,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,13042,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,13043,0)
 ;;=K27.9^^43^619^72
 ;;^UTILITY(U,$J,358.3,13043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13043,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,13043,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,13043,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,13044,0)
 ;;=K29.70^^43^619^51
 ;;^UTILITY(U,$J,358.3,13044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13044,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,13044,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,13044,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,13045,0)
 ;;=K29.90^^43^619^52
 ;;^UTILITY(U,$J,358.3,13045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13045,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,13045,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,13045,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,13046,0)
 ;;=K30.^^43^619^45
 ;;^UTILITY(U,$J,358.3,13046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13046,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,13046,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,13046,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,13047,0)
 ;;=K31.89^^43^619^34
 ;;^UTILITY(U,$J,358.3,13047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13047,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,13047,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,13047,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,13048,0)
 ;;=K31.9^^43^619^33
 ;;^UTILITY(U,$J,358.3,13048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13048,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,13048,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,13048,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,13049,0)
 ;;=K40.90^^43^619^68
 ;;^UTILITY(U,$J,358.3,13049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13049,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,13049,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,13049,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,13050,0)
 ;;=K40.20^^43^619^67
 ;;^UTILITY(U,$J,358.3,13050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13050,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,13050,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,13050,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,13051,0)
 ;;=K44.9^^43^619^31
 ;;^UTILITY(U,$J,358.3,13051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13051,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,13051,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,13051,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,13052,0)
 ;;=K46.9^^43^619^1
 ;;^UTILITY(U,$J,358.3,13052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13052,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,13052,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,13052,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,13053,0)
 ;;=K50.90^^43^619^29
 ;;^UTILITY(U,$J,358.3,13053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13053,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,13053,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,13053,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,13054,0)
 ;;=K50.911^^43^619^27
 ;;^UTILITY(U,$J,358.3,13054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13054,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,13054,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,13054,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,13055,0)
 ;;=K50.912^^43^619^25
 ;;^UTILITY(U,$J,358.3,13055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13055,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,13055,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,13055,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,13056,0)
 ;;=K50.919^^43^619^28
 ;;^UTILITY(U,$J,358.3,13056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13056,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,13056,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,13056,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,13057,0)
 ;;=K50.914^^43^619^23
 ;;^UTILITY(U,$J,358.3,13057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13057,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,13057,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,13057,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,13058,0)
 ;;=K50.913^^43^619^24
 ;;^UTILITY(U,$J,358.3,13058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13058,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,13058,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,13058,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,13059,0)
 ;;=K50.918^^43^619^26
 ;;^UTILITY(U,$J,358.3,13059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13059,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,13059,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,13059,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,13060,0)
 ;;=K51.90^^43^619^80
 ;;^UTILITY(U,$J,358.3,13060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13060,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,13060,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,13060,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,13061,0)
 ;;=K51.919^^43^619^79
 ;;^UTILITY(U,$J,358.3,13061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13061,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,13061,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,13061,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,13062,0)
 ;;=K51.918^^43^619^77
 ;;^UTILITY(U,$J,358.3,13062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13062,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,13062,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,13062,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,13063,0)
 ;;=K51.914^^43^619^74
 ;;^UTILITY(U,$J,358.3,13063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13063,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,13063,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,13063,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,13064,0)
 ;;=K51.913^^43^619^75
 ;;^UTILITY(U,$J,358.3,13064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13064,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,13064,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,13064,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,13065,0)
 ;;=K51.912^^43^619^76
 ;;^UTILITY(U,$J,358.3,13065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13065,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,13065,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,13065,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,13066,0)
 ;;=K51.911^^43^619^78
 ;;^UTILITY(U,$J,358.3,13066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13066,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,13066,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,13066,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,13067,0)
 ;;=K52.89^^43^619^54
 ;;^UTILITY(U,$J,358.3,13067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13067,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,13067,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,13067,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,13068,0)
 ;;=K52.9^^43^619^53
 ;;^UTILITY(U,$J,358.3,13068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13068,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,13068,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,13068,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,13069,0)
 ;;=K57.30^^43^619^42
 ;;^UTILITY(U,$J,358.3,13069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13069,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13069,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,13069,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,13070,0)
 ;;=K57.50^^43^619^43
 ;;^UTILITY(U,$J,358.3,13070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13070,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13070,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,13070,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,13071,0)
 ;;=K57.90^^43^619^41
 ;;^UTILITY(U,$J,358.3,13071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13071,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13071,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,13071,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,13072,0)
 ;;=K57.20^^43^619^37
 ;;^UTILITY(U,$J,358.3,13072,1,0)
 ;;=^358.31IA^4^2

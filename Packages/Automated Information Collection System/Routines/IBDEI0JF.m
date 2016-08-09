IBDEI0JF ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19574,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,19574,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,19574,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,19575,0)
 ;;=K27.9^^86^989^72
 ;;^UTILITY(U,$J,358.3,19575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19575,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,19575,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,19575,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,19576,0)
 ;;=K29.70^^86^989^51
 ;;^UTILITY(U,$J,358.3,19576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19576,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,19576,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,19576,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,19577,0)
 ;;=K29.90^^86^989^52
 ;;^UTILITY(U,$J,358.3,19577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19577,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,19577,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,19577,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,19578,0)
 ;;=K30.^^86^989^45
 ;;^UTILITY(U,$J,358.3,19578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19578,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,19578,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,19578,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,19579,0)
 ;;=K31.89^^86^989^34
 ;;^UTILITY(U,$J,358.3,19579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19579,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,19579,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,19579,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,19580,0)
 ;;=K31.9^^86^989^33
 ;;^UTILITY(U,$J,358.3,19580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19580,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,19580,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,19580,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,19581,0)
 ;;=K40.90^^86^989^68
 ;;^UTILITY(U,$J,358.3,19581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19581,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,19581,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,19581,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,19582,0)
 ;;=K40.20^^86^989^67
 ;;^UTILITY(U,$J,358.3,19582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19582,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,19582,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,19582,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,19583,0)
 ;;=K44.9^^86^989^31
 ;;^UTILITY(U,$J,358.3,19583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19583,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,19583,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,19583,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,19584,0)
 ;;=K46.9^^86^989^1
 ;;^UTILITY(U,$J,358.3,19584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19584,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,19584,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,19584,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,19585,0)
 ;;=K50.90^^86^989^29
 ;;^UTILITY(U,$J,358.3,19585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19585,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,19585,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,19585,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,19586,0)
 ;;=K50.911^^86^989^27
 ;;^UTILITY(U,$J,358.3,19586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19586,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,19586,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,19586,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,19587,0)
 ;;=K50.912^^86^989^25
 ;;^UTILITY(U,$J,358.3,19587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19587,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,19587,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,19587,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,19588,0)
 ;;=K50.919^^86^989^28
 ;;^UTILITY(U,$J,358.3,19588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19588,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,19588,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,19588,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,19589,0)
 ;;=K50.914^^86^989^23
 ;;^UTILITY(U,$J,358.3,19589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19589,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,19589,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,19589,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,19590,0)
 ;;=K50.913^^86^989^24
 ;;^UTILITY(U,$J,358.3,19590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19590,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,19590,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,19590,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,19591,0)
 ;;=K50.918^^86^989^26
 ;;^UTILITY(U,$J,358.3,19591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19591,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,19591,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,19591,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,19592,0)
 ;;=K51.90^^86^989^80
 ;;^UTILITY(U,$J,358.3,19592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19592,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,19592,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,19592,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,19593,0)
 ;;=K51.919^^86^989^79
 ;;^UTILITY(U,$J,358.3,19593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19593,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,19593,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,19593,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,19594,0)
 ;;=K51.918^^86^989^77
 ;;^UTILITY(U,$J,358.3,19594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19594,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,19594,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,19594,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,19595,0)
 ;;=K51.914^^86^989^74
 ;;^UTILITY(U,$J,358.3,19595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19595,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,19595,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,19595,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,19596,0)
 ;;=K51.913^^86^989^75
 ;;^UTILITY(U,$J,358.3,19596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19596,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,19596,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,19596,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,19597,0)
 ;;=K51.912^^86^989^76
 ;;^UTILITY(U,$J,358.3,19597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19597,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,19597,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,19597,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,19598,0)
 ;;=K51.911^^86^989^78
 ;;^UTILITY(U,$J,358.3,19598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19598,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,19598,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,19598,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,19599,0)
 ;;=K52.89^^86^989^54
 ;;^UTILITY(U,$J,358.3,19599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19599,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,19599,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,19599,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,19600,0)
 ;;=K52.9^^86^989^53
 ;;^UTILITY(U,$J,358.3,19600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19600,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,19600,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,19600,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,19601,0)
 ;;=K57.30^^86^989^42
 ;;^UTILITY(U,$J,358.3,19601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19601,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding

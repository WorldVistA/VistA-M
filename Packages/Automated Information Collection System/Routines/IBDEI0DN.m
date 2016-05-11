IBDEI0DN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6266,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,6266,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,6266,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,6267,0)
 ;;=K31.9^^30^391^33
 ;;^UTILITY(U,$J,358.3,6267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6267,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,6267,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,6267,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,6268,0)
 ;;=K40.90^^30^391^69
 ;;^UTILITY(U,$J,358.3,6268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6268,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,6268,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,6268,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,6269,0)
 ;;=K40.20^^30^391^68
 ;;^UTILITY(U,$J,358.3,6269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6269,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,6269,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,6269,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,6270,0)
 ;;=K44.9^^30^391^31
 ;;^UTILITY(U,$J,358.3,6270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6270,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,6270,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,6270,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,6271,0)
 ;;=K46.9^^30^391^1
 ;;^UTILITY(U,$J,358.3,6271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6271,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,6271,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,6271,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,6272,0)
 ;;=K50.90^^30^391^29
 ;;^UTILITY(U,$J,358.3,6272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6272,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6272,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,6272,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,6273,0)
 ;;=K50.911^^30^391^27
 ;;^UTILITY(U,$J,358.3,6273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6273,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6273,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,6273,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,6274,0)
 ;;=K50.912^^30^391^25
 ;;^UTILITY(U,$J,358.3,6274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6274,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,6274,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,6274,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,6275,0)
 ;;=K50.919^^30^391^28
 ;;^UTILITY(U,$J,358.3,6275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6275,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6275,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,6275,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,6276,0)
 ;;=K50.914^^30^391^23
 ;;^UTILITY(U,$J,358.3,6276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6276,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,6276,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,6276,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,6277,0)
 ;;=K50.913^^30^391^24
 ;;^UTILITY(U,$J,358.3,6277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6277,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,6277,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,6277,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,6278,0)
 ;;=K50.918^^30^391^26
 ;;^UTILITY(U,$J,358.3,6278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6278,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,6278,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,6278,2)
 ;;=^5008650

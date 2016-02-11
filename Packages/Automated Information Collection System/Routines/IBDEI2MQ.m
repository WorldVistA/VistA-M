IBDEI2MQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44130,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,44130,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,44130,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,44131,0)
 ;;=K46.9^^200^2223^1
 ;;^UTILITY(U,$J,358.3,44131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44131,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,44131,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,44131,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,44132,0)
 ;;=K50.90^^200^2223^29
 ;;^UTILITY(U,$J,358.3,44132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44132,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,44132,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,44132,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,44133,0)
 ;;=K50.911^^200^2223^27
 ;;^UTILITY(U,$J,358.3,44133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44133,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,44133,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,44133,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,44134,0)
 ;;=K50.912^^200^2223^25
 ;;^UTILITY(U,$J,358.3,44134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44134,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,44134,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,44134,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,44135,0)
 ;;=K50.919^^200^2223^28
 ;;^UTILITY(U,$J,358.3,44135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44135,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,44135,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,44135,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,44136,0)
 ;;=K50.914^^200^2223^23
 ;;^UTILITY(U,$J,358.3,44136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44136,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,44136,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,44136,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,44137,0)
 ;;=K50.913^^200^2223^24
 ;;^UTILITY(U,$J,358.3,44137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44137,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,44137,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,44137,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,44138,0)
 ;;=K50.918^^200^2223^26
 ;;^UTILITY(U,$J,358.3,44138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44138,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,44138,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,44138,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,44139,0)
 ;;=K51.90^^200^2223^80
 ;;^UTILITY(U,$J,358.3,44139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44139,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,44139,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,44139,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,44140,0)
 ;;=K51.919^^200^2223^79
 ;;^UTILITY(U,$J,358.3,44140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44140,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,44140,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,44140,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,44141,0)
 ;;=K51.918^^200^2223^77
 ;;^UTILITY(U,$J,358.3,44141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44141,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,44141,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,44141,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,44142,0)
 ;;=K51.914^^200^2223^74
 ;;^UTILITY(U,$J,358.3,44142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44142,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,44142,1,4,0)
 ;;=4^K51.914

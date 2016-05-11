IBDEI1AW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22117,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,22117,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,22117,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,22118,0)
 ;;=K40.20^^87^976^67
 ;;^UTILITY(U,$J,358.3,22118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22118,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,22118,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,22118,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,22119,0)
 ;;=K44.9^^87^976^31
 ;;^UTILITY(U,$J,358.3,22119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22119,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,22119,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,22119,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,22120,0)
 ;;=K46.9^^87^976^1
 ;;^UTILITY(U,$J,358.3,22120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22120,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,22120,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,22120,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,22121,0)
 ;;=K50.90^^87^976^29
 ;;^UTILITY(U,$J,358.3,22121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22121,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,22121,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,22121,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,22122,0)
 ;;=K50.911^^87^976^27
 ;;^UTILITY(U,$J,358.3,22122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22122,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,22122,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,22122,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,22123,0)
 ;;=K50.912^^87^976^25
 ;;^UTILITY(U,$J,358.3,22123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22123,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,22123,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,22123,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,22124,0)
 ;;=K50.919^^87^976^28
 ;;^UTILITY(U,$J,358.3,22124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22124,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,22124,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,22124,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,22125,0)
 ;;=K50.914^^87^976^23
 ;;^UTILITY(U,$J,358.3,22125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22125,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,22125,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,22125,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,22126,0)
 ;;=K50.913^^87^976^24
 ;;^UTILITY(U,$J,358.3,22126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22126,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,22126,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,22126,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,22127,0)
 ;;=K50.918^^87^976^26
 ;;^UTILITY(U,$J,358.3,22127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22127,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,22127,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,22127,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,22128,0)
 ;;=K51.90^^87^976^80
 ;;^UTILITY(U,$J,358.3,22128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22128,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,22128,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,22128,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,22129,0)
 ;;=K51.919^^87^976^79
 ;;^UTILITY(U,$J,358.3,22129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22129,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,22129,1,4,0)
 ;;=4^K51.919

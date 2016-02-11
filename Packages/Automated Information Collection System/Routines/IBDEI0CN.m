IBDEI0CN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5478,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,5478,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,5479,0)
 ;;=K21.9^^40^367^35
 ;;^UTILITY(U,$J,358.3,5479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5479,1,3,0)
 ;;=3^Gastro-Esophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,5479,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,5479,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,5480,0)
 ;;=K22.10^^40^367^32
 ;;^UTILITY(U,$J,358.3,5480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5480,1,3,0)
 ;;=3^Esophagus Ulcer w/o Bleeding
 ;;^UTILITY(U,$J,358.3,5480,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,5480,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,5481,0)
 ;;=K22.2^^40^367^31
 ;;^UTILITY(U,$J,358.3,5481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5481,1,3,0)
 ;;=3^Esophageal Obstruction
 ;;^UTILITY(U,$J,358.3,5481,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,5481,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,5482,0)
 ;;=K25.9^^40^367^34
 ;;^UTILITY(U,$J,358.3,5482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5482,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,5482,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,5482,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,5483,0)
 ;;=K27.9^^40^367^87
 ;;^UTILITY(U,$J,358.3,5483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5483,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,5483,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,5483,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,5484,0)
 ;;=K40.20^^40^367^13
 ;;^UTILITY(U,$J,358.3,5484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5484,1,3,0)
 ;;=3^Bilateral Inguinal Hernia
 ;;^UTILITY(U,$J,358.3,5484,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,5484,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,5485,0)
 ;;=K40.90^^40^367^94
 ;;^UTILITY(U,$J,358.3,5485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5485,1,3,0)
 ;;=3^Unilateral Inguinal Hernia
 ;;^UTILITY(U,$J,358.3,5485,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,5485,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,5486,0)
 ;;=K42.9^^40^367^93
 ;;^UTILITY(U,$J,358.3,5486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5486,1,3,0)
 ;;=3^Umbilical Hernia w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,5486,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,5486,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,5487,0)
 ;;=K43.9^^40^367^95
 ;;^UTILITY(U,$J,358.3,5487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5487,1,3,0)
 ;;=3^Ventral Hernia w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,5487,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,5487,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,5488,0)
 ;;=K44.9^^40^367^24
 ;;^UTILITY(U,$J,358.3,5488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5488,1,3,0)
 ;;=3^Diaphragmatic Hernia
 ;;^UTILITY(U,$J,358.3,5488,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,5488,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,5489,0)
 ;;=K56.49^^40^367^43
 ;;^UTILITY(U,$J,358.3,5489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5489,1,3,0)
 ;;=3^Impaction of Intestine NEC
 ;;^UTILITY(U,$J,358.3,5489,1,4,0)
 ;;=4^K56.49
 ;;^UTILITY(U,$J,358.3,5489,2)
 ;;=^87650
 ;;^UTILITY(U,$J,358.3,5490,0)
 ;;=K58.0^^40^367^46
 ;;^UTILITY(U,$J,358.3,5490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5490,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,5490,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,5490,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,5491,0)
 ;;=K58.9^^40^367^47
 ;;^UTILITY(U,$J,358.3,5491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5491,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,5491,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,5491,2)
 ;;=^5008740

IBDEI03F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1064,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,1065,0)
 ;;=K29.70^^3^37^53
 ;;^UTILITY(U,$J,358.3,1065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1065,1,3,0)
 ;;=3^Gastritis, unspecified, without bleeding
 ;;^UTILITY(U,$J,358.3,1065,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,1065,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,1066,0)
 ;;=K29.80^^3^37^37
 ;;^UTILITY(U,$J,358.3,1066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1066,1,3,0)
 ;;=3^Duodenitis without bleeding
 ;;^UTILITY(U,$J,358.3,1066,1,4,0)
 ;;=4^K29.80
 ;;^UTILITY(U,$J,358.3,1066,2)
 ;;=^5008554
 ;;^UTILITY(U,$J,358.3,1067,0)
 ;;=K30.^^3^37^51
 ;;^UTILITY(U,$J,358.3,1067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1067,1,3,0)
 ;;=3^Functional dyspepsia
 ;;^UTILITY(U,$J,358.3,1067,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,1067,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,1068,0)
 ;;=K31.9^^3^37^35
 ;;^UTILITY(U,$J,358.3,1068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1068,1,3,0)
 ;;=3^Disease of stomach and duodenum, unspecified
 ;;^UTILITY(U,$J,358.3,1068,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,1068,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,1069,0)
 ;;=K40.90^^3^37^101
 ;;^UTILITY(U,$J,358.3,1069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1069,1,3,0)
 ;;=3^Unil inguinal hernia, w/o obst or gangr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,1069,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,1069,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,1070,0)
 ;;=K40.20^^3^37^15
 ;;^UTILITY(U,$J,358.3,1070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1070,1,3,0)
 ;;=3^Bi inguinal hernia, w/o obst or gangrene, not spcf as recur
 ;;^UTILITY(U,$J,358.3,1070,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,1070,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,1071,0)
 ;;=K41.90^^3^37^100
 ;;^UTILITY(U,$J,358.3,1071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1071,1,3,0)
 ;;=3^Unil femoral hernia, w/o obst or gangrene, not spcf as recur
 ;;^UTILITY(U,$J,358.3,1071,1,4,0)
 ;;=4^K41.90
 ;;^UTILITY(U,$J,358.3,1071,2)
 ;;=^5008603
 ;;^UTILITY(U,$J,358.3,1072,0)
 ;;=K42.9^^3^37^99
 ;;^UTILITY(U,$J,358.3,1072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1072,1,3,0)
 ;;=3^Umbilical hernia without obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,1072,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,1072,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,1073,0)
 ;;=K43.9^^3^37^102
 ;;^UTILITY(U,$J,358.3,1073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1073,1,3,0)
 ;;=3^Ventral hernia without obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,1073,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,1073,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,1074,0)
 ;;=K44.9^^3^37^33
 ;;^UTILITY(U,$J,358.3,1074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1074,1,3,0)
 ;;=3^Diaphragmatic hernia without obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,1074,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,1074,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,1075,0)
 ;;=K50.90^^3^37^32
 ;;^UTILITY(U,$J,358.3,1075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1075,1,3,0)
 ;;=3^Crohn's disease, unspecified, without complications
 ;;^UTILITY(U,$J,358.3,1075,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,1075,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,1076,0)
 ;;=K51.90^^3^37^98
 ;;^UTILITY(U,$J,358.3,1076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1076,1,3,0)
 ;;=3^Ulcerative colitis, unspecified, without complications
 ;;^UTILITY(U,$J,358.3,1076,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,1076,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,1077,0)
 ;;=K52.9^^3^37^77
 ;;^UTILITY(U,$J,358.3,1077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1077,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified

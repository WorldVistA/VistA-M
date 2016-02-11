IBDEI0I8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8178,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,8179,0)
 ;;=K29.70^^55^536^53
 ;;^UTILITY(U,$J,358.3,8179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8179,1,3,0)
 ;;=3^Gastritis, unspecified, without bleeding
 ;;^UTILITY(U,$J,358.3,8179,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,8179,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,8180,0)
 ;;=K29.80^^55^536^37
 ;;^UTILITY(U,$J,358.3,8180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8180,1,3,0)
 ;;=3^Duodenitis without bleeding
 ;;^UTILITY(U,$J,358.3,8180,1,4,0)
 ;;=4^K29.80
 ;;^UTILITY(U,$J,358.3,8180,2)
 ;;=^5008554
 ;;^UTILITY(U,$J,358.3,8181,0)
 ;;=K30.^^55^536^51
 ;;^UTILITY(U,$J,358.3,8181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8181,1,3,0)
 ;;=3^Functional dyspepsia
 ;;^UTILITY(U,$J,358.3,8181,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,8181,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,8182,0)
 ;;=K31.9^^55^536^35
 ;;^UTILITY(U,$J,358.3,8182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8182,1,3,0)
 ;;=3^Disease of stomach and duodenum, unspecified
 ;;^UTILITY(U,$J,358.3,8182,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,8182,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,8183,0)
 ;;=K40.90^^55^536^101
 ;;^UTILITY(U,$J,358.3,8183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8183,1,3,0)
 ;;=3^Unil inguinal hernia, w/o obst or gangr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,8183,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,8183,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,8184,0)
 ;;=K40.20^^55^536^15
 ;;^UTILITY(U,$J,358.3,8184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8184,1,3,0)
 ;;=3^Bi inguinal hernia, w/o obst or gangrene, not spcf as recur
 ;;^UTILITY(U,$J,358.3,8184,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,8184,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,8185,0)
 ;;=K41.90^^55^536^100
 ;;^UTILITY(U,$J,358.3,8185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8185,1,3,0)
 ;;=3^Unil femoral hernia, w/o obst or gangrene, not spcf as recur
 ;;^UTILITY(U,$J,358.3,8185,1,4,0)
 ;;=4^K41.90
 ;;^UTILITY(U,$J,358.3,8185,2)
 ;;=^5008603
 ;;^UTILITY(U,$J,358.3,8186,0)
 ;;=K42.9^^55^536^99
 ;;^UTILITY(U,$J,358.3,8186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8186,1,3,0)
 ;;=3^Umbilical hernia without obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,8186,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,8186,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,8187,0)
 ;;=K43.9^^55^536^102
 ;;^UTILITY(U,$J,358.3,8187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8187,1,3,0)
 ;;=3^Ventral hernia without obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,8187,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,8187,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,8188,0)
 ;;=K44.9^^55^536^33
 ;;^UTILITY(U,$J,358.3,8188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8188,1,3,0)
 ;;=3^Diaphragmatic hernia without obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,8188,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,8188,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,8189,0)
 ;;=K50.90^^55^536^32
 ;;^UTILITY(U,$J,358.3,8189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8189,1,3,0)
 ;;=3^Crohn's disease, unspecified, without complications
 ;;^UTILITY(U,$J,358.3,8189,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,8189,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,8190,0)
 ;;=K51.90^^55^536^98
 ;;^UTILITY(U,$J,358.3,8190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8190,1,3,0)
 ;;=3^Ulcerative colitis, unspecified, without complications
 ;;^UTILITY(U,$J,358.3,8190,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,8190,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,8191,0)
 ;;=K52.9^^55^536^77
 ;;^UTILITY(U,$J,358.3,8191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8191,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified

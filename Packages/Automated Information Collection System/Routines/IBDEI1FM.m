IBDEI1FM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23910,2)
 ;;=^5006943
 ;;^UTILITY(U,$J,358.3,23911,0)
 ;;=I10.^^116^1170^26
 ;;^UTILITY(U,$J,358.3,23911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23911,1,3,0)
 ;;=3^Hypertension, essential (primary)
 ;;^UTILITY(U,$J,358.3,23911,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,23911,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,23912,0)
 ;;=K64.8^^116^1170^15
 ;;^UTILITY(U,$J,358.3,23912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23912,1,3,0)
 ;;=3^Hemorrhoids, oth
 ;;^UTILITY(U,$J,358.3,23912,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,23912,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,23913,0)
 ;;=K64.4^^116^1170^14
 ;;^UTILITY(U,$J,358.3,23913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23913,1,3,0)
 ;;=3^Hemorrhoidal Skin Tags,Residual
 ;;^UTILITY(U,$J,358.3,23913,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,23913,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,23914,0)
 ;;=I95.9^^116^1170^32
 ;;^UTILITY(U,$J,358.3,23914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23914,1,3,0)
 ;;=3^Hypotension, unspec
 ;;^UTILITY(U,$J,358.3,23914,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,23914,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,23915,0)
 ;;=K40.90^^116^1170^36
 ;;^UTILITY(U,$J,358.3,23915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23915,1,3,0)
 ;;=3^Uniltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,23915,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,23915,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,23916,0)
 ;;=K40.20^^116^1170^4
 ;;^UTILITY(U,$J,358.3,23916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23916,1,3,0)
 ;;=3^Biltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,23916,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,23916,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,23917,0)
 ;;=K42.9^^116^1170^35
 ;;^UTILITY(U,$J,358.3,23917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23917,1,3,0)
 ;;=3^Umbilical hernia w/o obst/gangr or gangrene
 ;;^UTILITY(U,$J,358.3,23917,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,23917,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,23918,0)
 ;;=K43.2^^116^1170^34
 ;;^UTILITY(U,$J,358.3,23918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23918,1,3,0)
 ;;=3^Incisional hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,23918,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,23918,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,23919,0)
 ;;=K44.9^^116^1170^5
 ;;^UTILITY(U,$J,358.3,23919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23919,1,3,0)
 ;;=3^Diaphragmatic hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,23919,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,23919,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,23920,0)
 ;;=K46.9^^116^1170^1
 ;;^UTILITY(U,$J,358.3,23920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23920,1,3,0)
 ;;=3^Abdominal hernia w/o obstr/gangr, unspec
 ;;^UTILITY(U,$J,358.3,23920,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,23920,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,23921,0)
 ;;=K73.9^^116^1170^19
 ;;^UTILITY(U,$J,358.3,23921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23921,1,3,0)
 ;;=3^Hepatitis C,Chronic Unspec
 ;;^UTILITY(U,$J,358.3,23921,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,23921,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,23922,0)
 ;;=R31.9^^116^1170^8
 ;;^UTILITY(U,$J,358.3,23922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23922,1,3,0)
 ;;=3^Hematuria, unspec
 ;;^UTILITY(U,$J,358.3,23922,1,4,0)
 ;;=4^R31.9
 ;;^UTILITY(U,$J,358.3,23922,2)
 ;;=^5019328
 ;;^UTILITY(U,$J,358.3,23923,0)
 ;;=N43.3^^116^1170^22
 ;;^UTILITY(U,$J,358.3,23923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23923,1,3,0)
 ;;=3^Hydrocele, unspec
 ;;^UTILITY(U,$J,358.3,23923,1,4,0)
 ;;=4^N43.3

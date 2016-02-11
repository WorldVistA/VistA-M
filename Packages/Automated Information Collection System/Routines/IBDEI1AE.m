IBDEI1AE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21504,1,4,0)
 ;;=4^S06.310S
 ;;^UTILITY(U,$J,358.3,21504,2)
 ;;=^5020788
 ;;^UTILITY(U,$J,358.3,21505,0)
 ;;=S06.385S^^101^1032^29
 ;;^UTILITY(U,$J,358.3,21505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21505,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21505,1,4,0)
 ;;=4^S06.385S
 ;;^UTILITY(U,$J,358.3,21505,2)
 ;;=^5021013
 ;;^UTILITY(U,$J,358.3,21506,0)
 ;;=S06.386S^^101^1032^30
 ;;^UTILITY(U,$J,358.3,21506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21506,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,21506,1,4,0)
 ;;=4^S06.386S
 ;;^UTILITY(U,$J,358.3,21506,2)
 ;;=^5021016
 ;;^UTILITY(U,$J,358.3,21507,0)
 ;;=S06.383S^^101^1032^31
 ;;^UTILITY(U,$J,358.3,21507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21507,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21507,1,4,0)
 ;;=4^S06.383S
 ;;^UTILITY(U,$J,358.3,21507,2)
 ;;=^5021007
 ;;^UTILITY(U,$J,358.3,21508,0)
 ;;=S06.381S^^101^1032^32
 ;;^UTILITY(U,$J,358.3,21508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21508,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21508,1,4,0)
 ;;=4^S06.381S
 ;;^UTILITY(U,$J,358.3,21508,2)
 ;;=^5021001
 ;;^UTILITY(U,$J,358.3,21509,0)
 ;;=S06.382S^^101^1032^33
 ;;^UTILITY(U,$J,358.3,21509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21509,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,21509,1,4,0)
 ;;=4^S06.382S
 ;;^UTILITY(U,$J,358.3,21509,2)
 ;;=^5021004
 ;;^UTILITY(U,$J,358.3,21510,0)
 ;;=S06.384S^^101^1032^34
 ;;^UTILITY(U,$J,358.3,21510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21510,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,21510,1,4,0)
 ;;=4^S06.384S
 ;;^UTILITY(U,$J,358.3,21510,2)
 ;;=^5021010
 ;;^UTILITY(U,$J,358.3,21511,0)
 ;;=S06.389S^^101^1032^35
 ;;^UTILITY(U,$J,358.3,21511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21511,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21511,1,4,0)
 ;;=4^S06.389S
 ;;^UTILITY(U,$J,358.3,21511,2)
 ;;=^5021025
 ;;^UTILITY(U,$J,358.3,21512,0)
 ;;=S06.380S^^101^1032^36
 ;;^UTILITY(U,$J,358.3,21512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21512,1,3,0)
 ;;=3^Contus/lac/hem brnst w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,21512,1,4,0)
 ;;=4^S06.380S
 ;;^UTILITY(U,$J,358.3,21512,2)
 ;;=^5020998
 ;;^UTILITY(U,$J,358.3,21513,0)
 ;;=S06.375S^^101^1032^37
 ;;^UTILITY(U,$J,358.3,21513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21513,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21513,1,4,0)
 ;;=4^S06.375S
 ;;^UTILITY(U,$J,358.3,21513,2)
 ;;=^5020983
 ;;^UTILITY(U,$J,358.3,21514,0)
 ;;=S06.376S^^101^1032^38
 ;;^UTILITY(U,$J,358.3,21514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21514,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,21514,1,4,0)
 ;;=4^S06.376S
 ;;^UTILITY(U,$J,358.3,21514,2)
 ;;=^5020986
 ;;^UTILITY(U,$J,358.3,21515,0)
 ;;=S06.373S^^101^1032^39
 ;;^UTILITY(U,$J,358.3,21515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21515,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21515,1,4,0)
 ;;=4^S06.373S
 ;;^UTILITY(U,$J,358.3,21515,2)
 ;;=^5020977
 ;;^UTILITY(U,$J,358.3,21516,0)
 ;;=S06.371S^^101^1032^40
 ;;^UTILITY(U,$J,358.3,21516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21516,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 30 minutes or less, sequela

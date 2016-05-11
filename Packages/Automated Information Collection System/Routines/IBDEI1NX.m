IBDEI1NX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28249,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Unstageable
 ;;^UTILITY(U,$J,358.3,28249,1,4,0)
 ;;=4^L89.320
 ;;^UTILITY(U,$J,358.3,28249,2)
 ;;=^5009399
 ;;^UTILITY(U,$J,358.3,28250,0)
 ;;=L89.321^^112^1416^19
 ;;^UTILITY(U,$J,358.3,28250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28250,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 1
 ;;^UTILITY(U,$J,358.3,28250,1,4,0)
 ;;=4^L89.321
 ;;^UTILITY(U,$J,358.3,28250,2)
 ;;=^5009400
 ;;^UTILITY(U,$J,358.3,28251,0)
 ;;=L89.322^^112^1416^20
 ;;^UTILITY(U,$J,358.3,28251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28251,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 2
 ;;^UTILITY(U,$J,358.3,28251,1,4,0)
 ;;=4^L89.322
 ;;^UTILITY(U,$J,358.3,28251,2)
 ;;=^5009401
 ;;^UTILITY(U,$J,358.3,28252,0)
 ;;=L89.323^^112^1416^21
 ;;^UTILITY(U,$J,358.3,28252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28252,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 3
 ;;^UTILITY(U,$J,358.3,28252,1,4,0)
 ;;=4^L89.323
 ;;^UTILITY(U,$J,358.3,28252,2)
 ;;=^5009402
 ;;^UTILITY(U,$J,358.3,28253,0)
 ;;=L89.324^^112^1416^22
 ;;^UTILITY(U,$J,358.3,28253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28253,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 4
 ;;^UTILITY(U,$J,358.3,28253,1,4,0)
 ;;=4^L89.324
 ;;^UTILITY(U,$J,358.3,28253,2)
 ;;=^5009403
 ;;^UTILITY(U,$J,358.3,28254,0)
 ;;=L89.329^^112^1416^23
 ;;^UTILITY(U,$J,358.3,28254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28254,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage Unspec
 ;;^UTILITY(U,$J,358.3,28254,1,4,0)
 ;;=4^L89.329
 ;;^UTILITY(U,$J,358.3,28254,2)
 ;;=^5133671
 ;;^UTILITY(U,$J,358.3,28255,0)
 ;;=L89.40^^112^1416^1
 ;;^UTILITY(U,$J,358.3,28255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28255,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage Unspec
 ;;^UTILITY(U,$J,358.3,28255,1,4,0)
 ;;=4^L89.40
 ;;^UTILITY(U,$J,358.3,28255,2)
 ;;=^5009404
 ;;^UTILITY(U,$J,358.3,28256,0)
 ;;=L89.41^^112^1416^2
 ;;^UTILITY(U,$J,358.3,28256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28256,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 1
 ;;^UTILITY(U,$J,358.3,28256,1,4,0)
 ;;=4^L89.41
 ;;^UTILITY(U,$J,358.3,28256,2)
 ;;=^5009405
 ;;^UTILITY(U,$J,358.3,28257,0)
 ;;=L89.42^^112^1416^3
 ;;^UTILITY(U,$J,358.3,28257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28257,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 2
 ;;^UTILITY(U,$J,358.3,28257,1,4,0)
 ;;=4^L89.42
 ;;^UTILITY(U,$J,358.3,28257,2)
 ;;=^5009406
 ;;^UTILITY(U,$J,358.3,28258,0)
 ;;=L89.43^^112^1416^4
 ;;^UTILITY(U,$J,358.3,28258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28258,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 3
 ;;^UTILITY(U,$J,358.3,28258,1,4,0)
 ;;=4^L89.43
 ;;^UTILITY(U,$J,358.3,28258,2)
 ;;=^5009407
 ;;^UTILITY(U,$J,358.3,28259,0)
 ;;=L89.44^^112^1416^5
 ;;^UTILITY(U,$J,358.3,28259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28259,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 4
 ;;^UTILITY(U,$J,358.3,28259,1,4,0)
 ;;=4^L89.44
 ;;^UTILITY(U,$J,358.3,28259,2)
 ;;=^5009408
 ;;^UTILITY(U,$J,358.3,28260,0)
 ;;=L89.45^^112^1416^6
 ;;^UTILITY(U,$J,358.3,28260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28260,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Unstageable
 ;;^UTILITY(U,$J,358.3,28260,1,4,0)
 ;;=4^L89.45
 ;;^UTILITY(U,$J,358.3,28260,2)
 ;;=^5009409
 ;;^UTILITY(U,$J,358.3,28261,0)
 ;;=L89.510^^112^1416^66
 ;;^UTILITY(U,$J,358.3,28261,1,0)
 ;;=^358.31IA^4^2

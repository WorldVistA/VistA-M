IBDEI1BK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22007,1,3,0)
 ;;=3^Disp fx of lateral epicondyle of r humerus, sequela
 ;;^UTILITY(U,$J,358.3,22007,1,4,0)
 ;;=4^S42.431S
 ;;^UTILITY(U,$J,358.3,22007,2)
 ;;=^5027391
 ;;^UTILITY(U,$J,358.3,22008,0)
 ;;=S42.442S^^101^1037^34
 ;;^UTILITY(U,$J,358.3,22008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22008,1,3,0)
 ;;=3^Disp fx of medial epicondyle of l humerus, sequela
 ;;^UTILITY(U,$J,358.3,22008,1,4,0)
 ;;=4^S42.442S
 ;;^UTILITY(U,$J,358.3,22008,2)
 ;;=^5027440
 ;;^UTILITY(U,$J,358.3,22009,0)
 ;;=S42.441S^^101^1037^35
 ;;^UTILITY(U,$J,358.3,22009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22009,1,3,0)
 ;;=3^Disp fx of medial epicondyle of r humerus, sequela
 ;;^UTILITY(U,$J,358.3,22009,1,4,0)
 ;;=4^S42.441S
 ;;^UTILITY(U,$J,358.3,22009,2)
 ;;=^5027433
 ;;^UTILITY(U,$J,358.3,22010,0)
 ;;=S42.252S^^101^1037^22
 ;;^UTILITY(U,$J,358.3,22010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22010,1,3,0)
 ;;=3^Disp fx of greater tuberosity of left humerus, sequela
 ;;^UTILITY(U,$J,358.3,22010,1,4,0)
 ;;=4^S42.252S
 ;;^UTILITY(U,$J,358.3,22010,2)
 ;;=^5026900
 ;;^UTILITY(U,$J,358.3,22011,0)
 ;;=S42.251S^^101^1037^23
 ;;^UTILITY(U,$J,358.3,22011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22011,1,3,0)
 ;;=3^Disp fx of greater tuberosity of right humerus, sequela
 ;;^UTILITY(U,$J,358.3,22011,1,4,0)
 ;;=4^S42.251S
 ;;^UTILITY(U,$J,358.3,22011,2)
 ;;=^5026893
 ;;^UTILITY(U,$J,358.3,22012,0)
 ;;=S42.452S^^101^1037^24
 ;;^UTILITY(U,$J,358.3,22012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22012,1,3,0)
 ;;=3^Disp fx of lateral condyle of left humerus, sequela
 ;;^UTILITY(U,$J,358.3,22012,1,4,0)
 ;;=4^S42.452S
 ;;^UTILITY(U,$J,358.3,22012,2)
 ;;=^5027503
 ;;^UTILITY(U,$J,358.3,22013,0)
 ;;=S42.451S^^101^1037^25
 ;;^UTILITY(U,$J,358.3,22013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22013,1,3,0)
 ;;=3^Disp fx of lateral condyle of right humerus, sequela
 ;;^UTILITY(U,$J,358.3,22013,1,4,0)
 ;;=4^S42.451S
 ;;^UTILITY(U,$J,358.3,22013,2)
 ;;=^5027496
 ;;^UTILITY(U,$J,358.3,22014,0)
 ;;=S42.262S^^101^1037^30
 ;;^UTILITY(U,$J,358.3,22014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22014,1,3,0)
 ;;=3^Disp fx of lesser tuberosity of left humerus, sequela
 ;;^UTILITY(U,$J,358.3,22014,1,4,0)
 ;;=4^S42.262S
 ;;^UTILITY(U,$J,358.3,22014,2)
 ;;=^5026942
 ;;^UTILITY(U,$J,358.3,22015,0)
 ;;=S42.261S^^101^1037^31
 ;;^UTILITY(U,$J,358.3,22015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22015,1,3,0)
 ;;=3^Disp fx of lesser tuberosity of right humerus, sequela
 ;;^UTILITY(U,$J,358.3,22015,1,4,0)
 ;;=4^S42.261S
 ;;^UTILITY(U,$J,358.3,22015,2)
 ;;=^5026935
 ;;^UTILITY(U,$J,358.3,22016,0)
 ;;=S42.462S^^101^1037^32
 ;;^UTILITY(U,$J,358.3,22016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22016,1,3,0)
 ;;=3^Disp fx of medial condyle of left humerus, sequela
 ;;^UTILITY(U,$J,358.3,22016,1,4,0)
 ;;=4^S42.462S
 ;;^UTILITY(U,$J,358.3,22016,2)
 ;;=^5027545
 ;;^UTILITY(U,$J,358.3,22017,0)
 ;;=S42.461S^^101^1037^33
 ;;^UTILITY(U,$J,358.3,22017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22017,1,3,0)
 ;;=3^Disp fx of medial condyle of right humerus, sequela
 ;;^UTILITY(U,$J,358.3,22017,1,4,0)
 ;;=4^S42.461S
 ;;^UTILITY(U,$J,358.3,22017,2)
 ;;=^5027538
 ;;^UTILITY(U,$J,358.3,22018,0)
 ;;=S42.332S^^101^1037^38
 ;;^UTILITY(U,$J,358.3,22018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22018,1,3,0)
 ;;=3^Disp fx of oblique shaft of humerus, left arm, sequela  
 ;;^UTILITY(U,$J,358.3,22018,1,4,0)
 ;;=4^S42.332S
 ;;^UTILITY(U,$J,358.3,22018,2)
 ;;=^5027118
 ;;^UTILITY(U,$J,358.3,22019,0)
 ;;=S42.331S^^101^1037^40

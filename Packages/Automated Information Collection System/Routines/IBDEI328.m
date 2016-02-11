IBDEI328 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51300,2)
 ;;=^5009610
 ;;^UTILITY(U,$J,358.3,51301,0)
 ;;=M00.052^^222^2474^38
 ;;^UTILITY(U,$J,358.3,51301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51301,1,3,0)
 ;;=3^Staphylococcal arthritis, lft hip
 ;;^UTILITY(U,$J,358.3,51301,1,4,0)
 ;;=4^M00.052
 ;;^UTILITY(U,$J,358.3,51301,2)
 ;;=^5009611
 ;;^UTILITY(U,$J,358.3,51302,0)
 ;;=M00.151^^222^2474^27
 ;;^UTILITY(U,$J,358.3,51302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51302,1,3,0)
 ;;=3^Pneumococcal arthritis, rt hip
 ;;^UTILITY(U,$J,358.3,51302,1,4,0)
 ;;=4^M00.151
 ;;^UTILITY(U,$J,358.3,51302,2)
 ;;=^5009634
 ;;^UTILITY(U,$J,358.3,51303,0)
 ;;=M00.152^^222^2474^20
 ;;^UTILITY(U,$J,358.3,51303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51303,1,3,0)
 ;;=3^Pneumococcal arthritis, lft hip
 ;;^UTILITY(U,$J,358.3,51303,1,4,0)
 ;;=4^M00.152
 ;;^UTILITY(U,$J,358.3,51303,2)
 ;;=^5009635
 ;;^UTILITY(U,$J,358.3,51304,0)
 ;;=M00.251^^222^2474^60
 ;;^UTILITY(U,$J,358.3,51304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51304,1,3,0)
 ;;=3^Streptococcal arthritis, rt hip, oth
 ;;^UTILITY(U,$J,358.3,51304,1,4,0)
 ;;=4^M00.251
 ;;^UTILITY(U,$J,358.3,51304,2)
 ;;=^5009658
 ;;^UTILITY(U,$J,358.3,51305,0)
 ;;=M00.252^^222^2474^54
 ;;^UTILITY(U,$J,358.3,51305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51305,1,3,0)
 ;;=3^Streptococcal arthritis, lft hip, oth
 ;;^UTILITY(U,$J,358.3,51305,1,4,0)
 ;;=4^M00.252
 ;;^UTILITY(U,$J,358.3,51305,2)
 ;;=^5009659
 ;;^UTILITY(U,$J,358.3,51306,0)
 ;;=M00.851^^222^2474^12
 ;;^UTILITY(U,$J,358.3,51306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51306,1,3,0)
 ;;=3^Arthritis d/t other bacteria, rt hip
 ;;^UTILITY(U,$J,358.3,51306,1,4,0)
 ;;=4^M00.851
 ;;^UTILITY(U,$J,358.3,51306,2)
 ;;=^5009682
 ;;^UTILITY(U,$J,358.3,51307,0)
 ;;=M00.852^^222^2474^6
 ;;^UTILITY(U,$J,358.3,51307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51307,1,3,0)
 ;;=3^Arthritis d/t other bacteria, lft hip
 ;;^UTILITY(U,$J,358.3,51307,1,4,0)
 ;;=4^M00.852
 ;;^UTILITY(U,$J,358.3,51307,2)
 ;;=^5009683
 ;;^UTILITY(U,$J,358.3,51308,0)
 ;;=M00.061^^222^2474^46
 ;;^UTILITY(U,$J,358.3,51308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51308,1,3,0)
 ;;=3^Staphylococcal arthritis, rt knee
 ;;^UTILITY(U,$J,358.3,51308,1,4,0)
 ;;=4^M00.061
 ;;^UTILITY(U,$J,358.3,51308,2)
 ;;=^5009613
 ;;^UTILITY(U,$J,358.3,51309,0)
 ;;=M00.062^^222^2474^39
 ;;^UTILITY(U,$J,358.3,51309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51309,1,3,0)
 ;;=3^Staphylococcal arthritis, lft knee
 ;;^UTILITY(U,$J,358.3,51309,1,4,0)
 ;;=4^M00.062
 ;;^UTILITY(U,$J,358.3,51309,2)
 ;;=^5009614
 ;;^UTILITY(U,$J,358.3,51310,0)
 ;;=M00.161^^222^2474^28
 ;;^UTILITY(U,$J,358.3,51310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51310,1,3,0)
 ;;=3^Pneumococcal arthritis, rt knee
 ;;^UTILITY(U,$J,358.3,51310,1,4,0)
 ;;=4^M00.161
 ;;^UTILITY(U,$J,358.3,51310,2)
 ;;=^5009637
 ;;^UTILITY(U,$J,358.3,51311,0)
 ;;=M00.162^^222^2474^21
 ;;^UTILITY(U,$J,358.3,51311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51311,1,3,0)
 ;;=3^Pneumococcal arthritis, lft knee
 ;;^UTILITY(U,$J,358.3,51311,1,4,0)
 ;;=4^M00.162
 ;;^UTILITY(U,$J,358.3,51311,2)
 ;;=^5009638
 ;;^UTILITY(U,$J,358.3,51312,0)
 ;;=M00.261^^222^2474^61
 ;;^UTILITY(U,$J,358.3,51312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51312,1,3,0)
 ;;=3^Streptococcal arthritis, rt knee, oth
 ;;^UTILITY(U,$J,358.3,51312,1,4,0)
 ;;=4^M00.261
 ;;^UTILITY(U,$J,358.3,51312,2)
 ;;=^5009661
 ;;^UTILITY(U,$J,358.3,51313,0)
 ;;=M00.262^^222^2474^55
 ;;^UTILITY(U,$J,358.3,51313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51313,1,3,0)
 ;;=3^Streptococcal arthritis, lft knee, oth

IBDEI27X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37620,2)
 ;;=^5009610
 ;;^UTILITY(U,$J,358.3,37621,0)
 ;;=M00.052^^140^1795^38
 ;;^UTILITY(U,$J,358.3,37621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37621,1,3,0)
 ;;=3^Staphylococcal arthritis, lft hip
 ;;^UTILITY(U,$J,358.3,37621,1,4,0)
 ;;=4^M00.052
 ;;^UTILITY(U,$J,358.3,37621,2)
 ;;=^5009611
 ;;^UTILITY(U,$J,358.3,37622,0)
 ;;=M00.151^^140^1795^27
 ;;^UTILITY(U,$J,358.3,37622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37622,1,3,0)
 ;;=3^Pneumococcal arthritis, rt hip
 ;;^UTILITY(U,$J,358.3,37622,1,4,0)
 ;;=4^M00.151
 ;;^UTILITY(U,$J,358.3,37622,2)
 ;;=^5009634
 ;;^UTILITY(U,$J,358.3,37623,0)
 ;;=M00.152^^140^1795^20
 ;;^UTILITY(U,$J,358.3,37623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37623,1,3,0)
 ;;=3^Pneumococcal arthritis, lft hip
 ;;^UTILITY(U,$J,358.3,37623,1,4,0)
 ;;=4^M00.152
 ;;^UTILITY(U,$J,358.3,37623,2)
 ;;=^5009635
 ;;^UTILITY(U,$J,358.3,37624,0)
 ;;=M00.251^^140^1795^60
 ;;^UTILITY(U,$J,358.3,37624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37624,1,3,0)
 ;;=3^Streptococcal arthritis, rt hip, oth
 ;;^UTILITY(U,$J,358.3,37624,1,4,0)
 ;;=4^M00.251
 ;;^UTILITY(U,$J,358.3,37624,2)
 ;;=^5009658
 ;;^UTILITY(U,$J,358.3,37625,0)
 ;;=M00.252^^140^1795^54
 ;;^UTILITY(U,$J,358.3,37625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37625,1,3,0)
 ;;=3^Streptococcal arthritis, lft hip, oth
 ;;^UTILITY(U,$J,358.3,37625,1,4,0)
 ;;=4^M00.252
 ;;^UTILITY(U,$J,358.3,37625,2)
 ;;=^5009659
 ;;^UTILITY(U,$J,358.3,37626,0)
 ;;=M00.851^^140^1795^12
 ;;^UTILITY(U,$J,358.3,37626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37626,1,3,0)
 ;;=3^Arthritis d/t other bacteria, rt hip
 ;;^UTILITY(U,$J,358.3,37626,1,4,0)
 ;;=4^M00.851
 ;;^UTILITY(U,$J,358.3,37626,2)
 ;;=^5009682
 ;;^UTILITY(U,$J,358.3,37627,0)
 ;;=M00.852^^140^1795^6
 ;;^UTILITY(U,$J,358.3,37627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37627,1,3,0)
 ;;=3^Arthritis d/t other bacteria, lft hip
 ;;^UTILITY(U,$J,358.3,37627,1,4,0)
 ;;=4^M00.852
 ;;^UTILITY(U,$J,358.3,37627,2)
 ;;=^5009683
 ;;^UTILITY(U,$J,358.3,37628,0)
 ;;=M00.061^^140^1795^46
 ;;^UTILITY(U,$J,358.3,37628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37628,1,3,0)
 ;;=3^Staphylococcal arthritis, rt knee
 ;;^UTILITY(U,$J,358.3,37628,1,4,0)
 ;;=4^M00.061
 ;;^UTILITY(U,$J,358.3,37628,2)
 ;;=^5009613
 ;;^UTILITY(U,$J,358.3,37629,0)
 ;;=M00.062^^140^1795^39
 ;;^UTILITY(U,$J,358.3,37629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37629,1,3,0)
 ;;=3^Staphylococcal arthritis, lft knee
 ;;^UTILITY(U,$J,358.3,37629,1,4,0)
 ;;=4^M00.062
 ;;^UTILITY(U,$J,358.3,37629,2)
 ;;=^5009614
 ;;^UTILITY(U,$J,358.3,37630,0)
 ;;=M00.161^^140^1795^28
 ;;^UTILITY(U,$J,358.3,37630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37630,1,3,0)
 ;;=3^Pneumococcal arthritis, rt knee
 ;;^UTILITY(U,$J,358.3,37630,1,4,0)
 ;;=4^M00.161
 ;;^UTILITY(U,$J,358.3,37630,2)
 ;;=^5009637
 ;;^UTILITY(U,$J,358.3,37631,0)
 ;;=M00.162^^140^1795^21
 ;;^UTILITY(U,$J,358.3,37631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37631,1,3,0)
 ;;=3^Pneumococcal arthritis, lft knee
 ;;^UTILITY(U,$J,358.3,37631,1,4,0)
 ;;=4^M00.162
 ;;^UTILITY(U,$J,358.3,37631,2)
 ;;=^5009638
 ;;^UTILITY(U,$J,358.3,37632,0)
 ;;=M00.261^^140^1795^61
 ;;^UTILITY(U,$J,358.3,37632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37632,1,3,0)
 ;;=3^Streptococcal arthritis, rt knee, oth
 ;;^UTILITY(U,$J,358.3,37632,1,4,0)
 ;;=4^M00.261
 ;;^UTILITY(U,$J,358.3,37632,2)
 ;;=^5009661
 ;;^UTILITY(U,$J,358.3,37633,0)
 ;;=M00.262^^140^1795^55
 ;;^UTILITY(U,$J,358.3,37633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37633,1,3,0)
 ;;=3^Streptococcal arthritis, lft knee, oth

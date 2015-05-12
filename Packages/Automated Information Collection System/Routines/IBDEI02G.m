IBDEI02G ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2863,0)
 ;;=M00.131^^12^112^30
 ;;^UTILITY(U,$J,358.3,2863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2863,1,3,0)
 ;;=3^Pneumococcal arthritis, rt wrist
 ;;^UTILITY(U,$J,358.3,2863,1,4,0)
 ;;=4^M00.131
 ;;^UTILITY(U,$J,358.3,2863,2)
 ;;=^5009628
 ;;^UTILITY(U,$J,358.3,2864,0)
 ;;=M00.132^^12^112^23
 ;;^UTILITY(U,$J,358.3,2864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2864,1,3,0)
 ;;=3^Pneumococcal arthritis, lft wrist
 ;;^UTILITY(U,$J,358.3,2864,1,4,0)
 ;;=4^M00.132
 ;;^UTILITY(U,$J,358.3,2864,2)
 ;;=^5009629
 ;;^UTILITY(U,$J,358.3,2865,0)
 ;;=M00.231^^12^112^63
 ;;^UTILITY(U,$J,358.3,2865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2865,1,3,0)
 ;;=3^Streptococcal arthritis, rt wrist, oth
 ;;^UTILITY(U,$J,358.3,2865,1,4,0)
 ;;=4^M00.231
 ;;^UTILITY(U,$J,358.3,2865,2)
 ;;=^5009652
 ;;^UTILITY(U,$J,358.3,2866,0)
 ;;=M00.232^^12^112^66
 ;;^UTILITY(U,$J,358.3,2866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2866,1,3,0)
 ;;=3^streptococcal arthritis, lft wrist, oth
 ;;^UTILITY(U,$J,358.3,2866,1,4,0)
 ;;=4^M00.232
 ;;^UTILITY(U,$J,358.3,2866,2)
 ;;=^5009653
 ;;^UTILITY(U,$J,358.3,2867,0)
 ;;=M00.831^^12^112^14
 ;;^UTILITY(U,$J,358.3,2867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2867,1,3,0)
 ;;=3^Arthritis d/t other bacteria, rt wrist
 ;;^UTILITY(U,$J,358.3,2867,1,4,0)
 ;;=4^M00.831
 ;;^UTILITY(U,$J,358.3,2867,2)
 ;;=^5009676
 ;;^UTILITY(U,$J,358.3,2868,0)
 ;;=M00.832^^12^112^8
 ;;^UTILITY(U,$J,358.3,2868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2868,1,3,0)
 ;;=3^Arthritis d/t other bacteria, lft wrist
 ;;^UTILITY(U,$J,358.3,2868,1,4,0)
 ;;=4^M00.832
 ;;^UTILITY(U,$J,358.3,2868,2)
 ;;=^5009677
 ;;^UTILITY(U,$J,358.3,2869,0)
 ;;=M00.041^^12^112^44
 ;;^UTILITY(U,$J,358.3,2869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2869,1,3,0)
 ;;=3^Staphylococcal arthritis, rt hand
 ;;^UTILITY(U,$J,358.3,2869,1,4,0)
 ;;=4^M00.041
 ;;^UTILITY(U,$J,358.3,2869,2)
 ;;=^5009607
 ;;^UTILITY(U,$J,358.3,2870,0)
 ;;=M00.042^^12^112^37
 ;;^UTILITY(U,$J,358.3,2870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2870,1,3,0)
 ;;=3^Staphylococcal arthritis, lft hand
 ;;^UTILITY(U,$J,358.3,2870,1,4,0)
 ;;=4^M00.042
 ;;^UTILITY(U,$J,358.3,2870,2)
 ;;=^5009608
 ;;^UTILITY(U,$J,358.3,2871,0)
 ;;=M00.141^^12^112^26
 ;;^UTILITY(U,$J,358.3,2871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2871,1,3,0)
 ;;=3^Pneumococcal arthritis, rt hand
 ;;^UTILITY(U,$J,358.3,2871,1,4,0)
 ;;=4^M00.141
 ;;^UTILITY(U,$J,358.3,2871,2)
 ;;=^5009631
 ;;^UTILITY(U,$J,358.3,2872,0)
 ;;=M00.142^^12^112^19
 ;;^UTILITY(U,$J,358.3,2872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2872,1,3,0)
 ;;=3^Pneumococcal arthritis, lft hand
 ;;^UTILITY(U,$J,358.3,2872,1,4,0)
 ;;=4^M00.142
 ;;^UTILITY(U,$J,358.3,2872,2)
 ;;=^5009632
 ;;^UTILITY(U,$J,358.3,2873,0)
 ;;=M00.241^^12^112^59
 ;;^UTILITY(U,$J,358.3,2873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2873,1,3,0)
 ;;=3^Streptococcal arthritis, rt hand, oth
 ;;^UTILITY(U,$J,358.3,2873,1,4,0)
 ;;=4^M00.241
 ;;^UTILITY(U,$J,358.3,2873,2)
 ;;=^5009655
 ;;^UTILITY(U,$J,358.3,2874,0)
 ;;=M00.242^^12^112^53
 ;;^UTILITY(U,$J,358.3,2874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2874,1,3,0)
 ;;=3^Streptococcal arthritis, lft hand, oth
 ;;^UTILITY(U,$J,358.3,2874,1,4,0)
 ;;=4^M00.242
 ;;^UTILITY(U,$J,358.3,2874,2)
 ;;=^5009656
 ;;^UTILITY(U,$J,358.3,2875,0)
 ;;=M00.841^^12^112^11
 ;;^UTILITY(U,$J,358.3,2875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2875,1,3,0)
 ;;=3^Arthritis d/t other bacteria, rt hand
 ;;^UTILITY(U,$J,358.3,2875,1,4,0)
 ;;=4^M00.841
 ;;^UTILITY(U,$J,358.3,2875,2)
 ;;=^5009679
 ;;^UTILITY(U,$J,358.3,2876,0)
 ;;=M00.842^^12^112^5
 ;;^UTILITY(U,$J,358.3,2876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2876,1,3,0)
 ;;=3^Arthritis d/t other bacteria, lft hand
 ;;^UTILITY(U,$J,358.3,2876,1,4,0)
 ;;=4^M00.842
 ;;^UTILITY(U,$J,358.3,2876,2)
 ;;=^5009680
 ;;^UTILITY(U,$J,358.3,2877,0)
 ;;=M00.051^^12^112^45
 ;;^UTILITY(U,$J,358.3,2877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2877,1,3,0)
 ;;=3^Staphylococcal arthritis, rt hip
 ;;^UTILITY(U,$J,358.3,2877,1,4,0)
 ;;=4^M00.051
 ;;^UTILITY(U,$J,358.3,2877,2)
 ;;=^5009610
 ;;^UTILITY(U,$J,358.3,2878,0)
 ;;=M00.052^^12^112^38
 ;;^UTILITY(U,$J,358.3,2878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2878,1,3,0)
 ;;=3^Staphylococcal arthritis, lft hip
 ;;^UTILITY(U,$J,358.3,2878,1,4,0)
 ;;=4^M00.052
 ;;^UTILITY(U,$J,358.3,2878,2)
 ;;=^5009611
 ;;^UTILITY(U,$J,358.3,2879,0)
 ;;=M00.151^^12^112^27
 ;;^UTILITY(U,$J,358.3,2879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2879,1,3,0)
 ;;=3^Pneumococcal arthritis, rt hip
 ;;^UTILITY(U,$J,358.3,2879,1,4,0)
 ;;=4^M00.151
 ;;^UTILITY(U,$J,358.3,2879,2)
 ;;=^5009634
 ;;^UTILITY(U,$J,358.3,2880,0)
 ;;=M00.152^^12^112^20
 ;;^UTILITY(U,$J,358.3,2880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2880,1,3,0)
 ;;=3^Pneumococcal arthritis, lft hip
 ;;^UTILITY(U,$J,358.3,2880,1,4,0)
 ;;=4^M00.152
 ;;^UTILITY(U,$J,358.3,2880,2)
 ;;=^5009635
 ;;^UTILITY(U,$J,358.3,2881,0)
 ;;=M00.251^^12^112^60
 ;;^UTILITY(U,$J,358.3,2881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2881,1,3,0)
 ;;=3^Streptococcal arthritis, rt hip, oth
 ;;^UTILITY(U,$J,358.3,2881,1,4,0)
 ;;=4^M00.251
 ;;^UTILITY(U,$J,358.3,2881,2)
 ;;=^5009658
 ;;^UTILITY(U,$J,358.3,2882,0)
 ;;=M00.252^^12^112^54
 ;;^UTILITY(U,$J,358.3,2882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2882,1,3,0)
 ;;=3^Streptococcal arthritis, lft hip, oth
 ;;^UTILITY(U,$J,358.3,2882,1,4,0)
 ;;=4^M00.252
 ;;^UTILITY(U,$J,358.3,2882,2)
 ;;=^5009659
 ;;^UTILITY(U,$J,358.3,2883,0)
 ;;=M00.851^^12^112^12
 ;;^UTILITY(U,$J,358.3,2883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2883,1,3,0)
 ;;=3^Arthritis d/t other bacteria, rt hip
 ;;^UTILITY(U,$J,358.3,2883,1,4,0)
 ;;=4^M00.851
 ;;^UTILITY(U,$J,358.3,2883,2)
 ;;=^5009682
 ;;^UTILITY(U,$J,358.3,2884,0)
 ;;=M00.852^^12^112^6
 ;;^UTILITY(U,$J,358.3,2884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2884,1,3,0)
 ;;=3^Arthritis d/t other bacteria, lft hip
 ;;^UTILITY(U,$J,358.3,2884,1,4,0)
 ;;=4^M00.852
 ;;^UTILITY(U,$J,358.3,2884,2)
 ;;=^5009683
 ;;^UTILITY(U,$J,358.3,2885,0)
 ;;=M00.061^^12^112^46
 ;;^UTILITY(U,$J,358.3,2885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2885,1,3,0)
 ;;=3^Staphylococcal arthritis, rt knee
 ;;^UTILITY(U,$J,358.3,2885,1,4,0)
 ;;=4^M00.061
 ;;^UTILITY(U,$J,358.3,2885,2)
 ;;=^5009613
 ;;^UTILITY(U,$J,358.3,2886,0)
 ;;=M00.062^^12^112^39
 ;;^UTILITY(U,$J,358.3,2886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2886,1,3,0)
 ;;=3^Staphylococcal arthritis, lft knee
 ;;^UTILITY(U,$J,358.3,2886,1,4,0)
 ;;=4^M00.062
 ;;^UTILITY(U,$J,358.3,2886,2)
 ;;=^5009614
 ;;^UTILITY(U,$J,358.3,2887,0)
 ;;=M00.161^^12^112^28
 ;;^UTILITY(U,$J,358.3,2887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2887,1,3,0)
 ;;=3^Pneumococcal arthritis, rt knee
 ;;^UTILITY(U,$J,358.3,2887,1,4,0)
 ;;=4^M00.161
 ;;^UTILITY(U,$J,358.3,2887,2)
 ;;=^5009637
 ;;^UTILITY(U,$J,358.3,2888,0)
 ;;=M00.162^^12^112^21
 ;;^UTILITY(U,$J,358.3,2888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2888,1,3,0)
 ;;=3^Pneumococcal arthritis, lft knee
 ;;^UTILITY(U,$J,358.3,2888,1,4,0)
 ;;=4^M00.162
 ;;^UTILITY(U,$J,358.3,2888,2)
 ;;=^5009638
 ;;^UTILITY(U,$J,358.3,2889,0)
 ;;=M00.261^^12^112^61
 ;;^UTILITY(U,$J,358.3,2889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2889,1,3,0)
 ;;=3^Streptococcal arthritis, rt knee, oth
 ;;^UTILITY(U,$J,358.3,2889,1,4,0)
 ;;=4^M00.261
 ;;^UTILITY(U,$J,358.3,2889,2)
 ;;=^5009661
 ;;^UTILITY(U,$J,358.3,2890,0)
 ;;=M00.262^^12^112^55
 ;;^UTILITY(U,$J,358.3,2890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2890,1,3,0)
 ;;=3^Streptococcal arthritis, lft knee, oth
 ;;^UTILITY(U,$J,358.3,2890,1,4,0)
 ;;=4^M00.262
 ;;^UTILITY(U,$J,358.3,2890,2)
 ;;=^5009662
 ;;^UTILITY(U,$J,358.3,2891,0)
 ;;=M00.861^^12^112^13
 ;;^UTILITY(U,$J,358.3,2891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2891,1,3,0)
 ;;=3^Arthritis d/t other bacteria, rt knee
 ;;^UTILITY(U,$J,358.3,2891,1,4,0)
 ;;=4^M00.861
 ;;^UTILITY(U,$J,358.3,2891,2)
 ;;=^5009685
 ;;^UTILITY(U,$J,358.3,2892,0)
 ;;=M00.862^^12^112^7
 ;;^UTILITY(U,$J,358.3,2892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2892,1,3,0)
 ;;=3^Arthritis d/t other bacteria, lft knee
 ;;^UTILITY(U,$J,358.3,2892,1,4,0)
 ;;=4^M00.862
 ;;^UTILITY(U,$J,358.3,2892,2)
 ;;=^5009686
 ;;^UTILITY(U,$J,358.3,2893,0)
 ;;=M00.071^^12^112^42
 ;;^UTILITY(U,$J,358.3,2893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2893,1,3,0)
 ;;=3^Staphylococcal arthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2893,1,4,0)
 ;;=4^M00.071
 ;;^UTILITY(U,$J,358.3,2893,2)
 ;;=^5009616
 ;;^UTILITY(U,$J,358.3,2894,0)
 ;;=M00.072^^12^112^35
 ;;^UTILITY(U,$J,358.3,2894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2894,1,3,0)
 ;;=3^Staphylococcal arthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,2894,1,4,0)
 ;;=4^M00.072
 ;;^UTILITY(U,$J,358.3,2894,2)
 ;;=^5009617
 ;;^UTILITY(U,$J,358.3,2895,0)
 ;;=M00.171^^12^112^24
 ;;^UTILITY(U,$J,358.3,2895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2895,1,3,0)
 ;;=3^Pneumococcal arthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2895,1,4,0)
 ;;=4^M00.171
 ;;^UTILITY(U,$J,358.3,2895,2)
 ;;=^5009640
 ;;^UTILITY(U,$J,358.3,2896,0)
 ;;=M00.172^^12^112^17
 ;;^UTILITY(U,$J,358.3,2896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2896,1,3,0)
 ;;=3^Pneumococcal arthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,2896,1,4,0)
 ;;=4^M00.172
 ;;^UTILITY(U,$J,358.3,2896,2)
 ;;=^5009641
 ;;^UTILITY(U,$J,358.3,2897,0)
 ;;=M00.271^^12^112^57
 ;;^UTILITY(U,$J,358.3,2897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2897,1,3,0)
 ;;=3^Streptococcal arthritis, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,2897,1,4,0)
 ;;=4^M00.271
 ;;^UTILITY(U,$J,358.3,2897,2)
 ;;=^5009664
 ;;^UTILITY(U,$J,358.3,2898,0)
 ;;=M00.272^^12^112^51
 ;;^UTILITY(U,$J,358.3,2898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2898,1,3,0)
 ;;=3^Streptococcal arthritis, lft ankle & foot

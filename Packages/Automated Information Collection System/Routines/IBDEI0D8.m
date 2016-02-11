IBDEI0D8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5750,1,4,0)
 ;;=4^S81.002A
 ;;^UTILITY(U,$J,358.3,5750,2)
 ;;=^5040029
 ;;^UTILITY(U,$J,358.3,5751,0)
 ;;=S81.001A^^40^375^47
 ;;^UTILITY(U,$J,358.3,5751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5751,1,3,0)
 ;;=3^Open Wound of Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,5751,1,4,0)
 ;;=4^S81.001A
 ;;^UTILITY(U,$J,358.3,5751,2)
 ;;=^5040026
 ;;^UTILITY(U,$J,358.3,5752,0)
 ;;=S91.301A^^40^375^40
 ;;^UTILITY(U,$J,358.3,5752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5752,1,3,0)
 ;;=3^Open Wound of Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,5752,1,4,0)
 ;;=4^S91.301A
 ;;^UTILITY(U,$J,358.3,5752,2)
 ;;=^5044314
 ;;^UTILITY(U,$J,358.3,5753,0)
 ;;=S91.302A^^40^375^9
 ;;^UTILITY(U,$J,358.3,5753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5753,1,3,0)
 ;;=3^Open Wound of Left Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,5753,1,4,0)
 ;;=4^S91.302A
 ;;^UTILITY(U,$J,358.3,5753,2)
 ;;=^5044317
 ;;^UTILITY(U,$J,358.3,5754,0)
 ;;=S91.101A^^40^375^42
 ;;^UTILITY(U,$J,358.3,5754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5754,1,3,0)
 ;;=3^Open Wound of Right Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5754,1,4,0)
 ;;=4^S91.101A
 ;;^UTILITY(U,$J,358.3,5754,2)
 ;;=^5044168
 ;;^UTILITY(U,$J,358.3,5755,0)
 ;;=S91.102A^^40^375^11
 ;;^UTILITY(U,$J,358.3,5755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5755,1,3,0)
 ;;=3^Open Wound of Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5755,1,4,0)
 ;;=4^S91.102A
 ;;^UTILITY(U,$J,358.3,5755,2)
 ;;=^5044171
 ;;^UTILITY(U,$J,358.3,5756,0)
 ;;=S91.104A^^40^375^49
 ;;^UTILITY(U,$J,358.3,5756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5756,1,3,0)
 ;;=3^Open Wound of Right Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5756,1,4,0)
 ;;=4^S91.104A
 ;;^UTILITY(U,$J,358.3,5756,2)
 ;;=^5044174
 ;;^UTILITY(U,$J,358.3,5757,0)
 ;;=S91.105A^^40^375^18
 ;;^UTILITY(U,$J,358.3,5757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5757,1,3,0)
 ;;=3^Open Wound of Left Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5757,1,4,0)
 ;;=4^S91.105A
 ;;^UTILITY(U,$J,358.3,5757,2)
 ;;=^5044177
 ;;^UTILITY(U,$J,358.3,5758,0)
 ;;=S91.201A^^40^375^41
 ;;^UTILITY(U,$J,358.3,5758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5758,1,3,0)
 ;;=3^Open Wound of Right Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5758,1,4,0)
 ;;=4^S91.201A
 ;;^UTILITY(U,$J,358.3,5758,2)
 ;;=^5044264
 ;;^UTILITY(U,$J,358.3,5759,0)
 ;;=S91.202A^^40^375^10
 ;;^UTILITY(U,$J,358.3,5759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5759,1,3,0)
 ;;=3^Open Wound of Left Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5759,1,4,0)
 ;;=4^S91.202A
 ;;^UTILITY(U,$J,358.3,5759,2)
 ;;=^5137421
 ;;^UTILITY(U,$J,358.3,5760,0)
 ;;=S91.204A^^40^375^48
 ;;^UTILITY(U,$J,358.3,5760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5760,1,3,0)
 ;;=3^Open Wound of Right Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5760,1,4,0)
 ;;=4^S91.204A
 ;;^UTILITY(U,$J,358.3,5760,2)
 ;;=^5044267
 ;;^UTILITY(U,$J,358.3,5761,0)
 ;;=S91.205A^^40^375^17
 ;;^UTILITY(U,$J,358.3,5761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5761,1,3,0)
 ;;=3^Open Wound of Left Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,5761,1,4,0)
 ;;=4^S91.205A
 ;;^UTILITY(U,$J,358.3,5761,2)
 ;;=^5137430
 ;;^UTILITY(U,$J,358.3,5762,0)
 ;;=M19.011^^40^376^16
 ;;^UTILITY(U,$J,358.3,5762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5762,1,3,0)
 ;;=3^Primary Osteoarthritis,Right Shoulder
 ;;^UTILITY(U,$J,358.3,5762,1,4,0)
 ;;=4^M19.011

IBDEI0XF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15406,1,3,0)
 ;;=3^Open Wound of Right Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15406,1,4,0)
 ;;=4^S91.101A
 ;;^UTILITY(U,$J,358.3,15406,2)
 ;;=^5044168
 ;;^UTILITY(U,$J,358.3,15407,0)
 ;;=S91.102A^^85^817^11
 ;;^UTILITY(U,$J,358.3,15407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15407,1,3,0)
 ;;=3^Open Wound of Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15407,1,4,0)
 ;;=4^S91.102A
 ;;^UTILITY(U,$J,358.3,15407,2)
 ;;=^5044171
 ;;^UTILITY(U,$J,358.3,15408,0)
 ;;=S91.104A^^85^817^49
 ;;^UTILITY(U,$J,358.3,15408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15408,1,3,0)
 ;;=3^Open Wound of Right Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15408,1,4,0)
 ;;=4^S91.104A
 ;;^UTILITY(U,$J,358.3,15408,2)
 ;;=^5044174
 ;;^UTILITY(U,$J,358.3,15409,0)
 ;;=S91.105A^^85^817^18
 ;;^UTILITY(U,$J,358.3,15409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15409,1,3,0)
 ;;=3^Open Wound of Left Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15409,1,4,0)
 ;;=4^S91.105A
 ;;^UTILITY(U,$J,358.3,15409,2)
 ;;=^5044177
 ;;^UTILITY(U,$J,358.3,15410,0)
 ;;=S91.201A^^85^817^41
 ;;^UTILITY(U,$J,358.3,15410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15410,1,3,0)
 ;;=3^Open Wound of Right Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15410,1,4,0)
 ;;=4^S91.201A
 ;;^UTILITY(U,$J,358.3,15410,2)
 ;;=^5044264
 ;;^UTILITY(U,$J,358.3,15411,0)
 ;;=S91.202A^^85^817^10
 ;;^UTILITY(U,$J,358.3,15411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15411,1,3,0)
 ;;=3^Open Wound of Left Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15411,1,4,0)
 ;;=4^S91.202A
 ;;^UTILITY(U,$J,358.3,15411,2)
 ;;=^5137421
 ;;^UTILITY(U,$J,358.3,15412,0)
 ;;=S91.204A^^85^817^48
 ;;^UTILITY(U,$J,358.3,15412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15412,1,3,0)
 ;;=3^Open Wound of Right Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15412,1,4,0)
 ;;=4^S91.204A
 ;;^UTILITY(U,$J,358.3,15412,2)
 ;;=^5044267
 ;;^UTILITY(U,$J,358.3,15413,0)
 ;;=S91.205A^^85^817^17
 ;;^UTILITY(U,$J,358.3,15413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15413,1,3,0)
 ;;=3^Open Wound of Left Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15413,1,4,0)
 ;;=4^S91.205A
 ;;^UTILITY(U,$J,358.3,15413,2)
 ;;=^5137430
 ;;^UTILITY(U,$J,358.3,15414,0)
 ;;=M19.011^^85^818^16
 ;;^UTILITY(U,$J,358.3,15414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15414,1,3,0)
 ;;=3^Primary Osteoarthritis,Right Shoulder
 ;;^UTILITY(U,$J,358.3,15414,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,15414,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,15415,0)
 ;;=M19.012^^85^818^11
 ;;^UTILITY(U,$J,358.3,15415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15415,1,3,0)
 ;;=3^Primary Osteoarthritis,Left Shoulder
 ;;^UTILITY(U,$J,358.3,15415,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,15415,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,15416,0)
 ;;=M19.021^^85^818^14
 ;;^UTILITY(U,$J,358.3,15416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15416,1,3,0)
 ;;=3^Primary Osteoarthritis,Right Elbow
 ;;^UTILITY(U,$J,358.3,15416,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,15416,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,15417,0)
 ;;=M19.022^^85^818^9
 ;;^UTILITY(U,$J,358.3,15417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15417,1,3,0)
 ;;=3^Primary Osteoarthritis,Left Elbow
 ;;^UTILITY(U,$J,358.3,15417,1,4,0)
 ;;=4^M19.022
 ;;^UTILITY(U,$J,358.3,15417,2)
 ;;=^5010812
 ;;^UTILITY(U,$J,358.3,15418,0)
 ;;=M19.031^^85^818^17
 ;;^UTILITY(U,$J,358.3,15418,1,0)
 ;;=^358.31IA^4^2

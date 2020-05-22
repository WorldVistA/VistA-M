IBDEI0RP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12360,1,3,0)
 ;;=3^Open Wound of Right Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,12360,1,4,0)
 ;;=4^S61.501A
 ;;^UTILITY(U,$J,358.3,12360,2)
 ;;=^5033020
 ;;^UTILITY(U,$J,358.3,12361,0)
 ;;=S61.502A^^80^778^30
 ;;^UTILITY(U,$J,358.3,12361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12361,1,3,0)
 ;;=3^Open Wound of Left Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,12361,1,4,0)
 ;;=4^S61.502A
 ;;^UTILITY(U,$J,358.3,12361,2)
 ;;=^5033023
 ;;^UTILITY(U,$J,358.3,12362,0)
 ;;=S61.401A^^80^778^43
 ;;^UTILITY(U,$J,358.3,12362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12362,1,3,0)
 ;;=3^Open Wound of Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,12362,1,4,0)
 ;;=4^S61.401A
 ;;^UTILITY(U,$J,358.3,12362,2)
 ;;=^5032981
 ;;^UTILITY(U,$J,358.3,12363,0)
 ;;=S61.402A^^80^778^12
 ;;^UTILITY(U,$J,358.3,12363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12363,1,3,0)
 ;;=3^Open Wound of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,12363,1,4,0)
 ;;=4^S61.402A
 ;;^UTILITY(U,$J,358.3,12363,2)
 ;;=^5032984
 ;;^UTILITY(U,$J,358.3,12364,0)
 ;;=S61.001A^^80^778^60
 ;;^UTILITY(U,$J,358.3,12364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12364,1,3,0)
 ;;=3^Open Wound of Right Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12364,1,4,0)
 ;;=4^S61.001A
 ;;^UTILITY(U,$J,358.3,12364,2)
 ;;=^5032684
 ;;^UTILITY(U,$J,358.3,12365,0)
 ;;=S61.002A^^80^778^29
 ;;^UTILITY(U,$J,358.3,12365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12365,1,3,0)
 ;;=3^Open Wound of Left Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12365,1,4,0)
 ;;=4^S61.002A
 ;;^UTILITY(U,$J,358.3,12365,2)
 ;;=^5032687
 ;;^UTILITY(U,$J,358.3,12366,0)
 ;;=S61.101A^^80^778^59
 ;;^UTILITY(U,$J,358.3,12366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12366,1,3,0)
 ;;=3^Open Wound of Right Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12366,1,4,0)
 ;;=4^S61.101A
 ;;^UTILITY(U,$J,358.3,12366,2)
 ;;=^5032723
 ;;^UTILITY(U,$J,358.3,12367,0)
 ;;=S61.102A^^80^778^28
 ;;^UTILITY(U,$J,358.3,12367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12367,1,3,0)
 ;;=3^Open Wound of Left Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12367,1,4,0)
 ;;=4^S61.102A
 ;;^UTILITY(U,$J,358.3,12367,2)
 ;;=^5135687
 ;;^UTILITY(U,$J,358.3,12368,0)
 ;;=S61.200A^^80^778^46
 ;;^UTILITY(U,$J,358.3,12368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12368,1,3,0)
 ;;=3^Open Wound of Right Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12368,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,12368,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,12369,0)
 ;;=S61.201A^^80^778^15
 ;;^UTILITY(U,$J,358.3,12369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12369,1,3,0)
 ;;=3^Open Wound of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12369,1,4,0)
 ;;=4^S61.201A
 ;;^UTILITY(U,$J,358.3,12369,2)
 ;;=^5032744
 ;;^UTILITY(U,$J,358.3,12370,0)
 ;;=S61.202A^^80^778^54
 ;;^UTILITY(U,$J,358.3,12370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12370,1,3,0)
 ;;=3^Open Wound of Right Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12370,1,4,0)
 ;;=4^S61.202A
 ;;^UTILITY(U,$J,358.3,12370,2)
 ;;=^5032747
 ;;^UTILITY(U,$J,358.3,12371,0)
 ;;=S61.203A^^80^778^23
 ;;^UTILITY(U,$J,358.3,12371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12371,1,3,0)
 ;;=3^Open Wound of Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12371,1,4,0)
 ;;=4^S61.203A

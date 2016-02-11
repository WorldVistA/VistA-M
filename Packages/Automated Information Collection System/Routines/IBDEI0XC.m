IBDEI0XC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15369,1,4,0)
 ;;=4^S51.002A
 ;;^UTILITY(U,$J,358.3,15369,2)
 ;;=^5028623
 ;;^UTILITY(U,$J,358.3,15370,0)
 ;;=S61.501A^^85^817^61
 ;;^UTILITY(U,$J,358.3,15370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15370,1,3,0)
 ;;=3^Open Wound of Right Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,15370,1,4,0)
 ;;=4^S61.501A
 ;;^UTILITY(U,$J,358.3,15370,2)
 ;;=^5033020
 ;;^UTILITY(U,$J,358.3,15371,0)
 ;;=S61.502A^^85^817^30
 ;;^UTILITY(U,$J,358.3,15371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15371,1,3,0)
 ;;=3^Open Wound of Left Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,15371,1,4,0)
 ;;=4^S61.502A
 ;;^UTILITY(U,$J,358.3,15371,2)
 ;;=^5033023
 ;;^UTILITY(U,$J,358.3,15372,0)
 ;;=S61.401A^^85^817^43
 ;;^UTILITY(U,$J,358.3,15372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15372,1,3,0)
 ;;=3^Open Wound of Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,15372,1,4,0)
 ;;=4^S61.401A
 ;;^UTILITY(U,$J,358.3,15372,2)
 ;;=^5032981
 ;;^UTILITY(U,$J,358.3,15373,0)
 ;;=S61.402A^^85^817^12
 ;;^UTILITY(U,$J,358.3,15373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15373,1,3,0)
 ;;=3^Open Wound of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,15373,1,4,0)
 ;;=4^S61.402A
 ;;^UTILITY(U,$J,358.3,15373,2)
 ;;=^5032984
 ;;^UTILITY(U,$J,358.3,15374,0)
 ;;=S61.001A^^85^817^60
 ;;^UTILITY(U,$J,358.3,15374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15374,1,3,0)
 ;;=3^Open Wound of Right Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15374,1,4,0)
 ;;=4^S61.001A
 ;;^UTILITY(U,$J,358.3,15374,2)
 ;;=^5032684
 ;;^UTILITY(U,$J,358.3,15375,0)
 ;;=S61.002A^^85^817^29
 ;;^UTILITY(U,$J,358.3,15375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15375,1,3,0)
 ;;=3^Open Wound of Left Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15375,1,4,0)
 ;;=4^S61.002A
 ;;^UTILITY(U,$J,358.3,15375,2)
 ;;=^5032687
 ;;^UTILITY(U,$J,358.3,15376,0)
 ;;=S61.101A^^85^817^59
 ;;^UTILITY(U,$J,358.3,15376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15376,1,3,0)
 ;;=3^Open Wound of Right Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15376,1,4,0)
 ;;=4^S61.101A
 ;;^UTILITY(U,$J,358.3,15376,2)
 ;;=^5032723
 ;;^UTILITY(U,$J,358.3,15377,0)
 ;;=S61.102A^^85^817^28
 ;;^UTILITY(U,$J,358.3,15377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15377,1,3,0)
 ;;=3^Open Wound of Left Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15377,1,4,0)
 ;;=4^S61.102A
 ;;^UTILITY(U,$J,358.3,15377,2)
 ;;=^5135687
 ;;^UTILITY(U,$J,358.3,15378,0)
 ;;=S61.200A^^85^817^46
 ;;^UTILITY(U,$J,358.3,15378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15378,1,3,0)
 ;;=3^Open Wound of Right Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15378,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,15378,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,15379,0)
 ;;=S61.201A^^85^817^15
 ;;^UTILITY(U,$J,358.3,15379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15379,1,3,0)
 ;;=3^Open Wound of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15379,1,4,0)
 ;;=4^S61.201A
 ;;^UTILITY(U,$J,358.3,15379,2)
 ;;=^5032744
 ;;^UTILITY(U,$J,358.3,15380,0)
 ;;=S61.202A^^85^817^54
 ;;^UTILITY(U,$J,358.3,15380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15380,1,3,0)
 ;;=3^Open Wound of Right Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15380,1,4,0)
 ;;=4^S61.202A
 ;;^UTILITY(U,$J,358.3,15380,2)
 ;;=^5032747
 ;;^UTILITY(U,$J,358.3,15381,0)
 ;;=S61.203A^^85^817^23
 ;;^UTILITY(U,$J,358.3,15381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15381,1,3,0)
 ;;=3^Open Wound of Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,15381,1,4,0)
 ;;=4^S61.203A

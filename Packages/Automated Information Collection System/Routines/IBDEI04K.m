IBDEI04K ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4303,1,3,0)
 ;;=3^Open Wound of Right Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,4303,1,4,0)
 ;;=4^S61.501A
 ;;^UTILITY(U,$J,358.3,4303,2)
 ;;=^5033020
 ;;^UTILITY(U,$J,358.3,4304,0)
 ;;=S61.502A^^30^313^30
 ;;^UTILITY(U,$J,358.3,4304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4304,1,3,0)
 ;;=3^Open Wound of Left Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,4304,1,4,0)
 ;;=4^S61.502A
 ;;^UTILITY(U,$J,358.3,4304,2)
 ;;=^5033023
 ;;^UTILITY(U,$J,358.3,4305,0)
 ;;=S61.401A^^30^313^43
 ;;^UTILITY(U,$J,358.3,4305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4305,1,3,0)
 ;;=3^Open Wound of Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,4305,1,4,0)
 ;;=4^S61.401A
 ;;^UTILITY(U,$J,358.3,4305,2)
 ;;=^5032981
 ;;^UTILITY(U,$J,358.3,4306,0)
 ;;=S61.402A^^30^313^12
 ;;^UTILITY(U,$J,358.3,4306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4306,1,3,0)
 ;;=3^Open Wound of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,4306,1,4,0)
 ;;=4^S61.402A
 ;;^UTILITY(U,$J,358.3,4306,2)
 ;;=^5032984
 ;;^UTILITY(U,$J,358.3,4307,0)
 ;;=S61.001A^^30^313^60
 ;;^UTILITY(U,$J,358.3,4307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4307,1,3,0)
 ;;=3^Open Wound of Right Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4307,1,4,0)
 ;;=4^S61.001A
 ;;^UTILITY(U,$J,358.3,4307,2)
 ;;=^5032684
 ;;^UTILITY(U,$J,358.3,4308,0)
 ;;=S61.002A^^30^313^29
 ;;^UTILITY(U,$J,358.3,4308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4308,1,3,0)
 ;;=3^Open Wound of Left Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4308,1,4,0)
 ;;=4^S61.002A
 ;;^UTILITY(U,$J,358.3,4308,2)
 ;;=^5032687
 ;;^UTILITY(U,$J,358.3,4309,0)
 ;;=S61.101A^^30^313^59
 ;;^UTILITY(U,$J,358.3,4309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4309,1,3,0)
 ;;=3^Open Wound of Right Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4309,1,4,0)
 ;;=4^S61.101A
 ;;^UTILITY(U,$J,358.3,4309,2)
 ;;=^5032723
 ;;^UTILITY(U,$J,358.3,4310,0)
 ;;=S61.102A^^30^313^28
 ;;^UTILITY(U,$J,358.3,4310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4310,1,3,0)
 ;;=3^Open Wound of Left Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4310,1,4,0)
 ;;=4^S61.102A
 ;;^UTILITY(U,$J,358.3,4310,2)
 ;;=^5135687
 ;;^UTILITY(U,$J,358.3,4311,0)
 ;;=S61.200A^^30^313^46
 ;;^UTILITY(U,$J,358.3,4311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4311,1,3,0)
 ;;=3^Open Wound of Right Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4311,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,4311,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,4312,0)
 ;;=S61.201A^^30^313^15
 ;;^UTILITY(U,$J,358.3,4312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4312,1,3,0)
 ;;=3^Open Wound of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4312,1,4,0)
 ;;=4^S61.201A
 ;;^UTILITY(U,$J,358.3,4312,2)
 ;;=^5032744
 ;;^UTILITY(U,$J,358.3,4313,0)
 ;;=S61.202A^^30^313^54
 ;;^UTILITY(U,$J,358.3,4313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4313,1,3,0)
 ;;=3^Open Wound of Right Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4313,1,4,0)
 ;;=4^S61.202A
 ;;^UTILITY(U,$J,358.3,4313,2)
 ;;=^5032747
 ;;^UTILITY(U,$J,358.3,4314,0)
 ;;=S61.203A^^30^313^23
 ;;^UTILITY(U,$J,358.3,4314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4314,1,3,0)
 ;;=3^Open Wound of Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4314,1,4,0)
 ;;=4^S61.203A
 ;;^UTILITY(U,$J,358.3,4314,2)
 ;;=^5032750
 ;;^UTILITY(U,$J,358.3,4315,0)
 ;;=S61.204A^^30^313^56
 ;;^UTILITY(U,$J,358.3,4315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4315,1,3,0)
 ;;=3^Open Wound of Right Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4315,1,4,0)
 ;;=4^S61.204A
 ;;^UTILITY(U,$J,358.3,4315,2)
 ;;=^5032753
 ;;^UTILITY(U,$J,358.3,4316,0)
 ;;=S61.205A^^30^313^25
 ;;^UTILITY(U,$J,358.3,4316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4316,1,3,0)
 ;;=3^Open Wound of Left Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4316,1,4,0)
 ;;=4^S61.205A
 ;;^UTILITY(U,$J,358.3,4316,2)
 ;;=^5032756
 ;;^UTILITY(U,$J,358.3,4317,0)
 ;;=S61.206A^^30^313^51
 ;;^UTILITY(U,$J,358.3,4317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4317,1,3,0)
 ;;=3^Open Wound of Right Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4317,1,4,0)
 ;;=4^S61.206A
 ;;^UTILITY(U,$J,358.3,4317,2)
 ;;=^5032759
 ;;^UTILITY(U,$J,358.3,4318,0)
 ;;=S61.207A^^30^313^20
 ;;^UTILITY(U,$J,358.3,4318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4318,1,3,0)
 ;;=3^Open Wound of Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4318,1,4,0)
 ;;=4^S61.207A
 ;;^UTILITY(U,$J,358.3,4318,2)
 ;;=^5032762
 ;;^UTILITY(U,$J,358.3,4319,0)
 ;;=S61.300A^^30^313^45
 ;;^UTILITY(U,$J,358.3,4319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4319,1,3,0)
 ;;=3^Open Wound of Right Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4319,1,4,0)
 ;;=4^S61.300A
 ;;^UTILITY(U,$J,358.3,4319,2)
 ;;=^5032891
 ;;^UTILITY(U,$J,358.3,4320,0)
 ;;=S61.301A^^30^313^14
 ;;^UTILITY(U,$J,358.3,4320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4320,1,3,0)
 ;;=3^Open Wound of Left Index Finger w/ Damage to Nail,Init Encntr
 ;;^UTILITY(U,$J,358.3,4320,1,4,0)
 ;;=4^S61.301A
 ;;^UTILITY(U,$J,358.3,4320,2)
 ;;=^5135735
 ;;^UTILITY(U,$J,358.3,4321,0)
 ;;=S61.302A^^30^313^53
 ;;^UTILITY(U,$J,358.3,4321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4321,1,3,0)
 ;;=3^Open Wound of Right Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4321,1,4,0)
 ;;=4^S61.302A
 ;;^UTILITY(U,$J,358.3,4321,2)
 ;;=^5032894
 ;;^UTILITY(U,$J,358.3,4322,0)
 ;;=S61.303A^^30^313^22
 ;;^UTILITY(U,$J,358.3,4322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4322,1,3,0)
 ;;=3^Open Wound of Left Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4322,1,4,0)
 ;;=4^S61.303A
 ;;^UTILITY(U,$J,358.3,4322,2)
 ;;=^5135738
 ;;^UTILITY(U,$J,358.3,4323,0)
 ;;=S61.304A^^30^313^55
 ;;^UTILITY(U,$J,358.3,4323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4323,1,3,0)
 ;;=3^Open Wound of Right Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4323,1,4,0)
 ;;=4^S61.304A
 ;;^UTILITY(U,$J,358.3,4323,2)
 ;;=^5032897
 ;;^UTILITY(U,$J,358.3,4324,0)
 ;;=S61.305A^^30^313^24
 ;;^UTILITY(U,$J,358.3,4324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4324,1,3,0)
 ;;=3^Open Wound of Left Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4324,1,4,0)
 ;;=4^S61.305A
 ;;^UTILITY(U,$J,358.3,4324,2)
 ;;=^5135741
 ;;^UTILITY(U,$J,358.3,4325,0)
 ;;=S61.306A^^30^313^50
 ;;^UTILITY(U,$J,358.3,4325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4325,1,3,0)
 ;;=3^Open Wound of Right Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4325,1,4,0)
 ;;=4^S61.306A
 ;;^UTILITY(U,$J,358.3,4325,2)
 ;;=^5032900
 ;;^UTILITY(U,$J,358.3,4326,0)
 ;;=S61.307A^^30^313^19
 ;;^UTILITY(U,$J,358.3,4326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4326,1,3,0)
 ;;=3^Open Wound of Left Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4326,1,4,0)
 ;;=4^S61.307A
 ;;^UTILITY(U,$J,358.3,4326,2)
 ;;=^5135744
 ;;^UTILITY(U,$J,358.3,4327,0)
 ;;=S71.102A^^30^313^27
 ;;^UTILITY(U,$J,358.3,4327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4327,1,3,0)
 ;;=3^Open Wound of Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,4327,1,4,0)
 ;;=4^S71.102A
 ;;^UTILITY(U,$J,358.3,4327,2)
 ;;=^5037011
 ;;^UTILITY(U,$J,358.3,4328,0)
 ;;=S71.101A^^30^313^58
 ;;^UTILITY(U,$J,358.3,4328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4328,1,3,0)
 ;;=3^Open Wound of Right Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,4328,1,4,0)
 ;;=4^S71.101A
 ;;^UTILITY(U,$J,358.3,4328,2)
 ;;=^5037008
 ;;^UTILITY(U,$J,358.3,4329,0)
 ;;=S71.002A^^30^313^13
 ;;^UTILITY(U,$J,358.3,4329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4329,1,3,0)
 ;;=3^Open Wound of Left Hip,Init Encntr

IBDEI054 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4850,1,3,0)
 ;;=3^Open Bite of Nose,Init Encntr
 ;;^UTILITY(U,$J,358.3,4850,1,4,0)
 ;;=4^S01.25XA
 ;;^UTILITY(U,$J,358.3,4850,2)
 ;;=^5020105
 ;;^UTILITY(U,$J,358.3,4851,0)
 ;;=S01.85XA^^30^325^1
 ;;^UTILITY(U,$J,358.3,4851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4851,1,3,0)
 ;;=3^Open Bite of Head,Oth Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,4851,1,4,0)
 ;;=4^S01.85XA
 ;;^UTILITY(U,$J,358.3,4851,2)
 ;;=^5020237
 ;;^UTILITY(U,$J,358.3,4852,0)
 ;;=S11.85XA^^30^325^32
 ;;^UTILITY(U,$J,358.3,4852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4852,1,3,0)
 ;;=3^Open Bite of Neck,Oth Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,4852,1,4,0)
 ;;=4^S11.85XA
 ;;^UTILITY(U,$J,358.3,4852,2)
 ;;=^5021521
 ;;^UTILITY(U,$J,358.3,4853,0)
 ;;=S91.051A^^30^325^37
 ;;^UTILITY(U,$J,358.3,4853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4853,1,3,0)
 ;;=3^Open Bite of Right Ankle,Init Encntr
 ;;^UTILITY(U,$J,358.3,4853,1,4,0)
 ;;=4^S91.051A
 ;;^UTILITY(U,$J,358.3,4853,2)
 ;;=^5044159
 ;;^UTILITY(U,$J,358.3,4854,0)
 ;;=S31.815A^^30^325^38
 ;;^UTILITY(U,$J,358.3,4854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4854,1,3,0)
 ;;=3^Open Bite of Right Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,4854,1,4,0)
 ;;=4^S31.815A
 ;;^UTILITY(U,$J,358.3,4854,2)
 ;;=^5024305
 ;;^UTILITY(U,$J,358.3,4855,0)
 ;;=S01.451A^^30^325^39
 ;;^UTILITY(U,$J,358.3,4855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4855,1,3,0)
 ;;=3^Open Bite of Right Cheek/Temporomandibular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,4855,1,4,0)
 ;;=4^S01.451A
 ;;^UTILITY(U,$J,358.3,4855,2)
 ;;=^5020177
 ;;^UTILITY(U,$J,358.3,4856,0)
 ;;=S01.351A^^30^325^40
 ;;^UTILITY(U,$J,358.3,4856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4856,1,3,0)
 ;;=3^Open Bite of Right Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,4856,1,4,0)
 ;;=4^S01.351A
 ;;^UTILITY(U,$J,358.3,4856,2)
 ;;=^5020138
 ;;^UTILITY(U,$J,358.3,4857,0)
 ;;=S51.051A^^30^325^41
 ;;^UTILITY(U,$J,358.3,4857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4857,1,3,0)
 ;;=3^Open Bite of Right Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,4857,1,4,0)
 ;;=4^S51.051A
 ;;^UTILITY(U,$J,358.3,4857,2)
 ;;=^5028650
 ;;^UTILITY(U,$J,358.3,4858,0)
 ;;=S91.351A^^30^325^42
 ;;^UTILITY(U,$J,358.3,4858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4858,1,3,0)
 ;;=3^Open Bite of Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,4858,1,4,0)
 ;;=4^S91.351A
 ;;^UTILITY(U,$J,358.3,4858,2)
 ;;=^5044344
 ;;^UTILITY(U,$J,358.3,4859,0)
 ;;=S91.251A^^30^325^43
 ;;^UTILITY(U,$J,358.3,4859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4859,1,3,0)
 ;;=3^Open Bite of Right Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4859,1,4,0)
 ;;=4^S91.251A
 ;;^UTILITY(U,$J,358.3,4859,2)
 ;;=^5044305
 ;;^UTILITY(U,$J,358.3,4860,0)
 ;;=S61.451A^^30^325^44
 ;;^UTILITY(U,$J,358.3,4860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4860,1,3,0)
 ;;=3^Open Bite of Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,4860,1,4,0)
 ;;=4^S61.451A
 ;;^UTILITY(U,$J,358.3,4860,2)
 ;;=^5033011
 ;;^UTILITY(U,$J,358.3,4861,0)
 ;;=S71.051A^^30^325^45
 ;;^UTILITY(U,$J,358.3,4861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4861,1,3,0)
 ;;=3^Open Bite of Right Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,4861,1,4,0)
 ;;=4^S71.051A
 ;;^UTILITY(U,$J,358.3,4861,2)
 ;;=^5036999
 ;;^UTILITY(U,$J,358.3,4862,0)
 ;;=S61.350A^^30^325^46
 ;;^UTILITY(U,$J,358.3,4862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4862,1,3,0)
 ;;=3^Open Bite of Right Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4862,1,4,0)
 ;;=4^S61.350A
 ;;^UTILITY(U,$J,358.3,4862,2)
 ;;=^5032966
 ;;^UTILITY(U,$J,358.3,4863,0)
 ;;=S61.250A^^30^325^47
 ;;^UTILITY(U,$J,358.3,4863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4863,1,3,0)
 ;;=3^Open Bite of Right Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4863,1,4,0)
 ;;=4^S61.250A
 ;;^UTILITY(U,$J,358.3,4863,2)
 ;;=^5032861
 ;;^UTILITY(U,$J,358.3,4864,0)
 ;;=S81.051A^^30^325^48
 ;;^UTILITY(U,$J,358.3,4864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4864,1,3,0)
 ;;=3^Open Bite of Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,4864,1,4,0)
 ;;=4^S81.051A
 ;;^UTILITY(U,$J,358.3,4864,2)
 ;;=^5040056
 ;;^UTILITY(U,$J,358.3,4865,0)
 ;;=S91.254A^^30^325^49
 ;;^UTILITY(U,$J,358.3,4865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4865,1,3,0)
 ;;=3^Open Bite of Right Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4865,1,4,0)
 ;;=4^S91.254A
 ;;^UTILITY(U,$J,358.3,4865,2)
 ;;=^5044308
 ;;^UTILITY(U,$J,358.3,4866,0)
 ;;=S91.154A^^30^325^50
 ;;^UTILITY(U,$J,358.3,4866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4866,1,3,0)
 ;;=3^Open Bite of Right Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4866,1,4,0)
 ;;=4^S91.154A
 ;;^UTILITY(U,$J,358.3,4866,2)
 ;;=^5044252
 ;;^UTILITY(U,$J,358.3,4867,0)
 ;;=S61.356A^^30^325^51
 ;;^UTILITY(U,$J,358.3,4867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4867,1,3,0)
 ;;=3^Open Bite of Right Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4867,1,4,0)
 ;;=4^S61.356A
 ;;^UTILITY(U,$J,358.3,4867,2)
 ;;=^5032975
 ;;^UTILITY(U,$J,358.3,4868,0)
 ;;=S61.256A^^30^325^52
 ;;^UTILITY(U,$J,358.3,4868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4868,1,3,0)
 ;;=3^Open Bite of Right Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4868,1,4,0)
 ;;=4^S61.256A
 ;;^UTILITY(U,$J,358.3,4868,2)
 ;;=^5032879
 ;;^UTILITY(U,$J,358.3,4869,0)
 ;;=S81.851A^^30^325^53
 ;;^UTILITY(U,$J,358.3,4869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4869,1,3,0)
 ;;=3^Open Bite of Right Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,4869,1,4,0)
 ;;=4^S81.851A
 ;;^UTILITY(U,$J,358.3,4869,2)
 ;;=^5040095
 ;;^UTILITY(U,$J,358.3,4870,0)
 ;;=S61.352A^^30^325^54
 ;;^UTILITY(U,$J,358.3,4870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4870,1,3,0)
 ;;=3^Open Bite of Right Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4870,1,4,0)
 ;;=4^S61.352A
 ;;^UTILITY(U,$J,358.3,4870,2)
 ;;=^5032969
 ;;^UTILITY(U,$J,358.3,4871,0)
 ;;=S61.252A^^30^325^55
 ;;^UTILITY(U,$J,358.3,4871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4871,1,3,0)
 ;;=3^Open Bite of Right Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4871,1,4,0)
 ;;=4^S61.252A
 ;;^UTILITY(U,$J,358.3,4871,2)
 ;;=^5032867
 ;;^UTILITY(U,$J,358.3,4872,0)
 ;;=S61.354A^^30^325^56
 ;;^UTILITY(U,$J,358.3,4872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4872,1,3,0)
 ;;=3^Open Bite of Right Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4872,1,4,0)
 ;;=4^S61.354A
 ;;^UTILITY(U,$J,358.3,4872,2)
 ;;=^5032972
 ;;^UTILITY(U,$J,358.3,4873,0)
 ;;=S61.254A^^30^325^57
 ;;^UTILITY(U,$J,358.3,4873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4873,1,3,0)
 ;;=3^Open Bite of Right Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4873,1,4,0)
 ;;=4^S61.254A
 ;;^UTILITY(U,$J,358.3,4873,2)
 ;;=^5032873
 ;;^UTILITY(U,$J,358.3,4874,0)
 ;;=S41.051A^^30^325^58
 ;;^UTILITY(U,$J,358.3,4874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4874,1,3,0)
 ;;=3^Open Bite of Right Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,4874,1,4,0)
 ;;=4^S41.051A
 ;;^UTILITY(U,$J,358.3,4874,2)
 ;;=^5026321
 ;;^UTILITY(U,$J,358.3,4875,0)
 ;;=S71.151A^^30^325^59
 ;;^UTILITY(U,$J,358.3,4875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4875,1,3,0)
 ;;=3^Open Bite of Right Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,4875,1,4,0)
 ;;=4^S71.151A
 ;;^UTILITY(U,$J,358.3,4875,2)
 ;;=^5037038
 ;;^UTILITY(U,$J,358.3,4876,0)
 ;;=S61.151A^^30^325^60
 ;;^UTILITY(U,$J,358.3,4876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4876,1,3,0)
 ;;=3^Open Bite of Right Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,4876,1,4,0)
 ;;=4^S61.151A
 ;;^UTILITY(U,$J,358.3,4876,2)
 ;;=^5032738
 ;;^UTILITY(U,$J,358.3,4877,0)
 ;;=S61.051A^^30^325^61
